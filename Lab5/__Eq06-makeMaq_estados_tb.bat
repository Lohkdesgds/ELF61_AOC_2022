helper.exe "ghdl -a Eq06-maq_estados.vhd" "ghdl -a Eq06-maq_estados_tb.vhd" "ghdl -r maq_estados_tb --stop-time=800ns --wave=Eq06-maq_estados_tb.ghw"
helper.exe "gtkw Eq06-maq_estados_tb.ghw"