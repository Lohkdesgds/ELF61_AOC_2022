-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag is
	port(clk, rst, wr_en :	in std_logic;
		 data_in         :	in std_logic;
		 data_out        :	out std_logic
		);
end entity;

architecture a_flag of flag is

signal s_data_out : std_logic;

begin

	process(clk, rst, wr_en)
	begin
		if rst = '1' then 
			s_data_out <= '0';
		elsif wr_en = '1' then
			if rising_edge(clk) then
				s_data_out <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= s_data_out;
	
end architecture;