-- Projeto ULA
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ULA is 
    port (
        flug : out std_logic; -- ok
        in_a : in unsigned(15 downto 0); -- ok
        in_b : in unsigned(15 downto 0); -- ok
        oop : in std_logic_vector(1 downto 0); -- ok
        ouu : out unsigned(15 downto 0)
    );
end entity;

architecture ULA_a of ULA is
signal simpl : unsigned(15 downto 0) := "0000000000000000";
begin

simpl <=
    in_a + in_b when oop = "00" else
    in_a - in_b when oop = "01" else
    "0000000000000000" when oop = "10" and in_b = to_unsigned(0, 16) else -- se div por zero, zerar.
    in_a rem in_b when oop = "10" else
    "0000000000000000";

ouu <= simpl; -- simpl é usado para ler em testes de condição

flug <=
    '1' when (oop = "00" and (simpl < in_a or simpl < in_b)) else
    '1' when (oop = "01" and (simpl > in_a)) else
    '0';

end architecture;