# R2R DAC Layout/Schematic Generator — Design

## Goal

A Python script that generates a parametric R2R resistor-ladder layout
(`.mag`) and matching xschem schematic (`.sch`) for an arbitrary number of
taps `n`, based on the existing 8-tap reference design in
`mag/r2r-generator/r2r.mag` and `mag/r2r-generator/r2r.sch`.

Out of scope (for later, separate work):
- Generating `r2r.spice` (done by the user via xschem)
- Running magic DRC as part of generation
- External LVS automation

## Reference design analysis (n=8)

`r2r.mag` contains `3n+3 = 27` resistor instances of
`sky130_fd_pr__res_high_po_1p41` (vertical orientation, same shape as
`sky130_fd_pr__res_high_po_1p41_NAL9NH.mag`), arranged in a single row.

Indexing resistors `i = -1 .. 3n+1` (27 values for n=8: -1..25), each
resistor occupies x ∈ `[500i, 500i+282]`, y ∈ `[600, 10432]`
(top contact pad ≈ y 10000-10432, bottom contact pad ≈ y 600-1032).

- `i = -1`: left dummy resistor (VGND-VGND-VGND)
- `i = 0..3`: "start" group — bit0's 2R pair + the ground-return 2R pair
  (equivalent of R1-R4 in the n=8 netlist)
- `i = 3k+1, 3k+2, 3k+3` for `k = 1..(n-1)`: "bit tile" — 1 chain resistor
  (solo, routed top→down to mid-rail) + a 2R pair, repeating every 1500
  layout units, **identical geometry for every k** (only the x-offset
  changes)
- `i = 3n+1`: right dummy resistor (VGND-VGND-VGND)

Total = 5 (start group + left dummy) + 3*(n-1) (bit tiles) + 1 (right
dummy) = `3n+3`. ✓ matches 27 for n=8.

Guard ring (psubdiff/psubdiffcont/locali/viali/metal1):
- Left edge fixed at x = -1010 (independent of n)
- Right edge = `1500n + 1300`
- Top/bottom y fixed (height 10800), independent of n
- Left bar+corners are fixed-position (bundled with the start group)
- Right bar+corners are fixed *relative to* the right dummy resistor
  (bundled with the end group, which translates with n)
- Only the top bar (and matching bottom corner pieces) have a length that
  depends on n — drawn by the top-level generator

## Architecture: 4 building blocks

| Block | Resistors | Depends on n? | Form |
|---|---|---|---|
| `r2r_startmod.mag` | i = -1..3 (5) | No | Fixed sub-cell, fixed absolute placement |
| `r2r_bittile.mag` | 3 per tile | No | Fixed sub-cell, instantiated via magic `array` (n-1 copies, 1500-unit pitch) |
| `r2r_endmod.mag` | i = 3n+1 (1) | Placement only | Fixed sub-cell, placed at x = `1500n + 500 - 12500` relative to its n=8 position |
| `r2r_<n>.mag` (top-level) | 0 (no resistors directly) | Yes | Generated per-n: instantiates the above 3 cells, draws the n-dependent guard-ring top bar, and places port/net flabels |

The fixed sub-cells (`r2r_startmod.mag`, `r2r_bittile.mag`,
`r2r_endmod.mag`) and `sky130_fd_pr__res_high_po_1p41_NAL9NH.mag` are
extracted once from the n=8 reference geometry and checked into the repo as
static files. `generate_r2r.py` does not regenerate them.

### Top-level generator (`r2r_<n>.mag`) emits:

1. `use r2r_startmod ...` at fixed transform
2. `use r2r_bittile ...` with `array 1 (n-1) 1500 0 0 ...`
3. `use r2r_endmod ...` at transform x = `1500n + 500 - 12500`
4. Guard-ring top bar rects sized to span `[-1010, 1500n+1300]`
5. flabels/ports for `b0..b(n-1)`, `out`, `VGND`
6. Auto-generated internal chain-node labels for the n-1 internal R-2R chain
   nodes (e.g. `net_a0..net_a(n-2)`), placed at the corresponding bittile
   x-offsets — labels live in the top-level cell even though the metal
   geometry is in the sub-cells; this works for magic LVS extraction since
   it flattens hierarchy.

## Schematic (`.sch`) generation

The xschem schematic format is flat (absolute coordinates, no
sub-schematic hierarchy needed for this). The generator mirrors the same
start/bit-tile/end decomposition conceptually but writes one `.sch` file:

- **Start group**: ground-return resistor pair + bit0's 2R pair + left
  dummy, at fixed coordinates (matches the R1-R4/R26-equivalent region of
  the existing `r2r.sch`).
- **Bit tile** (k = 1..n-1): 3 resistor instances (2R pair + chain-R) at
  x-offset = `base + step*k` (step ≈ 250, matching the existing grid),
  with wires connecting `b{k}`, the chain nodes, and VGND.
- **End**: the last bit tile's chain-R connects to `out` (opin) instead of
  an internal chain label; right dummy resistor (VGND-VGND-VGND) appended.
- Resistor instance names (`R1, R2, ...`) renumbered sequentially. Internal
  chain net labels auto-generated (`a, b, c, ...`, falling back to
  `net_a0...` for n > 26).
- Pins: `ipin` for `b0..b(n-1)`, `opin` for `out`, `lab_pin`/`iopin` for
  `VGND`.

## CLI & outputs

```
python3 generate_r2r.py <n>
```

Writes to `mag/r2r-generator/output/`:
- `r2r_<n>.mag` — top-level layout cell
- `r2r_<n>.sch` — xschem schematic
- `r2r_startmod.mag`, `r2r_bittile.mag`, `r2r_endmod.mag`,
  `sky130_fd_pr__res_high_po_1p41_NAL9NH.mag` — copied static sub-cells
  (so `output/` is self-contained for magic)

Top-level cell/subckt name = `r2r_<n>` (derived from filename, per magic
and xschem convention — no extra handling needed).

## Validation plan

`generate_r2r.py 8` should produce `r2r_8.mag` / `r2r_8.sch` that are
geometrically/topologically equivalent to the existing `r2r.mag` /
`r2r.sch` (rect-for-rect match where reasonable, since the fixed sub-cells
are extracted directly from the n=8 reference). This is the primary
correctness check available without magic/xschem installed locally.

Manual follow-up (by the user, outside this script's scope):
- Open generated `.mag` in magic, run DRC
- Generate `.spice` from `.sch` via xschem
- Run external LVS comparing layout vs schematic-derived netlist
