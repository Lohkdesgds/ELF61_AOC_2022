-- Projeto Banco de registradores (V2)
-- Equipe: Ernesto & Ellejeane
-- OK (atualizado para ter 31 registradores + zero)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is 
    port (
        CLK : in std_logic;                                     -- Clock geral
        A1  : in unsigned(4 downto 0);                          -- O selecionar leitura 1
        A2  : in unsigned(4 downto 0);                          -- O selecionar leitura 2
        A3  : in unsigned(4 downto 0);                          -- Selecionar de escrita
        WD3 : in unsigned(15 downto 0);                         -- Barramento de dados de escrita
        WE3 : in std_logic;                                     -- Write enable (clock rise)
        RST : in std_logic;                                     -- Zera tudo
        RD1 : out unsigned(15 downto 0) := (others => '0');     -- Dados lidos 1
        RD2 : out unsigned(15 downto 0) := (others => '0')      -- Dados lidos 2
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
signal s_write_select : std_logic_vector(30 downto 0) := (others => '0'); -- 31 bits porque zero eh sempre zero
-- tudo junto para ficar numa variavel so
signal s_data_out1 : unsigned(15 downto 0) := (others => '0');
signal s_data_out2 : unsigned(15 downto 0) := (others => '0');
signal s_data_out3 : unsigned(15 downto 0) := (others => '0');
signal s_data_out4 : unsigned(15 downto 0) := (others => '0');
signal s_data_out5 : unsigned(15 downto 0) := (others => '0');
signal s_data_out6 : unsigned(15 downto 0) := (others => '0');
signal s_data_out7 : unsigned(15 downto 0) := (others => '0');
signal s_data_out8 : unsigned(15 downto 0) := (others => '0');
signal s_data_out9 : unsigned(15 downto 0) := (others => '0');
signal s_data_outA : unsigned(15 downto 0) := (others => '0');
signal s_data_outB : unsigned(15 downto 0) := (others => '0');
signal s_data_outC : unsigned(15 downto 0) := (others => '0');
signal s_data_outD : unsigned(15 downto 0) := (others => '0');
signal s_data_outE : unsigned(15 downto 0) := (others => '0');
signal s_data_outF : unsigned(15 downto 0) := (others => '0');
signal s_data_outG : unsigned(15 downto 0) := (others => '0');
signal s_data_outH : unsigned(15 downto 0) := (others => '0');
signal s_data_outI : unsigned(15 downto 0) := (others => '0');
signal s_data_outJ : unsigned(15 downto 0) := (others => '0');
signal s_data_outK : unsigned(15 downto 0) := (others => '0');
signal s_data_outL : unsigned(15 downto 0) := (others => '0');
signal s_data_outM : unsigned(15 downto 0) := (others => '0');
signal s_data_outN : unsigned(15 downto 0) := (others => '0');
signal s_data_outO : unsigned(15 downto 0) := (others => '0');
signal s_data_outP : unsigned(15 downto 0) := (others => '0');
signal s_data_outQ : unsigned(15 downto 0) := (others => '0');
signal s_data_outR : unsigned(15 downto 0) := (others => '0');
signal s_data_outS : unsigned(15 downto 0) := (others => '0');
signal s_data_outT : unsigned(15 downto 0) := (others => '0');
signal s_data_outU : unsigned(15 downto 0) := (others => '0');
signal s_data_outV : unsigned(15 downto 0) := (others => '0');

begin
-- 00 sempre 0
reg1: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(0),data_in=>WD3,data_out=>s_data_out1);  -- 01
reg2: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(1),data_in=>WD3,data_out=>s_data_out2);  -- 02
reg3: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(2),data_in=>WD3,data_out=>s_data_out3);  -- 03
reg4: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(3),data_in=>WD3,data_out=>s_data_out4);  -- 04
reg5: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(4),data_in=>WD3,data_out=>s_data_out5);  -- 05
reg6: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(5),data_in=>WD3,data_out=>s_data_out6);  -- 06
reg7: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(6),data_in=>WD3,data_out=>s_data_out7);  -- 07
reg8: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(7),data_in=>WD3,data_out=>s_data_out8);  -- 08
reg9: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(8),data_in=>WD3,data_out=>s_data_out9);  -- 09
regA: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(9),data_in=>WD3,data_out=>s_data_outA);  -- 10
regB: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(10),data_in=>WD3,data_out=>s_data_outB); -- 11
regC: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(11),data_in=>WD3,data_out=>s_data_outC); -- 12
regD: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(12),data_in=>WD3,data_out=>s_data_outD); -- 13
regE: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(13),data_in=>WD3,data_out=>s_data_outE); -- 14
regF: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(14),data_in=>WD3,data_out=>s_data_outF); -- 15
regG: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(15),data_in=>WD3,data_out=>s_data_outG); -- 16
regH: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(16),data_in=>WD3,data_out=>s_data_outH); -- 17
regI: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(17),data_in=>WD3,data_out=>s_data_outI); -- 18
regJ: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(18),data_in=>WD3,data_out=>s_data_outJ); -- 19
regK: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(19),data_in=>WD3,data_out=>s_data_outK); -- 20
regL: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(10),data_in=>WD3,data_out=>s_data_outL); -- 21
regM: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(11),data_in=>WD3,data_out=>s_data_outM); -- 22
regN: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(12),data_in=>WD3,data_out=>s_data_outN); -- 23
regO: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(13),data_in=>WD3,data_out=>s_data_outO); -- 24
regP: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(14),data_in=>WD3,data_out=>s_data_outP); -- 25
regQ: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(15),data_in=>WD3,data_out=>s_data_outQ); -- 26
regR: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(16),data_in=>WD3,data_out=>s_data_outR); -- 27
regS: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(17),data_in=>WD3,data_out=>s_data_outS); -- 28
regT: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(18),data_in=>WD3,data_out=>s_data_outT); -- 29
regU: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(19),data_in=>WD3,data_out=>s_data_outU); -- 30
regV: REG port map(clk=>CLK,rst=>RST,wr_en=>s_write_select(10),data_in=>WD3,data_out=>s_data_outV); -- 31

