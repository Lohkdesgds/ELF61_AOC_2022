-- Projeto ULA (V3)
-- Equipe: Ernesto & Ellejeane
-- OK

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ULA is 
    port (
        flagZ   : out std_logic := '0'; --flag de zero
        in_A    : in unsigned(15 downto 0);
        in_B    : in unsigned(15 downto 0);
        op      : in std_logic_vector(1 downto 0);
        out_ULA : out unsigned(15 downto 0) := (others => '0')
    );
end entity;

architecture a_ULA of ULA is
signal s_out : unsigned(15 downto 0) := (others => '0');
begin

s_out <=
    in_A + in_B when op = "00" else
    in_A - in_B when op = "01" else
    (others => '0') when op = "10" and in_B = to_unsigned(0, 16) else
    in_A rem in_B when op = "10" else
    in_B;

out_ULA <= s_out;

flagZ <= '1' when s_out = x"0000" else '0';

end architecture;