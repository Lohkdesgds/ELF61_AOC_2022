ghdl -a Eq06-ULA.vhd
ghdl -a Eq06-reg16bits.vhd
ghdl -a Eq06-RegFile.vhd
ghdl -a Eq06-ULARegs.vhd
ghdl -a Eq06-ULARegs-tb.vhd
ghdl -r ULARegs_TB --ieee-asserts=disable-at-0 --stop-time=1000ns --wave=Eq06-ULARegs.ghw
:: gtkw Eq06-ULARegs.ghw --save Eq06-ULARegs.gtkw

:: usando o outro app
:: helper.exe "ghdl -a Eq06-ULA.vhd" "ghdl -a Eq06-reg16bits.vhd" "ghdl -a Eq06-RegFile.vhd" "ghdl -a Eq06-ULARegs.vhd" "ghdl -a Eq06-ULARegs-tb.vhd" "ghdl -r ULARegs_TB --ieee-asserts=disable-at-0 --stop-time=1000ns --wave=Eq06-ULARegs.ghw" "gtkw Eq06-ULARegs.ghw --save Eq06-ULARegs.gtkw"
