PROJECT_NAME := r2r_dac_control
# needs PDK_ROOT and OPENLANE_ROOT, OPENLANE_IMAGE_NAME set from your environment
harden:
	librelane openlane/r2r_dac_control/config.tcl

update_files:
	cp openlane/$(PROJECT_NAME)/runs/$(PROJECT_NAME)/final/gds/$(PROJECT_NAME).gds gds
	cp openlane/$(PROJECT_NAME)/runs/$(PROJECT_NAME)/final/pnl/$(PROJECT_NAME).pnl.v verilog/gl/
