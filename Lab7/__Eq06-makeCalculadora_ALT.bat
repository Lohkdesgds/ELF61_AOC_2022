@echo off
helper.exe "ghdl -a Eq06-reg16bits.vhd"
helper.exe "ghdl -a Eq06-RegFile.vhd"
helper.exe "ghdl -a Eq06-rom.vhd"
helper.exe "ghdl -a Eq06-unidade_somadora.vhd"
helper.exe "ghdl -a Eq06-opcoder.vhd"
helper.exe "ghdl -a Eq06-program_counter.vhd"
helper.exe "ghdl -a Eq06-maq_estados.vhd"
helper.exe "ghdl -a Eq06-ULA.vhd"
helper.exe "ghdl -a Eq06-ULARegs.vhd"
helper.exe "ghdl -a Eq06-RegFlags.vhd"
helper.exe "ghdl -a Eq06-Calculadora.vhd"
helper.exe "ghdl -a Eq06-Calculadora_tb.vhd"
helper.exe "ghdl -r Calculadora_tb --stop-time=21000ns --wave=Eq06-Calc.ghw" 
helper.exe "gtkw Eq06-Calc.ghw --save Eq06-Calc.gtkw"
:: pause