-- 000: escreve em nada
s_write_select <= 
                "0000000000000000000000000000001" when WE3 = '1' and A3 = "00001" else
                "0000000000000000000000000000010" when WE3 = '1' and A3 = "00010" else
                "0000000000000000000000000000100" when WE3 = '1' and A3 = "00011" else
                "0000000000000000000000000001000" when WE3 = '1' and A3 = "00100" else
                "0000000000000000000000000010000" when WE3 = '1' and A3 = "00101" else
                "0000000000000000000000000100000" when WE3 = '1' and A3 = "00110" else
                "0000000000000000000000001000000" when WE3 = '1' and A3 = "00111" else
                "0000000000000000000000010000000" when WE3 = '1' and A3 = "01000" else
                "0000000000000000000000100000000" when WE3 = '1' and A3 = "01001" else
                "0000000000000000000001000000000" when WE3 = '1' and A3 = "01010" else
                "0000000000000000000010000000000" when WE3 = '1' and A3 = "01011" else
                "0000000000000000000100000000000" when WE3 = '1' and A3 = "01100" else
                "0000000000000000001000000000000" when WE3 = '1' and A3 = "01101" else
                "0000000000000000010000000000000" when WE3 = '1' and A3 = "01110" else
                "0000000000000000100000000000000" when WE3 = '1' and A3 = "01111" else
                "0000000000000001000000000000000" when WE3 = '1' and A3 = "10000" else
                "0000000000000010000000000000000" when WE3 = '1' and A3 = "10001" else
                "0000000000000100000000000000000" when WE3 = '1' and A3 = "10010" else
                "0000000000001000000000000000000" when WE3 = '1' and A3 = "10011" else
                "0000000000010000000000000000000" when WE3 = '1' and A3 = "10100" else
                "0000000000100000000000000000000" when WE3 = '1' and A3 = "10101" else
                "0000000001000000000000000000000" when WE3 = '1' and A3 = "10110" else
                "0000000010000000000000000000000" when WE3 = '1' and A3 = "10111" else
                "0000000100000000000000000000000" when WE3 = '1' and A3 = "11000" else
                "0000001000000000000000000000000" when WE3 = '1' and A3 = "11001" else
                "0000010000000000000000000000000" when WE3 = '1' and A3 = "11010" else
                "0000100000000000000000000000000" when WE3 = '1' and A3 = "11011" else
                "0001000000000000000000000000000" when WE3 = '1' and A3 = "11100" else
                "0010000000000000000000000000000" when WE3 = '1' and A3 = "11101" else
                "0100000000000000000000000000000" when WE3 = '1' and A3 = "11110" else
                "1000000000000000000000000000000" when WE3 = '1' and A3 = "11111" else
                "0000000000000000000000000000000";

