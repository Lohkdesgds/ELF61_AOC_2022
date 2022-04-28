-- Projeto Banco de registradores
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile_TB is
end;

architecture a_RegisterFile_TB of RegisterFile_TB is

constant RA_Ernesto: 	unsigned(15 downto 0) := to_unsigned(5716, 16); -- nao cabe (limite 65535), entao foi pego 4 ultimos digitos
constant RA_Ellejeane: 	unsigned(15 downto 0) := to_unsigned(4965, 16); -- nao cabe (limite 65535), entao foi pego 4 ultimos digitos

component RegisterFile
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
end component;

signal s_CLK : std_logic			 := '0';    			-- Clock geral
signal s_A1  : unsigned(2 downto 0)	 := "000";    			-- O selecionar leitura 1
signal s_A2  : unsigned(2 downto 0)	 := "000";    			-- O selecionar leitura 2
signal s_A3  : unsigned(2 downto 0)	 := "000";    			-- Selecionar de escrita
signal s_WD3 : unsigned(15 downto 0) := "0000000000000000"; -- Barramento de dados de escrita
signal s_WE3 : std_logic			 := '0';    			-- Write enable (clock rise)
signal s_RST : std_logic			 := '0';    			-- Zera tudo
signal s_RD1 : unsigned(15 downto 0);				    	-- Dados lidos 1
signal s_RD2 : unsigned(15 downto 0);				    	-- Dados lidos 2

begin
uut: RegisterFile port map( CLK => s_CLK,
							A1  => s_A1, 
							A2  => s_A2, 
							A3  => s_A3, 
							WD3 => s_WD3,
							WE3 => s_WE3,
							RST => s_RST,
							RD1 => s_RD1,
							RD2 => s_RD2 );
							
process
begin
	--seta o clock
	s_CLK <= '0';
	wait for 50 ns;
	s_CLK <= '1';
	wait for 50 ns;
end process;

--process
--begin
--	--seta o reset
--	s_RST <= '1';
--	wait for 100 ns;
--	s_RST <= '0';
--	wait;
--end process;

process
begin
	-- Do prof: 
	--   O roteiro do testbench deve mostrar um reset explicito,
	-- a escrita dos RAs dos alunos da equipe em registradores
	-- distintos e a leitura dos 2 RAs em RD2 e em seguida em RD1.  

	-- >>> Reset explicito <<
	
	s_RST <= '1';	
	wait for 100 ns;	
	s_RST <= '0';
	
	-- >>> ESCRITA DOS RA <<<
	
	-- Escrita de um dos RA em algum lugar
	s_WE3 <= '0'; -- trava escrita garantido
	s_WD3 <= RA_Ernesto;
	s_A3 <= "010"; -- escreve aqui
	s_WE3 <= '1'; -- libera escrita
	
	wait for 100 ns;
	
	-- Escrita do segundo RA em algum outro lugar
	s_WE3 <= '0'; -- trava escrita garantido
	s_WD3 <= RA_Ellejeane;
	s_A3 <= "110"; -- escreve aqui
	s_WE3 <= '1'; -- libera escrita
	
	wait for 100 ns;
		
	s_WE3 <= '0'; -- nao escreve mais
	s_A1 <= "000"; -- reset
	s_A2 <= "000"; -- reset	
	s_A3 <= "000"; -- para deixar limpo
	
	-- >>> LEITURA DOS RA EM RD2 <<<
	
	
	s_A2 <= "010"; -- ler tal posicao
	
	wait for 100 ns; -- s_RD2 deve ter valor do RA
	
	s_A2 <= "110"; -- ler tal posicao
	
	wait for 100 ns; -- s_RD2 deve ter valor do RA
		
	s_A2 <= "000"; -- reset
	
	-- >>> LEITURA DOS RA EM RD1 <<<	
	
	s_A1 <= "010"; -- ler tal posicao
	
	wait for 100 ns; -- s_RD1 deve ter valor do RA
	
	s_A1 <= "110"; -- ler tal posicao
	
	wait for 100 ns; -- s_RD1 deve ter valor do RA
	
	s_A1 <= "000"; -- reset

	wait;
end process;

end architecture;
