helper.exe "ghdl -a Eq06-rom.vhd" "ghdl -a Eq06-rom_tb.vhd" "ghdl -r rom_tb --stop-time=1000ns --wave=Eq06-rom.ghw"
helper.exe "gtkw Eq06-rom.ghw"