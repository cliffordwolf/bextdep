read_verilog vscalealu.v
read_verilog bextdep.v
read_verilog bextdep_pps.v
synth_design -flatten_hierarchy full -mode out_of_context -retiming \
		-part xcku035-fbva676-3-e -top $::env(top_module)
opt_design
report_utilization
report_timing
