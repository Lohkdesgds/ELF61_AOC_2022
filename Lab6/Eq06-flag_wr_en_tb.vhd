-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_tb is
end;

architecture a_flag_tb of flag_tb is
	component flag
		port(clk, rst, wr_en :	in std_logic;
			 data_in         :	in std_logic;
			 data_out        :	out std_logic
			);
	end component;
	
	signal s_clk, s_rst, s_wr_en : std_logic;
	signal s_data_in, s_data_out : std_logic;
	
begin
uut: flag port map( clk => s_clk,
					rst => s_rst,
					wr_en => s_wr_en,
					data_in => s_data_in,
					data_out => s_data_out);
					
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
	
	process
	begin
		wait for 100 ns;
		s_wr_en <= '1';
		s_data_in <= '1';
		wait for 100 ns;
		s_wr_en <= '0';
		s_data_in <= '0';
		wait;
	end process;
	
end architecture;