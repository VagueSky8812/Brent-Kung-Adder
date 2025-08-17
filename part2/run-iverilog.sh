#!/bin/sh

design="bkadder"
rm -rf ${design}_TB
echo "Testing:" ${design}
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 -o ${design}_TB ../runs/full_guide/results/synthesis/${design}.v ${design}_TB.v
../../../../.volare/volare/sky130/versions/bdc9412b3e468c102d01b7cf6337be06ec6e9c9a/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
../../../../.volare/volare/sky130/versions/bdc9412b3e468c102d01b7cf6337be06ec6e9c9a/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
vvp ${design}_TB