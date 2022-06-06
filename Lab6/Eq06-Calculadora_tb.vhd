-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Calculadora_tb is
end;

architecture a_Calculadora_tb of Calculadora_tb is
	component Calculadora 
	port(
		clk, rst: in std_logic
	);
	end component;
	
	signal s_clk, s_rst: std_logic;
begin
	poggers: Calculadora port map(
		clk => s_clk,
		rst => s_rst
	);
	
	process
	begin
		s_clk <= '0';
		wait for 50 ns;
		s_clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin 
		s_rst <= '1';
		wait for 75 ns;
		s_rst <= '0';
		wait;
	end process;
	
end architecture;