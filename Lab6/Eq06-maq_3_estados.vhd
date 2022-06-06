-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_3_estados is
	port(clk	:	in std_logic;
		 rst	:	in std_logic;
		 estado	:	out unsigned(1 downto 0)
		);
end entity;

architecture a_maq_3_estados of maq_3_estados is

	signal s_estado	: unsigned(1 downto 0);
	
begin

	process(clk, rst)
	begin
		if rst = '1' then
			s_estado <= "00";
		elsif rising_edge(clk) then
			if s_estado = "10" then --se agora esta em 2
				s_estado <= "00"; -- o prox vai voltar ao zero
			else
				s_estado <= s_estado + 1; --senao avança
			end if;
		end if;
	end process;
	
	estado <= s_estado;
	
end architecture;