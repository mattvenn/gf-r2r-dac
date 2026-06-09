v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 180 -100 980 300 {flags=graph
y1=-0.50812758
y2=4.7471295
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out
color=4
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1148723968}
B 2 180 -580 980 -180 {flags=graph
y1=0
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
color="4 6"
node="b6
b7"}
B 2 180 400 980 800 {flags=graph
y1=1.9e-05
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="out2
"
color=7
dataset=-1
unitx=1
logx=0
logy=0
}
T {Simulation} 180 -170 0 0 1 1 {}
T {Bit 6 and 7} 170 -660 0 0 1 1 {}
T {Post layout simulation} 180 320 0 0 1 1 {}
N -70 -530 -70 -510 {
lab=GND}
N -100 -610 -70 -610 {
lab=b3}
N -70 -610 -70 -590 {
lab=b3}
N -190 -530 -190 -510 {
lab=GND}
N -220 -610 -190 -610 {
lab=b2}
N -190 -610 -190 -590 {
lab=b2}
N -300 -530 -300 -510 {
lab=GND}
N -330 -610 -300 -610 {
lab=b1}
N -300 -610 -300 -590 {
lab=b1}
N -420 -530 -420 -510 {
lab=GND}
N -450 -610 -420 -610 {
lab=b0}
N -420 -610 -420 -590 {
lab=b0}
N -70 -340 -70 -320 {
lab=GND}
N -100 -420 -70 -420 {
lab=b7}
N -70 -420 -70 -400 {
lab=b7}
N -190 -340 -190 -320 {
lab=GND}
N -220 -420 -190 -420 {
lab=b6}
N -190 -420 -190 -400 {
lab=b6}
N -300 -340 -300 -320 {
lab=GND}
N -330 -420 -300 -420 {
lab=b5}
N -300 -420 -300 -400 {
lab=b5}
N -420 -340 -420 -320 {
lab=GND}
N -450 -420 -420 -420 {
lab=b4}
N -420 -420 -420 -400 {
lab=b4}
N -900 -610 -900 -600 {
lab=vcc}
N -900 -540 -900 -530 {
lab=GND}
N -990 -610 -990 -600 {
lab=vdd}
N -990 -540 -990 -530 {
lab=GND}
N -520 -100 -490 -100 {lab=b0}
N -520 -80 -490 -80 {lab=b1}
N -190 -100 -100 -100 {lab=out}
N -520 -60 -490 -60 {lab=b2}
N -520 -40 -490 -40 {lab=b3}
N -520 -20 -490 -20 {lab=b4}
N -520 0 -490 0 {lab=b5}
N -520 20 -490 20 {lab=b6}
N -520 40 -490 40 {lab=b7}
C {devices/code.sym} -470 690 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.include design.ngspice
.lib sm141064.ngspice typical
.lib sm141064.ngspice res_typical
"
spice_ignore=false}
C {devices/vsource.sym} -70 -560 0 0 {name=V1 value="pulse(0 3.3 0 10p 10p 400n 800n)" savecurrent=false}
C {devices/gnd.sym} -70 -510 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -100 -610 0 0 {name=p6 sig_type=std_logic lab=b3}
C {devices/vsource.sym} -190 -560 0 0 {name=V2 value="pulse(0 3.3 0 10p 10p 200n 400n)" savecurrent=false}
C {devices/gnd.sym} -190 -510 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -220 -610 0 0 {name=p7 sig_type=std_logic lab=b2}
C {devices/vsource.sym} -300 -560 0 0 {name=V3 value="pulse(0 3.3 0 10p 10p 100n 200n)" savecurrent=false}
C {devices/gnd.sym} -300 -510 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -330 -610 0 0 {name=p8 sig_type=std_logic lab=b1}
C {devices/vsource.sym} -420 -560 0 0 {name=V4 value="pulse(0 3.3 0 10p 10p 50n 100n)" savecurrent=false}
C {devices/gnd.sym} -420 -510 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} -450 -610 0 0 {name=p9 sig_type=std_logic lab=b0
}
C {devices/launcher.sym} 10 790 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_dac.raw tran"
}
C {devices/gnd.sym} -190 -80 0 0 {name=l9 lab=GND}
C {devices/code.sym} -310 690 0 0 {name=SIMULATION
only_toplevel=false 
value="
* .options filetype=ascii
.control
*tran 1n 128n uic
tran 1n 14000n uic
write tb_dac.raw
.endc
.end
"}
C {devices/vsource.sym} -70 -370 0 0 {name=V5 value="pulse(0 3.3 0 10p 10p 6400n 12800n)" savecurrent=false}
C {devices/gnd.sym} -70 -320 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -100 -420 0 0 {name=p14 sig_type=std_logic lab=b7}
C {devices/vsource.sym} -190 -370 0 0 {name=V6 value="pulse(0 3.3 0 10p 10p 3200n 6400n)" savecurrent=false}
C {devices/gnd.sym} -190 -320 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -220 -420 0 0 {name=p15 sig_type=std_logic lab=b6}
C {devices/vsource.sym} -300 -370 0 0 {name=V7 value="pulse(0 3.3 0 10p 10p 1600n 3200n)" savecurrent=false}
C {devices/gnd.sym} -300 -320 0 0 {name=l10 lab=GND}
C {devices/lab_pin.sym} -330 -420 0 0 {name=p16 sig_type=std_logic lab=b5}
C {devices/vsource.sym} -420 -370 0 0 {name=V8 value="pulse(0 3.3 0 10p 10p 800n 1600n)" savecurrent=false}
C {devices/gnd.sym} -420 -320 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} -450 -420 0 0 {name=p17 sig_type=std_logic lab=b4

}
C {devices/vsource.sym} -900 -570 0 0 {name=V9 value=3.3 savecurrent=false}
C {devices/gnd.sym} -900 -530 0 0 {name=l12 lab=GND}
C {devices/lab_pin.sym} -900 -610 2 1 {name=p18 sig_type=std_logic lab=vcc
}
C {devices/vsource.sym} -990 -570 0 0 {name=V10 value=1.8 savecurrent=false}
C {devices/gnd.sym} -990 -530 0 0 {name=l13 lab=GND}
C {devices/lab_pin.sym} -990 -610 2 1 {name=p19 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -520 -100 0 0 {name=p1 sig_type=std_logic lab=b0
}
C {devices/lab_pin.sym} -520 -80 0 0 {name=p2 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} -100 -100 2 0 {name=p3 sig_type=std_logic lab=out}
C {r2r.sym} -340 -30 0 0 {name=x1}
C {devices/lab_pin.sym} -520 -60 0 0 {name=p4 sig_type=std_logic lab=b2
}
C {devices/lab_pin.sym} -520 -40 0 0 {name=p5 sig_type=std_logic lab=b3


 

}
C {devices/lab_pin.sym} -520 -20 0 0 {name=p10 sig_type=std_logic lab=b4
}
C {devices/lab_pin.sym} -520 0 0 0 {name=p11 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} -520 20 0 0 {name=p12 sig_type=std_logic lab=b6
}
C {devices/lab_pin.sym} -520 40 0 0 {name=p13 sig_type=std_logic lab=b7}
