-- Projeto ROM
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(7 downto 0) := x"00"
	);
end entity;

architecture a_rom of rom is 
	-- cria-se um "dicionario" de 0 a 127 contendo unsigned de 8 bits
	type mem is array(0 to 127) of unsigned(7 downto 0);	
	-- instruções do programa em sequência
	-- Sequência esperada: 0, 5, 6, 1, 2, 3, 4, 0... (loop)
	constant conteudo_rom : mem := (
		0 => "11100101", -- Pula pro 5
		1 => "10000000", -- (nada)    
		2 => "00000000", -- (nada)    
		3 => "00000000", -- (nada)    
		4 => "11100000", -- pula pro 0
		5 => "00000010", -- (nada)    
		6 => "11100001", -- pula pro 1
		7 => "00000010",
		8 => "00000010",
		9 => "00000000",
		10 => "00000000",
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