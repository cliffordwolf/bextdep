#!/bin/bash
set -ex

rm -rf tinyrocket-src
git clone https://github.com/freechipsproject/rocket-chip tinyrocket-src
cd tinyrocket-src
git checkout c497871
git submodule update --init
make -C vsim RISCV=dummy CONFIG=TinyConfig verilog

cat > vivado.tcl << EOT
read_verilog vsim/generated-src/freechips.rocketchip.system.TinyConfig.v
read_verilog vsim/generated-src/freechips.rocketchip.system.TinyConfig.behav_srams.v
read_verilog vsrc/plusarg_reader.v
synth_design -flatten_hierarchy full -mode out_of_context -retiming \
		-part xcku035-fbva676-3-e -top RocketTile_rocket
opt_design
report_utilization
report_timing
EOT

vivado -mode batch -nojournal -log vivado.log -source vivado.tcl

touch OK

