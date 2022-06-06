::@echo off

ghdl -a Eq06-reg16bits.vhd
ghdl -a Eq06-RegFile.vhd
ghdl -a Eq06-rom.vhd
ghdl -a Eq06-unidade_somadora.vhd
ghdl -a Eq06-opcoder.vhd
ghdl -a Eq06-program_counter.vhd
ghdl -a Eq06-maq_estados.vhd
ghdl -a Eq06-ULA.vhd
ghdl -a Eq06-ULARegs.vhd
ghdl -a Eq06-Calculadora.vhd
ghdl -a Eq06-Calculadora_tb.vhd
ghdl -r Calculadora_tb --stop-time=21000ns --wave=Eq06-Calculadora.ghw
:: gtkw Eq06-Calculadora.ghw --save Eq06-Calculadora.gtkw

:: usando o outro app
:: helper.exe "ghdl -a Eq06-reg16bits.vhd"
:: helper.exe "ghdl -a Eq06-RegFile.vhd"
:: helper.exe "ghdl -a Eq06-rom.vhd"
:: helper.exe "ghdl -a Eq06-unidade_somadora.vhd"
:: helper.exe "ghdl -a Eq06-opcoder.vhd"
:: helper.exe "ghdl -a Eq06-program_counter.vhd"
:: helper.exe "ghdl -a Eq06-maq_estados.vhd"
:: helper.exe "ghdl -a Eq06-ULA.vhd"
:: helper.exe "ghdl -a Eq06-ULARegs.vhd"
:: helper.exe "ghdl -a Eq06-Calculadora.vhd"
:: helper.exe "ghdl -a Eq06-Calculadora_tb.vhd"
:: helper.exe "ghdl -r Calculadora_tb --stop-time=21000ns --wave=Eq06-Calculadora.ghw" 
:: helper.exe "gtkw Eq06-Calculadora.ghw --save Eq06-Calculadora.gtkw"
:: pause