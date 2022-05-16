-- Projeto Unidade somadora
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unidade somadora [+1], do enunciado:
-- "Crie outro módulo que simplesmente adiciona 1 no valor
-- de saída do PC e conecta o resultado desta soma de
-- volta à entrada do PC."
entity unidade_somadora_pc is 
	port (
		pc_now: in unsigned(15 downto 0);
		pc_next: out unsigned(15 downto 0)
	);
end entity;

-- O objetivo é sempre somar 1 à entrada, [+1]
architecture a_unidade_somadora_pc of unidade_somadora_pc is
begin
	pc_next <= pc_now + 1;
end architecture;
