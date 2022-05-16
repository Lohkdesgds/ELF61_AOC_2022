-- Projeto PC TB
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end;

architecture a_program_counter_tb of program_counter_tb is
	component program_counter is
	port(
		clk, wr_en, rst : in std_logic;
		data_in: in unsigned(15 downto 0);
		data_out: out unsigned(15 downto 0)
	);
	end component;
	component unidade_somadora_pc is 
	port (
		pc_now: in unsigned(15 downto 0);
		pc_next: out unsigned(15 downto 0)
	);
	end component;

	signal s_clk, s_rst, s_wr_en : std_logic := '0';
	signal s_data_in  : unsigned(15 downto 0) := x"0000";
	signal s_data_out : unsigned(15 downto 0) := x"0000";
begin 
	pc_sum : unidade_somadora_pc port map(
		pc_now => s_data_out,
		pc_next => s_data_in
	);
	pc_test : program_counter port map(
		clk => s_clk,
		wr_en => s_wr_en,
		rst => s_rst,
		data_in => s_data_in,
		data_out => s_data_out
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
		s_wr_en <= '1'; -- "Por enquanto pode deixar wr_en=1 sempre, então todo clock vai incrementar"
		s_rst <= '1';
		wait for 100 ns;
		
		-- Depois deste ponto o PC deve contar +1 por clock
		s_rst <= '0';
		wait for 1000 ns;
		
		wait;	
	end process;
	
end architecture;