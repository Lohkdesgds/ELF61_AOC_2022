-- Projeto ROM TB
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end;

architecture a_rom_tb of rom_tb is
	component rom 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(7 downto 0)
	);
	end component;
	
	signal s_clk: std_logic 					:= '0';
	signal s_endereco: unsigned(15 downto 0) 	:= x"0000";
	signal s_dado: unsigned(7 downto 0) 		:= x"00";
begin 
	rom_tb_op: rom port map(
		clk => s_clk,
		endereco => s_endereco,
		dado => s_dado
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
		wait for 100 ns;
		s_endereco <= "0000000000000010";

        wait for 100 ns;
		s_endereco <= "0000000010000000";
		
		wait for 100 ns;
		s_endereco <= "0000000000000110";
		
		wait for 100 ns;
		s_endereco <= "0000000000001000";
		
		wait for 100 ns;
		s_endereco <= "0000000000000001";
		
		wait for 100 ns;
		s_endereco <= "0000000000100011";
		
		wait for 100 ns;
		s_endereco <= "0000000000000010";
		
		wait for 100 ns;
		s_endereco <= "0000000000000111";
		
		wait for 100 ns;
		s_endereco <= "0000000000000000";
		
		wait;
	end process;
end architecture;