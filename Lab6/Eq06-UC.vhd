-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is 
	port(
		uc_clk, uc_rst : in std_logic;
		in_rom         : in unsigned(15 downto 0); --entrada da ROM;
		reg_wr_en      : out std_logic;
		jump_en        : out std_logic; --flag que indica o jump_en
		cte            : out unsigned(15 downto 0);
		estado         : out unsigned(1 downto 0); --estado que se encontra
		op_ULA         : out unsigned(1 downto 0);
	);
end entity;