ghdl -a Eq06-rom.vhd
ghdl -a Eq06-unidade_somadora.vhd
ghdl -a Eq06-program_counter.vhd
ghdl -a Eq06-maq_estados.vhd
ghdl -a Eq06-ROM_PC_UC.vhd
ghdl -a Eq06-ROM_PC_UC_tb.vhd
ghdl -r ROM_PC_UC_tb --stop-time=21000ns --wave=Eq06-ROM_PC_UC.ghw
:: gtkw Eq06-ROM_PC_UC.ghw --save Eq06-ROM_PC_UC.gtkw

:: usando o outro app
:: helper.exe "ghdl -a Eq06-rom.vhd" "ghdl -a Eq06-unidade_somadora.vhd" "ghdl -a Eq06-program_counter.vhd" "ghdl -a Eq06-maq_estados.vhd" "ghdl -a Eq06-ROM_PC_UC.vhd" "ghdl -a Eq06-ROM_PC_UC_tb.vhd" "ghdl -r ROM_PC_UC_tb --stop-time=21000ns --wave=Eq06-ROM_PC_UC.ghw" 
:: helper.exe "gtkw Eq06-ROM_PC_UC.ghw --save Eq06-ROM_PC_UC.gtkw"
