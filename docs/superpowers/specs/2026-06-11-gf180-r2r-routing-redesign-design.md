# GF180mcuD R2R DAC Generator — Placement & Routing Redesign

## Goal

Revise `generate_r2r_gf180.py` (built per
`docs/superpowers/specs/2026-06-10-gf180-r2r-generator-design.md`) to fix two
issues observed in the current output:

1. **Dummy resistors (`R_dummy1`/`R_dummy2`) are both placed adjacent at one
   end of the array**, instead of one bookending each end (as in the sky130
   reference design).
2. **Routing channel buses span almost the full array width** and grow with
   `n`, because the placement order groups all `R_top[j]`/`R_bot[j]` pairs
   first (indices `0..2n-1`) and all `R_chain[j]` resistors at the end
   (indices `2n..3n-2`), so chain-node nets must connect a resistor near the
   start of the array to one near the end.

The fix is a new **placement order** — a permutation of `topology(n)`'s
indices onto physical positions `0..3n+2` — that interleaves chain resistors
with their neighboring `R_top`/`R_bot` pairs (sky130-style "bit tile"
locality), so every net's routing span is bounded by a small constant
(~3-4 pitches) regardless of `n`. Combined with this, VGND is rerouted to
connect locally to the guard-ring rail instead of via a full-width channel
bus, and routing trace widths are widened to match the resistor's own poly
trace width.

`topology(n)` (connectivity) and `generate_sch` are **unchanged** — this is a
purely physical redesign. Out of scope: anything from the original spec's
"Out of scope" section, plus DRC/LVS tuning of the new v2 constants (deferred
to the existing manual DRC/LVS iteration pass).

## Placement order

New function `placement_order(n)` returns a list of length `3n+3`:
`placement_order[pos]` = the `topology(n)` index of the resistor placed at
physical position `pos` (i.e. at `x = pos * PITCH`).

Recall `topology(n)` indices:
- `2j` = `R_top[j]`, `2j+1` = `R_bot[j]`, for `j = 0..n-1`
- `2n + j` = `R_chain[j]`, for `j = 0..n-2`
- `3n-1` = `R_gnd_b`, `3n` = `R_gnd_a`
- `3n+1` = `R_dummy1`, `3n+2` = `R_dummy2`

```python
def placement_order(n):
    order = [None] * (3 * n + 3)
    order[0] = 3 * n + 1          # R_dummy1 (left bookend)
    order[1] = 3 * n - 1          # R_gnd_b
    order[2] = 3 * n              # R_gnd_a
    order[3] = 0                  # R_top[0]
    order[4] = 1                  # R_bot[0]
    for k in range(1, n):
        base = 5 + 3 * (k - 1)
        order[base]     = 2 * n + (k - 1)  # R_chain[k-1]
        order[base + 1] = 2 * k            # R_top[k]
        order[base + 2] = 2 * k + 1        # R_bot[k]
    order[3 * n + 2] = 3 * n + 2  # R_dummy2 (right bookend)
    return order
```

### Example: n=4 (positions 0..14)

```
pos:     0       1       2       3      4    | 5         6      7    | 8         9      10   | 11        12     13   | 14
         dummy1  R_gnd_b R_gnd_a R_top0 R_bot0| R_chain0  R_top1 R_bot1| R_chain1  R_top2 R_bot2| R_chain2  R_top3 R_bot3| dummy2
top:     VGND    VGND    net5    net1   a     | b         net2   b    | c         net3   c    | out       net4   out   | VGND
bottom:  VGND    net5    a       b0     net1  |           b1     net2  |           b2    net3  |           b3    net4  | VGND
                                       <--tile1-->                <--tile2-->              <--tile3-->
```

### Net span analysis (general n)

- `net{j+1}` for `j=0..n-1`: `R_top[j]` top + `R_bot[j]` bottom, adjacent —
  **1-pitch jog**.
- `net{n+1}`: `R_gnd_b` bottom + `R_gnd_a` top, adjacent — **1-pitch jog**.
- `chain(j)` for `j=0..n-2`: appears as `R_bot[j]` top, `R_chain[j]` bottom,
  and (for `j>=1`) `R_chain[j-1]` top. Spans **3 pitches**, both channels —
  needs a jog.
  - Special case `chain(0)="a"`: also appears as `R_gnd_a` bottom (instead of
    `R_chain[-1]` top). Still spans 3 pitches (positions 2, 4, 5).
- `chain(n-1)="out"`: appears as `R_chain[n-2]` top + `R_bot[n-1]` top —
  **2-pitch span, top channel only**, no jog.
- `b{j}` ports: single occurrence, unchanged.
- `VGND`: handled separately — see below.

Every span is **O(1)**, independent of `n`.

## Impact on existing functions

**Unchanged:**
- `topology(n)` — connectivity source of truth, untouched.
- `generate_sch` — schematic generation is independent of physical placement.
- `stub_center(pos)`, `gap_jog_x(g)`, `top_track_y`, `bottom_track_y`,
  `riser_rects`, `bus_rect`, `jog_rects`, `assign_tracks`, `rail_extent` —
  all already operate on physical positions / abstract spans, not topology
  indices.

