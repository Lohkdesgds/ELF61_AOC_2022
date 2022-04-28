-- Projeto Banco de registradores + ULA
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULARegs is 
    port (
        CLK : in std_logic;                   -- Clock geral
        RST : in std_logic;                   -- Zera tudo
        WE3 : in std_logic;                   -- Write enable
		OP : in std_logic_vector(1 downto 0); -- Operador (soma, sub, resto)
		
        A1 : in unsigned(2 downto 0);         -- Selecionar leitura 1 (arg1)     #2
        A2 : in unsigned(2 downto 0);         -- Selecionar leitura 2 (arg2)   \ #1
        A3 : in unsigned(2 downto 0);         -- Selecionar de escrita  (dest) / #0
		CTE_EXT : in unsigned(15 downto 0);   -- Constante externa
		
		SELECT_MUX : in std_logic			  -- Usa constante externa? '1' = sim
    );
end entity;

architecture a_ULARegs of ULARegs is

constant s_cte_add : std_logic_vector(1 downto 0) := "00"; -- MUX = ULA em ADD 

component ULA 
    port (
        flagZ   : out std_logic;
        in_A    : in unsigned(15 downto 0);
        in_B    : in unsigned(15 downto 0);
        op      : in std_logic_vector(1 downto 0);
        out_ULA : out unsigned(15 downto 0)
    );
end component;
component RegisterFile 
    port (
        CLK : in std_logic;                 -- Clock geral
        A1  : in unsigned(2 downto 0);      -- O selecionar leitura 1
        A2  : in unsigned(2 downto 0);      -- O selecionar leitura 2
        A3  : in unsigned(2 downto 0);      -- Selecionar de escrita
        WD3 : in unsigned(15 downto 0);     -- Barramento de dados de escrita
        WE3 : in std_logic;                 -- Write enable (clock rise)
        RST : in std_logic;                 -- Zera tudo
        RD1 : out unsigned(15 downto 0);    -- Dados lidos 1
        RD2 : out unsigned(15 downto 0)     -- Dados lidos 2
    );
end component;

signal s_flagz : std_logic;
signal s_rd1 : unsigned(15 downto 0); 		-- SAIDA 1 RegisterFile (ligada direto)
signal s_rd2 : unsigned(15 downto 0); 		-- SAIDA 2 (nao selecionada, constante externa)
signal s_rd2_final : unsigned(15 downto 0); -- SAIDA 2 (rd2 ou constante externa)
signal s_out_ula : unsigned(15 downto 0); 	-- saida ULA, entrada RegisterFile (write)

begin
ulaop: ULA port map(
	flagZ   => s_flagz,
	in_A    => s_rd1,
	in_B    => s_rd2_final,
	op      => OP,
	out_ULA => s_out_ula
);
rf0 : RegisterFile port map(
	CLK => CLK, 		-- Clock geral
	A1  => A1, 		-- O selecionar leitura 1
	A2  => A2, 		-- O selecionar leitura 2
    A3  => A3, 		-- Selecionar de escrita
    WD3 => s_out_ula, 	-- Barramento de dados de escrita
    WE3 => WE3, 		-- Write enable (clock rise)
    RST => RST, 		-- Zera tudo
    RD1 => s_rd1, 		-- Dados lidos 1
    RD2 => s_rd2  		-- Dados lidos 2
);

s_rd2_final <= s_rd2 when SELECT_MUX = '0' else CTE_EXT;

end architecture;