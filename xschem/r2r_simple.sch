v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 -170 10 -130 {lab=b0}
N 10 -70 10 -60 {lab=out}
N 10 0 10 10 {lab=out}
N 10 70 10 80 {lab=out}
N 10 140 10 190 {lab=VGND}
N 10 0 190 -0 {lab=out}
N 10 -60 10 70 {lab=out}
C {symbols/ppolyf_u_1k.sym} 10 -100 0 0 {name=R1
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 10 110 0 0 {name=R4
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} -10 110 2 1 {name=p4 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} -10 -100 2 1 {name=p5 sig_type=std_logic lab=VGND}
C {devices/iopin.sym} -250 180 0 0 {name=p9 lab=VGND}
C {devices/lab_pin.sym} -250 180 2 1 {name=p10 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 10 -170 0 0 {name=p11 lab=b0}
C {devices/lab_pin.sym} 10 190 2 1 {name=p14 sig_type=std_logic lab=VGND}
C {devices/opin.sym} 190 0 0 0 {name=p13 lab=out}
