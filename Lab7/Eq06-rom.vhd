-- Projeto ROM
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(15 downto 0) := (others => '0')
	);
end entity;

architecture a_rom of rom is 
	type mem is array(0 to 127) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (
        0 => "1110000001011010", -- ldi R5, #10
        1 => "1110000000110001", -- ldi R3, #1
        2 => "1110000001000101", -- ldi R4, #5 ; 5x
        3 => "1110000000100000", -- ldi R2, #0 ; salvar em R2 <= 10 * 5
        4 => "0000110000100101", -- add R2, R5
        5 => "0001100001000011", -- sub R4, R3
        6 => "1111010000001001", -- brne #1 ; se R4 == 0, pula 1 linha
        7 => "1100111111111100", -- rjmp #-4 ; se não pulou, volta pro add
        8 => "1100111111111111", -- rjmp #-1 ; senão trava loop infinito
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
