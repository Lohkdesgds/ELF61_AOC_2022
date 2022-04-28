:: Usei o meu aplicativo, mas os comandos sequenciais brutos são os entre aspas (equivalente)
:: Ref do aplicativo usado: https://github.com/Lohkdesgds/GHDL-GTKWAVE-INTEGRATOR-TOOL
:: Se for rodar este app, abra-o antes e use o comando "install".

:: Chamando pelo aplicativo:
:: helper "ghdl -a EqErnestoEllejeane_ULA.vhd" "ghdl -a EqErnestoEllejeane_ULA_tb.vhd" "ghdl -r testbench --wave=sim.ghw" "gtkw sim.ghw"

:: Equivalente esperado:

ghdl -a EqErnestoEllejeane_ULA.vhd
ghdl -a EqErnestoEllejeane_ULA_tb.vhd
ghdl -r testbench --wave=sim.ghw
gtkw sim.ghw