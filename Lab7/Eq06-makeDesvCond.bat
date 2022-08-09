:: @echo off
ghdl -a Eq06-reg16bits.vhd
ghdl -a Eq06-RegFile.vhd
ghdl -a Eq06-rom.vhd
ghdl -a Eq06-unidade_somadora.vhd
ghdl -a Eq06-opcoder.vhd
ghdl -a Eq06-program_counter.vhd
ghdl -a Eq06-maq_estados.vhd
ghdl -a Eq06-ULA.vhd
ghdl -a Eq06-ULARegs.vhd
ghdl -a Eq06-RegFlags.vhd
ghdl -a Eq06-Calculadora.vhd
ghdl -a Eq06-Calculadora_tb.vhd
ghdl -r Calculadora_tb --stop-time=10us --wave=Eq06-DesvCond.ghw
:: gtkw Eq06-DesvCond.ghw --save Eq06-DesvCond.gtkw
:: pause