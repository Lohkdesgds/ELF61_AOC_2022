-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane
-- OK

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opcoder is
   port(
      rawop : in unsigned(8 downto 0);
      instrcode : out unsigned(2 downto 0) := (others => '0')
	);
end entity;

architecture a_opcoder of opcoder is
begin
    instrcode <=   
        "000" when rawop = "000000000" else            -- NOP
        "001" when rawop = "111101001" else            -- BRNE
        "010" when rawop(8 downto 3) = "000011" else   -- ADD
        "011" when rawop(8 downto 3) = "000110" else   -- SUB
        "100" when rawop(8 downto 3) = "010000" else   -- REM
        "101" when rawop(8 downto 3) = "001011" else   -- MOV
        "110" when rawop(8 downto 5) = "1110" else     -- LDI
        "111" when rawop(8 downto 5) = "1100" else     -- RJMP
        "000";
end architecture;