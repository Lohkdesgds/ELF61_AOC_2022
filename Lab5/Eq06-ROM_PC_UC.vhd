-- Projeto ROM_PC_UC
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_PC_UC is 
	port(
		clk, rst: in std_logic
	);
end entity;

architecture a_ROM_PC_UC of ROM_PC_UC is 
	
	constant c_FETCH: std_logic := '0';
	constant c_EXEC: std_logic := '1';

	component maq_estados is 
	port(
		clk, rst: in std_logic;
		estado: out std_logic
	);
	end component;
	
	component rom is 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(7 downto 0) 		:= x"00"
	);
	end component;
	
	component program_counter is
	port(
		clk, wr_en, rst : in std_logic;
		data_in: in unsigned(15 downto 0);
		data_out: out unsigned(15 downto 0)
	);
	end component;
	
	component unidade_somadora_pc is 
	port (
		pc_now: in unsigned(15 downto 0);
		pc_next: out unsigned(15 downto 0)
	);
	end component;
	
	-- | PARTE PC +1 | --
	signal s_pc_currpc     : unsigned(15 downto 0) := (others => '0');
	signal s_pc_nextpc     : unsigned(15 downto 0) := (others => '0');
	signal s_pc_currpcplus : unsigned(15 downto 0) := (others => '0');
	
	signal s_pc_advance : std_logic := '1'; -- sinal pra avançar no PC
	
	-- | PARTE ESTADO | --
	signal s_estado : std_logic; -- no momento [0..1] ou (FETCH, EXEC)
	
	-- | Variáveis de apoio | --
	signal s_datapc : unsigned(7 downto 0) 		:= (others => '0'); -- as instruções em si
	signal s_opcode : unsigned(2 downto 0) 		:= (others => '0'); -- 3 bits de OP
	signal s_instrdata : unsigned (4 downto 0) 	:= (others => '0'); -- 5 bits restantes
begin 
	pc_sum : unidade_somadora_pc port map(
		pc_now => s_pc_currpc,
		pc_next => s_pc_currpcplus
	);
	pc_test : program_counter port map(
		clk => clk,
		wr_en => s_pc_advance,
		rst => rst,
		data_in => s_pc_nextpc,
		data_out => s_pc_currpc
	);
	maq_estados_op: maq_estados port map (
		clk => clk,
		rst => rst,
		estado => s_estado
	);
	approm : rom port map(
		clk => s_pc_advance,
		endereco => s_pc_currpc,
		dado => s_datapc
	);
	
	s_pc_advance <= '1' when s_estado = c_EXEC else '0';
	
	s_opcode <= s_datapc(7 downto 5);
	s_instrdata <= s_datapc(4 downto 0);
	
	s_pc_nextpc <= 
		(x"00" & "000" & s_instrdata) when s_opcode = "111" else -- "deve ser usado endereço absoluto"
		s_pc_currpcplus; -- se não for JUMP, avança 1
	
end architecture;