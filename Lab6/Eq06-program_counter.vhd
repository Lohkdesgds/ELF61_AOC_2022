-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane
-- OK

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Program counter, "só um registrador, sem contagem interna"
entity program_counter is
	port(
		clk, wr_en, rst : in std_logic;
		data_in: in unsigned(15 downto 0);
		data_out: out unsigned(15 downto 0)
	);
end entity;

architecture a_program_counter of program_counter is 
	signal s_data : unsigned(15 downto 0) := x"0000";
begin			
	data_out <= s_data;
	
	process(clk, wr_en, rst)
	begin
		if (rst = '1') then
			s_data <= x"0000";
		elsif (rising_edge(clk) and wr_en = '1') then
			s_data <= data_in;
		end if;
	end process;

end architecture;