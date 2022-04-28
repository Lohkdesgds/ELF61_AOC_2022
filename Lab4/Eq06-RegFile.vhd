-- Projeto Banco de registradores (V2)
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity RegisterFile is 
    port (
        CLK : in std_logic;                 -- Clock geral
        A1 : in unsigned(2 downto 0);       -- O selecionar leitura 1
        A2 : in unsigned(2 downto 0);       -- O selecionar leitura 2
        A3 : in unsigned(2 downto 0);       -- Selecionar de escrita
        WD3 : in unsigned(15 downto 0);     -- Barramento de dados de escrita
        WE3 : in std_logic;                 -- Write enable (clock rise)
        RST : in std_logic;                 -- Zera tudo
        RD1 : out unsigned(15 downto 0);    -- Dados lidos 1
        RD2 : out unsigned(15 downto 0)     -- Dados lidos 2
    );
end entity;

architecture a_RegisterFile of RegisterFile is

component REG 
    port (
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
end component;

-- select por bit
signal s_write_select : std_logic_vector(6 downto 0) := "0000000"; -- 7 bits porque zero eh sempre zero
-- tudo junto para ficar numa variavel so
signal s_data_out1 : unsigned(15 downto 0);
signal s_data_out2 : unsigned(15 downto 0);
signal s_data_out3 : unsigned(15 downto 0);
signal s_data_out4 : unsigned(15 downto 0);
signal s_data_out5 : unsigned(15 downto 0);
signal s_data_out6 : unsigned(15 downto 0);
signal s_data_out7 : unsigned(15 downto 0);

begin
reg1: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(0),data_in=>WD3,data_out=>s_data_out1);
reg2: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(1),data_in=>WD3,data_out=>s_data_out2);
reg3: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(2),data_in=>WD3,data_out=>s_data_out3);
reg4: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(3),data_in=>WD3,data_out=>s_data_out4);
reg5: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(4),data_in=>WD3,data_out=>s_data_out5);
reg6: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(5),data_in=>WD3,data_out=>s_data_out6);
reg7: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(6),data_in=>WD3,data_out=>s_data_out7);

-- 000: escreve em nada
s_write_select <= "0000001" when WE3 = '1' and A3 = "001" else
                  "0000010" when WE3 = '1' and A3 = "010" else
                  "0000100" when WE3 = '1' and A3 = "011" else
                  "0001000" when WE3 = '1' and A3 = "100" else
                  "0010000" when WE3 = '1' and A3 = "101" else
                  "0100000" when WE3 = '1' and A3 = "110" else
                  "1000000" when WE3 = '1' and A3 = "111" else
                  "0000000";

-- 000 = zero
RD1 <= s_data_out1 when A1 = "001" else
       s_data_out2 when A1 = "010" else
       s_data_out3 when A1 = "011" else
       s_data_out4 when A1 = "100" else
       s_data_out5 when A1 = "101" else
       s_data_out6 when A1 = "110" else
       s_data_out7 when A1 = "111" else
       "0000000000000000";
        
-- 000 = zero
RD2 <= s_data_out1 when A2 = "001" else
       s_data_out2 when A2 = "010" else
       s_data_out3 when A2 = "011" else
       s_data_out4 when A2 = "100" else
       s_data_out5 when A2 = "101" else
       s_data_out6 when A2 = "110" else
       s_data_out7 when A2 = "111" else
       "0000000000000000";

end architecture;
