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
        0  => "1110000001000011", -- ldi R4, #3 ; 1
        1  => "1110000001010111", -- ldi R5, #7 ; 2
        2  => "1110000001110000", -- ldi R7, #0 ; 3
        3  => "0000110001110100", -- add R7, R4
        4  => "0000110001110101", -- add R7, R5
        5  => "1110000000010010", -- ldi R1, #2 ; 4
        6  => "0001100001110001", -- sub R7, R1
        7  => "1100000000001000", -- rjmp #8 ; 5 (9 relativo)
        8  => "0000000000000000", -- nop
        9  => "0000000000000000", -- nop
        10 => "0000000000000000", -- nop
        11 => "0000000000000000", -- nop
        12 => "0000000000000000", -- nop
        13 => "0000000000000000", -- nop
        14 => "0000000000000000", -- nop
        15 => "0000000000000000", -- nop
        16 => "0010110001000111", -- mov R4, R7 ; 6
        17 => "0010110001100111", -- mov R6, R7 ; 7
        18 => "1110000000100011", -- ldi R2, #3
        19 => "0100000001100010", -- rem R6, R2
        20 => "1100111111101101", -- rjmp #-19 ; 8
        21 => "0000000000000000", -- nop
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
