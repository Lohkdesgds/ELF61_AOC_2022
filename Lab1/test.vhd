library ieee;
use ieee.std_logic_1164.all;
-- uma entidade é definida por arquivo
entity testbench is
end;

architecture final_testbench of testbench is
    component decoder
        port (
            in_vec : in std_logic_vector(2 downto 0);
            out_vec : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal iv : std_logic_vector(2 downto 0);
    signal ov : std_logic_vector(7 downto 0);
    begin
    -- uut significa Unit Under Test
    uut: decoder port map( in_vec => iv, out_vec => ov );
    process
    begin
        iv <= "000";
        wait for 50 ns;
        iv <= "001";
        wait for 50 ns;
        iv <= "010";
        wait for 50 ns;
        iv <= "011";
        wait for 50 ns;
        iv <= "100";
        wait for 50 ns;
        iv <= "101";
        wait for 50 ns;
        iv <= "110";
        wait for 50 ns;
        iv <= "111";
        wait for 50 ns;
        wait;
    end process;
end architecture;
