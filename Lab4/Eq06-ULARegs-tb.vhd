-- Projeto Banco de registradores
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULARegs_TB is
end;

architecture a_ULARegs_TB of ULARegs_TB is

constant c_RA_Ernesto: 		unsigned(15 downto 0) := to_unsigned(5716, 16); -- truncado em decimal
constant c_RA_Ellejeane: 	unsigned(15 downto 0) := to_unsigned(4965, 16); -- truncado em decimal

constant c_OP_ADD : std_logic_vector(1 downto 0) := "00";
constant c_OP_SUB : std_logic_vector(1 downto 0) := "01";
constant c_OP_REM : std_logic_vector(1 downto 0) := "10";

component ULARegs
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
end component;

signal s_CLK : std_logic := '0';
signal s_RST : std_logic := '0';
signal s_WE3 : std_logic := '0';
signal s_OP : std_logic_vector(1 downto 0) := "00";

signal s_A1 : unsigned(2 downto 0) := "000";
signal s_A2 : unsigned(2 downto 0) := "000";
signal s_A3 : unsigned(2 downto 0) := "000";
signal s_CTE_EXT : unsigned(15 downto 0) := "0000000000000000";
signal s_SELECT_MUX : std_logic := '0';

begin
ulareg0 : ULARegs port map(
	CLK        => s_CLK, 
	RST        => s_RST, 
	WE3        => s_WE3, 
	OP         => s_OP, 
	A1         => s_A1, 
	A2 	       => s_A2,
	A3 	       => s_A3,
	CTE_EXT	   => s_CTE_EXT,
	SELECT_MUX => s_SELECT_MUX
);

CLOCK: process
begin
	s_CLK <= '0';
	wait for 50 ns;
	s_CLK <= '1';
	wait for 50 ns;
end process;

TEST: process
begin
	-------------------------------------------------------------------------------------------------
	-- Algumas partes foram repetidas apenas para facilitar a leitura do que o bloco esta fazendo
	-- Eh claro que, por ex, s_WE3, continua sendo o mesmo em diversos passos, mas fica bem mais
	-- pratico de ler sabendo o que cada bloco tem de valor naquele momento.
	-- O objetivo nao foi fazer o menor codigo possivel.
	-------------------------------------------------------------------------------------------------

	-- "Inicialmente um reset explicito"
	
	s_RST <= '1';
	wait for 75 ns;
	
	-- "seguido de 2 escritas dos RAs truncados em registradores distintos R3 e R4"
	
	s_RST <= '0';
	
	s_OP <= c_OP_ADD;	
	s_A1 <= "000"; -- zero
	s_A3 <= "011"; -- escrita: R3
	s_CTE_EXT <= c_RA_Ernesto;
	s_SELECT_MUX <= '1'; -- usa constante externa no RD2
	s_WE3 <= '1';
	
	wait for 100 ns;
	
	s_OP <= c_OP_ADD;
	s_A1 <= "000"; -- zero
	s_A3 <= "100"; -- escrita: R4
	s_CTE_EXT <= c_RA_Ellejeane;
	s_SELECT_MUX <= '1'; -- usa constante externa no RD2
	s_WE3 <= '1';
	
	wait for 100 ns;
	
	-- [...] "o caculo do resto da divisao entre dois deles escrito em R1 (o maior pelo menor)"
	-- --> c_RA_Ernesto > c_RA_Ellejeane, #3 pelo #4
	
	s_OP <= c_OP_REM;
	s_A1 <= "011"; -- R3
	s_A2 <= "100"; -- R4
	s_A3 <= "001"; -- escrita: R1
	s_SELECT_MUX <= '0'; -- nao usa const externa
	s_WE3 <= '1';
	
	wait;
	
end process;

end architecture;