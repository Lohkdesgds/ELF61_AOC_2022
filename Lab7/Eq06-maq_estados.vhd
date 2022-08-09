-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane
-- OK

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados is
   port(
      clk,rst: in std_logic;
      estado: out unsigned(1 downto 0) := (others => '0')
	);
end entity;

architecture a_maq_estados of maq_estados is
   signal s_estado: unsigned(1 downto 0) := (others => '0');
begin
   process(clk,rst)
   begin
      if rst = '1' then
		s_estado <= "00";
      elsif rising_edge(clk) then
         if s_estado = "10" then
            s_estado <= "00";
         else
            s_estado <= s_estado + 1;
         end if;
      end if;
   end process;
   estado <= s_estado;
end architecture;