**Changed:**
- `place_resistors(n)`: for each physical position `pos` (0..3n+2), place
  `r2r_res_<placement_order[pos]>` (instance names keep their topology index
  for traceability) at `x = pos * PITCH`.
- `net_occurrences(n)`: build `pos_of = {topo_idx: pos for pos, topo_idx in
  enumerate(placement_order(n))}`, and for each `(i, (top_net, bot_net))` in
  `enumerate(topology(n))`, use `stub_center(pos_of[i])` instead of
  `stub_center(i)`.
- `first_occurrence_landing(n, net)` / `port_label_lines(n)`: same `pos_of`
  remapping when locating a net's landing pad. (VGND's port label is handled
  separately — see below.)
- `channel_spans(n)` / `assign_jogs(n, occ)`: exclude `"VGND"` — it no longer
  participates in channel routing.
- `resistor_stub_lines(n)`: now VGND-aware (see below).
- `vgnd_rail_taps` and its call site in `build_layers`: **removed**.

## VGND / guard ring: local rail connection

VGND no longer gets a channel bus, jog, or track. Instead, every VGND pad
connects directly to the adjacent guard-ring rail via a single extended
metal1 rect (same layer as the rail — direct overlap, no via).

**VGND pads** (always exactly 5, regardless of `n`):
- `R_dummy1` (position 0): top pad + bottom pad
- `R_gnd_b` (position 1): top pad only
- `R_dummy2` (position `3n+2`): top pad + bottom pad

New helper `vgnd_pads(n)` returns this set as `{(pos, "top"|"bottom"), ...}`,
derived from `placement_order(n)` + `topology(n)`.

`resistor_stub_lines(n)` becomes VGND-aware:
- For pads in `vgnd_pads(n)`: emit a single `metal1` rect from the pad edge
  to the rail edge — `(scx-200, 5109, scx+200, 5262)` for a top pad,
  `(scx-200, -5262, scx+200, -5109)` for a bottom pad (width = `STUB_W`,
  using new v2 constants below). No `metal2`/`via1` for these pads.
- For all other pads: existing stub (metal1) + landing (metal2) + via1
  geometry, unchanged in form (just using new v2 constants).

`port_label_lines(n)`: the `VGND` port label moves to `metal1`, anchored on
the top guard-ring rail rect (`flabel metal1 <rail x-range> ... VGND`) —
this is valid for any `n` since the rail is one continuous metal1 shape
spanning the whole array. All other ports keep `flabel metal2 ...` on their
landing pads at the new placement positions.

## v2 routing constants

| Constant | v1 | v2 | Rationale |
|---|---|---|---|
| `STUB_W` | 120 | **400** | matches resistor poly trace width (`W=2e-6` = 2um = 400 units) |
| `RISER_W` | 60 | **400** | same |
| `TRACK_H` | 60 | **400** | channel tracks are "wide traces" too |
| `TRACK_PITCH` | 100 | **450** | `TRACK_H` + 50 spacing between stacked tracks |
| `VIA1_W` | 80 | **360** | scales with `STUB_W`, keeps 20-unit enclosure margin |
| `LANDING_H`, `VIA1_H`, `VIA2_SIZE`, `STUB_EXT`, `TRACK_GAP` | 70/50/30/90/30 | unchanged | lengths/enclosures, not trace widths |

These remain v1/v2 *estimates*, per the original spec's DRC-tuning plan —
final values are adjusted during the manual magic DRC/LVS pass.

## Validation plan

1. **`placement_order(n)`**: unit tests for `n=2,4,8` — correct length
   (`3n+3`), correct values at fixed positions (0-4 and `3n+2`), correct
   tile pattern for `k=1..n-1`, and that it's a permutation of
   `range(3n+3)`.
2. **Net span bounds**: a parametrized test over `n in (2,4,8,16)` asserting
   every net's occurrence span (top+bottom combined, in pitch units) is `<=
   4` — i.e. independent of `n`. (Catches regressions to the old
   full-array-width spans.)
3. **`vgnd_pads(n)`**: unit test confirming the 5-pad set described above for
   several `n`.
4. **Updated existing tests**: `test_net_occurrences_n2`,
   `test_assign_jogs_n2`, `test_resistor_stub_lines_n2`,
   `test_build_layers_n2_structure`, `test_first_occurrence_landing_n2`,
   `test_generate_mag_structure_n2`, `test_generate_mag_ports_n2_n8` all need
   their expected values recomputed against the new `placement_order` and v2
   constants.
5. **Dummy bookend check**: assert `placement_order(n)[0] == 3*n+1` and
   `placement_order(n)[-1] == 3*n+2` for several `n` — i.e. one dummy on each
   end.
6. **Manual**: re-run the magic DRC/extract/LVS pass (per the original
   spec's validation plan) on the regenerated layout for at least `n=2` and
   `n=8`.
