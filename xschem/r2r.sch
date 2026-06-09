v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 430 1090 430 1130 {lab=b0}
N 430 1190 430 1200 {lab=#net1}
N 430 1260 430 1270 {lab=#net2}
N 430 1330 430 1340 {lab=#net3}
N 430 1400 430 1450 {lab=VGND}
N 430 1260 620 1260 {lab=#net2}
N 680 1260 790 1260 {lab=#net4}
N 790 1260 930 1260 {lab=#net4}
N 790 1090 790 1130 {lab=b1}
N 790 1190 790 1200 {lab=#net5}
N 990 1260 1100 1260 {lab=#net6}
N 1100 1260 1240 1260 {lab=#net6}
N 1100 1090 1100 1130 {lab=b2}
N 1100 1190 1100 1200 {lab=#net7}
N 1300 1260 1410 1260 {lab=#net8}
N 1410 1260 1550 1260 {lab=#net8}
N 1410 1090 1410 1130 {lab=b3}
N 1410 1190 1410 1200 {lab=#net9}
N 1610 1260 1720 1260 {lab=#net10}
N 1720 1260 1860 1260 {lab=#net10}
N 1720 1090 1720 1130 {lab=b4}
N 1720 1190 1720 1200 {lab=#net11}
N 1920 1260 2030 1260 {lab=#net12}
N 2030 1260 2170 1260 {lab=#net12}
N 2030 1090 2030 1130 {lab=b5}
N 2030 1190 2030 1200 {lab=#net13}
N 2230 1260 2340 1260 {lab=#net14}
N 2340 1260 2480 1260 {lab=#net14}
N 2340 1090 2340 1130 {lab=b6}
N 2340 1190 2340 1200 {lab=#net15}
N 2540 1260 2650 1260 {lab=out}
N 2650 1260 2790 1260 {lab=out}
N 2650 1090 2650 1130 {lab=b7}
N 2650 1190 2650 1200 {lab=#net16}
C {symbols/ppolyf_u_1k.sym} 430 1160 0 0 {name=R1
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 430 1230 0 0 {name=R2
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 430 1300 0 0 {name=R3
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 430 1370 0 0 {name=R4
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 650 1260 3 0 {name=R5
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 790 1160 0 0 {name=R6
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 790 1230 0 0 {name=R7
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 410 1230 2 1 {name=p2 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 410 1300 2 1 {name=p3 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 410 1370 2 1 {name=p4 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 410 1160 2 1 {name=p5 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 650 1280 1 1 {name=p6 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 770 1160 2 1 {name=p7 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 770 1230 2 1 {name=p8 sig_type=std_logic lab=VGND}
C {devices/iopin.sym} 170 1440 0 0 {name=p9 lab=VGND}
C {devices/lab_pin.sym} 170 1440 2 1 {name=p10 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 430 1090 0 0 {name=p11 lab=b0}
C {devices/ipin.sym} 790 1090 0 0 {name=p12 lab=b1}
C {devices/opin.sym} 2790 1260 0 0 {name=p13 lab=out}
C {devices/lab_pin.sym} 430 1450 2 1 {name=p14 sig_type=std_logic lab=VGND}
C {symbols/ppolyf_u_1k.sym} 960 1260 3 0 {name=R8
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1100 1160 0 0 {name=R9
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1100 1230 0 0 {name=R10
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 960 1280 1 1 {name=p15 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1080 1160 2 1 {name=p16 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1080 1230 2 1 {name=p17 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 1100 1090 0 0 {name=p18 lab=b2}
C {symbols/ppolyf_u_1k.sym} 1270 1260 3 0 {name=R11
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1410 1160 0 0 {name=R12
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1410 1230 0 0 {name=R13
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 1270 1280 1 1 {name=p19 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1390 1160 2 1 {name=p20 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1390 1230 2 1 {name=p21 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 1410 1090 0 0 {name=p22 lab=b3}
C {symbols/ppolyf_u_1k.sym} 1580 1260 3 0 {name=R14
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1720 1160 0 0 {name=R15
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1720 1230 0 0 {name=R16
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 1580 1280 1 1 {name=p23 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1700 1160 2 1 {name=p24 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 1700 1230 2 1 {name=p25 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 1720 1090 0 0 {name=p26 lab=b4}
C {symbols/ppolyf_u_1k.sym} 1890 1260 3 0 {name=R17
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2030 1160 0 0 {name=R18
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2030 1230 0 0 {name=R19
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 1890 1280 1 1 {name=p27 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2010 1160 2 1 {name=p28 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2010 1230 2 1 {name=p29 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 2030 1090 0 0 {name=p30 lab=b5}
C {symbols/ppolyf_u_1k.sym} 2200 1260 3 0 {name=R20
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2340 1160 0 0 {name=R21
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2340 1230 0 0 {name=R22
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 2200 1280 1 1 {name=p31 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2320 1160 2 1 {name=p32 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2320 1230 2 1 {name=p33 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 2340 1090 0 0 {name=p34 lab=b6}
C {symbols/ppolyf_u_1k.sym} 2510 1260 3 0 {name=R23
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2650 1160 0 0 {name=R24
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 2650 1230 0 0 {name=R25
W=2e-6
L=50e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 2510 1280 1 1 {name=p35 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2630 1160 2 1 {name=p36 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 2630 1230 2 1 {name=p37 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 2650 1090 0 0 {name=p38 lab=b7}
