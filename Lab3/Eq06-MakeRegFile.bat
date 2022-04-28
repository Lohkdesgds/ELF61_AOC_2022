ghdl -a Eq06-reg16bits.vhd
ghdl -a Eq06-RegFile.vhd
ghdl -a Eq06-RegFile_tb.vhd
ghdl -r RegisterFile_TB --stop-time=1000ns --wave=Eq06-RegFile.ghw
:: gtkw Eq06-RegFile.ghw --save Eq06-RegFile.gtkw