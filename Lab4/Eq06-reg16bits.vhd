-- Projeto Banco de registradores (V2)
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity REG is 
    port (
        clk      : in std_logic;
        rst      : in std_logic;
        wr_en    : in std_logic;
        data_in  : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_REG of REG is
signal s_registro : unsigned(15 downto 0) := "0000000000000000";
begin

data_out <= s_registro;

process(clk, rst, wr_en)
begin
    if (rst = '1') then
        s_registro <= "0000000000000000";
    elsif (rising_edge(clk) and wr_en = '1') then
        s_registro <= data_in;
    end if;
end process;

end architecture;