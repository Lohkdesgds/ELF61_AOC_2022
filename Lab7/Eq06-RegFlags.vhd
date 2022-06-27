-- Projeto Registro de Flags
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFlags is 
    port (
        CLK          : in std_logic; -- CLK
        WE           : in std_logic; -- Write enable
        FLAGS_STORE  : in std_logic; -- Ultimas flags (atualmente ZERO so)
        FLAGS_READ   : out std_logic; -- Flags salvas (atualmente ZERO so)
        RST          : in std_logic  -- Zera tudo
    );
end entity;

architecture a_RegisterFlags of RegisterFlags is
signal s_flags : std_logic := '0';
begin

FLAGS_READ <= s_flags;

process(CLK, RST, WE)
begin
    if (RST = '1') then
        s_flags <= '0';
    elsif (rising_edge(CLK) and WE = '1') then
        s_flags <= FLAGS_STORE;
    end if;
end process;

end architecture;