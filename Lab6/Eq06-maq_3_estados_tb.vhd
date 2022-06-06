-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_3_estados_tb is
end;

architecture a_maq_3_estados_tb of maq_3_estados_tb is
	component maq_3_estados
		port(clk	:	in std_logic;
			 rst	:	in std_logic;
			 estado	:	out unsigned(1 downto 0)
			);
	end component;
	
	signal s_clk, s_rst : std_logic;
	signal s_estado : unsigned(1 downto 0);
	
begin
uut: maq_3_estados port map( clk => s_clk,
							rst => s_rst,
							estado => s_estado);
							
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