-- Projeto Calculadora Programável
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
	
	constant c_FETCH: std_logic := "00";
	constant c_DECODE: std_logic := "01";
	constant c_EXEC: std_logic := "10";

	component ULARegs is 
	port (
		CLK : in std_logic;                   -- Clock geral
		RST : in std_logic;                   -- Zera tudo
		WE3 : in std_logic;                   -- Write enable
		OP : in std_logic_vector(1 downto 0); -- Operador (soma, sub, resto)
		
		A1 : in unsigned(4 downto 0);         -- Selecionar leitura 1 (arg1)     #2
		A2 : in unsigned(4 downto 0);         -- Selecionar leitura 2 (arg2)   \ #1
		A3 : in unsigned(4 downto 0);         -- Selecionar de escrita  (dest) / #0
		CTE_EXT : in unsigned(15 downto 0);   -- Constante externa
		
		SELECT_MUX : in std_logic,  		  -- Usa constante externa? '1' = sim

		FLAGZ : out std_logic                 -- Retorno da última operação (se a flag deu 0 ou 1)
	);
	end component;

	component maq_estados is 
	port(
		clk,rst: in std_logic;
		estado: out unsigned(1 downto 0)
	);
	end component;
	
	component rom is 
	port(
		clk: in std_logic;
		endereco: in unsigned(15 downto 0);
		dado: out unsigned(15 downto 0)
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

	-- PC
	signal s_pc : unsigned(15 downto 0);
	signal s_next_pc : unsigned(15 downto 0) := (others => '0');

	-- estado
	signal s_estado : unsigned(1 downto 0) := "00";

	-- flags:
	signal s_ler_rom : std_logic := '0';
	signal s_avancar_pc : std_logic := '0';
	signal s_exec_ularegs : std_logic := '0'; -- habilitado se c_EXEC e s_opcode_asm for add, sub, 

	-- ROM:
	signal s_dados_rom : unsigned(15 downto 0) := (others => '0');

	-- instrução inteira:
	signal s_opcode_asm : std_logic_vector(8 downto 0) := (others => '0'); -- pode ter até 9 bits indicando op (caso: BRNE)

	-- fatias:
	signal s_instr_rd := std_logic_vector(4 downto 0) := (others => '0'); -- read/write
	signal s_instr_rr := std_logic_vector(4 downto 0) := (others => '0'); -- read

	-- casos
	signal s_lastcase_flagz_true : std_logic := '0'; -- flagz para brne
	signal s_is_cte : std_logic := '0'; -- relacionado com s_cte_ulareg, usar constante externa?
	signal s_op_ulareg : std_logic_vector(1 downto 0); -- usado se opcode_asm for do tipo add, sub ou rem
	signal s_cte_ulareg : unsigned(7 downto 0) := (others => '0'); -- nossa impl permite apenas 8 bits

	-- sinais conectados 
	signal s_cte_ulareg_interm : unsigned(15 downto 0) := (others => '0'); -- o meio entre s_cte_ulareg e onde será definido
begin 
	pc_sum : unidade_somadora_pc port map(
		pc_now => s_pc,
		pc_next => s_next_pc
	);
	pc_test : program_counter port map(
		clk => clk,
		wr_en => s_avancar_pc,
		rst => rst,
		data_in => s_next_pc,
		data_out => s_pc
	);
	maq_estados_op: maq_estados port map (
		clk => clk,
		rst => rst,
		estado => s_estado
	);
	approm : rom port map(
		clk => s_ler_rom,
		endereco => s_pc,
		dado => s_dados_rom
	);
	ulafun : ULARegs port map(
		CLK => clk,
		RST => rst,
		WE3 => s_exec_ularegs,
		OP => s_op_ulareg,
		A1 => s_instr_rd,
		A2 => s_instr_rr,
		A3 => s_instr_rd,
		CTE_EXT => s_cte_ulareg_interm,
		SELECT_MUX => s_is_cte,
		FLAGZ => s_lastcase_flagz_true
	);
	
	s_avancar_pc <= '1' when s_estado = c_EXEC else '0';
	s_ler_rom <= '1' when  s_estado = c_FETCH else '0';

	s_cte_ulareg_interm <= ("00000000" & s_cte_ulareg);

	-- falta coisa aqui
	
end architecture;
						
						
	