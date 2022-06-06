-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados_tb is
end;

architecture a_maq_estados_tb of maq_estados_tb is

component maq_estados is
	port(
		clk, rst: in std_logic;
		estado: out std_logic
	);
end component;
	
	signal s_clk, s_rst, s_saida: std_logic;
begin 
	maq_estados_op: maq_estados port map (
		clk => s_clk,
		rst => s_rst,
		estado => s_saida
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
		wait for 100 ns;
		s_rst <= '0';
		wait;
	end process;
	
end architecture;