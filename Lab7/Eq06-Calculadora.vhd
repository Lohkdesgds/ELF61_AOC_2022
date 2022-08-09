-- Projeto Calculadora Programável
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Calculadora is 
	port(
		clk, rst: in std_logic
	);
end entity;

architecture a_Calculadora of Calculadora is 
	
	constant c_FETCH:  unsigned(1 downto 0) := "00";
	constant c_DECODE: unsigned(1 downto 0) := "01";
	constant c_EXEC:   unsigned(1 downto 0) := "10";
	
	constant c_op_NOP : unsigned(2 downto 0) := "000"; -- NOP
	constant c_op_BRNE: unsigned(2 downto 0) := "001"; -- BRNE
	constant c_op_ADD : unsigned(2 downto 0) := "010"; -- ADD
	constant c_op_SUB : unsigned(2 downto 0) := "011"; -- SUB
	constant c_op_REM : unsigned(2 downto 0) := "100"; -- REM
	constant c_op_MOV : unsigned(2 downto 0) := "101"; -- MOV
	constant c_op_LDI : unsigned(2 downto 0) := "110"; -- LDI
	constant c_op_RJMP: unsigned(2 downto 0) := "111"; -- RJMP

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
		
		SELECT_MUX : in std_logic;  		  -- Usa constante externa? '1' = sim

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
		
	component opcoder is
	port(
		rawop : in unsigned(8 downto 0);
		instrcode : out unsigned(2 downto 0)
	);
	end component;
	
	component RegisterFlags is 
	port (
		CLK          : in std_logic;
		WE           : in std_logic;
		FLAGS_STORE  : in std_logic;
		FLAGS_READ   : out std_logic;
		RST          : in std_logic
	);
	end component;

	-- PC
	signal s_pc : unsigned(15 downto 0) := (others => '0');
	signal s_calcnext_pc : unsigned(15 downto 0) := (others => '0');
	signal s_next_pc : unsigned(15 downto 0) := (others => '0');

	-- estado
	signal s_estado : unsigned(1 downto 0) := (others => '0');

	-- flags:
	signal s_ler_rom : std_logic := '0';
	signal s_avancar_pc : std_logic := '0';
	signal s_exec_ularegs : std_logic := '0'; -- habilitado se c_EXEC e s_opcode_asm for add, sub, 

	-- ROM:
	signal s_dados_rom : unsigned(15 downto 0) := (others => '0');

	-- instrução inteira:
	signal s_opcode_asm : unsigned(8 downto 0) := (others => '0'); -- pode ter até 9 bits indicando op (caso: BRNE)
	signal s_opcode_code : unsigned(2 downto 0) := (others => '0'); -- traduzido diretamente

	-- fatias:
	signal s_instr_rd : unsigned(4 downto 0) := (others => '0'); -- read/write
	signal s_instr_rr : unsigned(4 downto 0) := (others => '0'); -- read
	signal s_cte_ulareg : unsigned(11 downto 0) := (others => '0'); -- nossa impl tem constante até 12 bits

	-- flag stuff	
	signal s_storeflag : std_logic := '0'; -- flag pra salvar flags (write enable)
	signal s_flags_tostore : std_logic := '0'; -- links para salvar
	signal s_flags_inuse : std_logic := '0'; -- em uso no código

	-- casos
	signal s_is_cte : std_logic := '0'; -- relacionado com s_cte_ulareg, usar constante externa?
	signal s_op_ulareg : std_logic_vector(1 downto 0) := (others => '0'); -- usado se opcode_asm for do tipo add, sub ou rem

	-- sinais conectados 
	signal s_cte_ulareg_interm : unsigned(15 downto 0) := (others => '0'); -- o meio entre s_cte_ulareg e onde será definido
begin 
	mah_flags : RegisterFlags port map(
		CLK => clk,
		WE => s_storeflag,
		FLAGS_STORE => s_flags_tostore,
		FLAGS_READ => s_flags_inuse,
		RST => rst
	);
	pc_sum : unidade_somadora_pc port map(
		pc_now => s_calcnext_pc,
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
		FLAGZ => s_flags_tostore
	);
	raaaw : opcoder port map(
		rawop => s_opcode_asm,
		instrcode => s_opcode_code
	);

	-- FETCH
	s_ler_rom <= '1' when s_estado = c_FETCH else '0';

	-- DECODE
	s_opcode_asm <= (s_dados_rom(15 downto 10) & s_dados_rom(2 downto 0)); -- separa até 9
	s_instr_rr <= 
		(s_dados_rom(9) & s_dados_rom(3 downto 0)) when (s_opcode_code >= to_unsigned(2, 3) and s_opcode_code <= to_unsigned(5, 3)) else
		(others => '0');
	s_instr_rd <= 
		(s_dados_rom(8 downto 4)) when (s_opcode_code >= to_unsigned(2, 3) and s_opcode_code <= to_unsigned(5, 3)) else
		('0' & s_dados_rom(7 downto 4)) when s_opcode_code = 6 else
		(others => '0');
	s_cte_ulareg <= -- ajustado para casos negativos
		("00000" & s_dados_rom(9 downto 3)) when ((s_opcode_code = to_unsigned(1, 3)) and s_dados_rom(9) = '0') else
		("11111" & s_dados_rom(9 downto 3)) when ((s_opcode_code = to_unsigned(1, 3)) and s_dados_rom(9) = '1') else
		("0000" & s_dados_rom(11 downto 8) & s_dados_rom(3 downto 0)) when (s_opcode_code = to_unsigned(6, 3) and s_dados_rom(11) = '0') else
		("1111" & s_dados_rom(11 downto 8) & s_dados_rom(3 downto 0)) when (s_opcode_code = to_unsigned(6, 3) and s_dados_rom(11) = '1') else
		(s_dados_rom(11 downto 0)) when (s_opcode_code = to_unsigned(7, 3)) else 
		(others => '0');

	s_op_ulareg <=
		"00" when s_opcode_code = to_unsigned(2, 3) else -- add
		"01" when s_opcode_code = to_unsigned(3, 3) else -- sub
		"10" when s_opcode_code = to_unsigned(4, 3) else -- rem
		"11" when s_opcode_code = to_unsigned(5, 3) or s_opcode_code = to_unsigned(6, 3) or s_opcode_code = to_unsigned(0, 3) else -- mov, ldi, nop
		"00"; -- rjmp, brne
		
	s_calcnext_pc <= (s_cte_ulareg_interm + s_pc) when (s_opcode_code = to_unsigned(7, 3)) or (s_opcode_code = to_unsigned(1, 3) and s_flags_inuse = '1') else s_pc;
		
	-- EXEC
	s_storeflag <= '1' when s_estado = c_EXEC else '0';
	s_avancar_pc <= '1' when s_estado = c_EXEC else '0';
	s_is_cte <= '1' when s_opcode_code = to_unsigned(1, 3) or (s_opcode_code >= to_unsigned(6, 3) and s_opcode_code <= to_unsigned(7, 3)) else '0';
	s_exec_ularegs <= '1' when ((s_opcode_code >= to_unsigned(2, 3) and s_opcode_code <= to_unsigned(6, 3)) and s_estado = c_EXEC) else '0';

	-- outros
	s_cte_ulareg_interm <= 
		("1111" & s_cte_ulareg) when s_cte_ulareg(11) = '1' else
		("0000" & s_cte_ulareg); -- funciona pra + e -
	
end architecture;
						
						
	