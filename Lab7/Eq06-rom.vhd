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
        0  => "1110000001100000", -- ldi R6, #0 ; Contagem de primos [0]
        1  => "1110000001110001", -- ldi R7, #1 ; Ultimo primo valido
        2  => "1110000001000001", -- ldi R4, #1 ; constante
        3  => "1110000000010001", -- ldi R1, #1 ; Teste do primo em si
        4  => "0000110000010100", -- add R1, R4 ; LOOP: avança R1
        5  => "1111010001100001", -- brne #12 ; Se R1 deu 0, pula FINALIZE
        6  => "1110000000100010", -- ldi R2, #2 ; Inicia teste com 2
        7  => "0010110000110001", -- mov R3, R1 ; INNERLOOP:
        8  => "0001100000110010", -- sub R3, R2
        9  => "1111010000101001", -- brne #5 ; Se R3 der zero, PRIMO, goto GOOD
        10 => "0010110000110001", -- mov R3, R1
        11 => "0100000000110010", -- rem R3, R2
        12 => "1111011110111001", -- brne #-9 ; Volta para LOOP
        13 => "0000110000100100", -- add R2, R4
        14 => "1100111111111000", -- rjmp #-8 ; Volta para INNERLOOP
        15 => "0010110001110001", -- mov R7, R1 ; GOOD: copia R1 para R7
        16 => "0000110001100100", -- add R6, R4 ; incrementa contagem de primo
        17 => "1100111111110010", -- rjmp #-14 ; volta para LOOP
        18 => "0000000000000000", -- nop
        19 => "1100111111111111", -- rjmp #-1 ; FINALIZE: morre
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