-- 000 = zero
RD1 <= 
        s_data_out1 when A1 = "00001" else
        s_data_out2 when A1 = "00010" else
        s_data_out3 when A1 = "00011" else
        s_data_out4 when A1 = "00100" else
        s_data_out5 when A1 = "00101" else
        s_data_out6 when A1 = "00110" else
        s_data_out7 when A1 = "00111" else
        s_data_out8 when A1 = "01000" else
        s_data_out9 when A1 = "01001" else
        s_data_outA when A1 = "01010" else
        s_data_outB when A1 = "01011" else
        s_data_outC when A1 = "01100" else
        s_data_outD when A1 = "01101" else
        s_data_outE when A1 = "01110" else
        s_data_outF when A1 = "01111" else
        s_data_outG when A1 = "10000" else
        s_data_outH when A1 = "10001" else
        s_data_outI when A1 = "10010" else
        s_data_outJ when A1 = "10011" else
        s_data_outK when A1 = "10100" else
        s_data_outL when A1 = "10101" else
        s_data_outM when A1 = "10110" else
        s_data_outN when A1 = "10111" else
        s_data_outO when A1 = "11000" else
        s_data_outP when A1 = "11001" else
        s_data_outQ when A1 = "11010" else
        s_data_outR when A1 = "11011" else
        s_data_outS when A1 = "11100" else
        s_data_outT when A1 = "11101" else
        s_data_outU when A1 = "11110" else
        s_data_outV when A1 = "11111" else
        "0000000000000000";
        
-- 000 = zero
RD2 <= 
        s_data_out1 when A2 = "00001" else
        s_data_out2 when A2 = "00010" else
        s_data_out3 when A2 = "00011" else
        s_data_out4 when A2 = "00100" else
        s_data_out5 when A2 = "00101" else
        s_data_out6 when A2 = "00110" else
        s_data_out7 when A2 = "00111" else
        s_data_out8 when A2 = "01000" else
        s_data_out9 when A2 = "01001" else
        s_data_outA when A2 = "01010" else
        s_data_outB when A2 = "01011" else
        s_data_outC when A2 = "01100" else
        s_data_outD when A2 = "01101" else
        s_data_outE when A2 = "01110" else
        s_data_outF when A2 = "01111" else
        s_data_outG when A2 = "10000" else
        s_data_outH when A2 = "10001" else
        s_data_outI when A2 = "10010" else
        s_data_outJ when A2 = "10011" else
        s_data_outK when A2 = "10100" else
        s_data_outL when A2 = "10101" else
        s_data_outM when A2 = "10110" else
        s_data_outN when A2 = "10111" else
        s_data_outO when A2 = "11000" else
        s_data_outP when A2 = "11001" else
        s_data_outQ when A2 = "11010" else
        s_data_outR when A2 = "11011" else
        s_data_outS when A2 = "11100" else
        s_data_outT when A2 = "11101" else
        s_data_outU when A2 = "11110" else
        s_data_outV when A2 = "11111" else
        "0000000000000000";

end architecture;