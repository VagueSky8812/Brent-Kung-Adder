#!/bin/sh

design="alu"
rm -rf ${design}_TB
echo "Testing:" ${design}
iverilog -o ${design}_TB ../src/${design}.v ${design}_TB.v
vvp ${design}_TB
