-- Projeto ROM
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(15 downto 0) := x"0000"
	);
end entity;

architecture a_rom of rom is 
	type mem is array(0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (
		0  => "1110000001000011",
		1  => "1110000001010111",
		2  => "1110000001110000",
		3  => "0000110001110100",
		4  => "0000110001110101",
		5  => "1110000000010010",
		6  => "0001100001110001",
		7  => "1100000000001001",
		8  => "0000000000000000",
		9  => "0000000000000000",
		10 => "0000000000000000",
		11 => "0000000000000000",
		12 => "0000000000000000",
		13 => "0000000000000000",
		14 => "0000000000000000",
		15 => "0000000000000000",
		16 => "0000000000000000",
		17 => "0010110001000111",
		18 => "0010110001100111",
		19 => "1110000000100011",
		20 => "0100000001100010",
		21 => "1100111111101100",
		22 => "0000000000000000",
		others => (others => '0')
	);
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if (endereco > 127) then dado <= (others => '0');
			else dado <= conteudo_rom(to_integer(endereco)); end if;
		end if;
	end process;
	
end architecture;