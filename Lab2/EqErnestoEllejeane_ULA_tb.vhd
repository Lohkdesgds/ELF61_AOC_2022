-- Projeto ULA
-- Equipe: Ernesto & Ellejeane

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity testbench is
end;

architecture final_testbench of testbench is
    component ULA
        port (
            flug : out std_logic;
            in_a : in unsigned(15 downto 0);
            in_b : in unsigned(15 downto 0);
            oop : in std_logic_vector(1 downto 0);
            ouu : out unsigned(15 downto 0)
        );
    end component;
    
    signal i1 : unsigned(15 downto 0); -- in_a
    signal i2 : unsigned(15 downto 0); -- in_b
    signal pp : std_logic_vector(1 downto 0); -- oop
    signal oo : unsigned(15 downto 0); -- ouu
    signal mflug : std_logic; -- flug
    signal cntx, cnty : unsigned(15 downto 0) := to_unsigned(0, 16);
    begin
    -- uut significa Unit Under Test
    uut: ULA port map( in_a => i1, in_b => i2, oop => pp, ouu => oo, flug => mflug );
    process
    begin
        i1 <= to_unsigned(4965, 16); -- ellejeane
        i2 <= to_unsigned(5716, 16); -- ernesto
        pp <= "00";
        wait for 50 ns;
        pp <= "01";
        wait for 50 ns;
        pp <= "10";
        wait for 50 ns;
    
        cntx <= to_unsigned(0, 16);
        cnty <= to_unsigned(0, 16);
        
        for x in 0 to 7 loop
            for y in 0 to 7 loop
                i1 <= cntx;
                i2 <= cnty;
                cnty <= cnty + to_unsigned(8192, 16);
                pp <= "00";
                wait for 50 ns;
            end loop;
            cnty <= to_unsigned(0, 16);
            cntx <= cntx + to_unsigned(8192, 16);
        end loop;
        
        cntx <= to_unsigned(0, 16);
        cnty <= to_unsigned(0, 16);
        
        for x in 0 to 7 loop
            for y in 0 to 7 loop
                i1 <= cntx;
                i2 <= cnty;
                cnty <= cnty + to_unsigned(8192, 16);
                pp <= "01";
                wait for 50 ns;
            end loop;
            cnty <= to_unsigned(0, 16);   
            cntx <= cntx + to_unsigned(8192, 16);
        end loop;
        
        cntx <= to_unsigned(0, 16);
        cnty <= to_unsigned(0, 16);
        
        for x in 0 to 7 loop
            for y in 0 to 7 loop
                i1 <= cntx;
                i2 <= cnty;
                cnty <= cnty + to_unsigned(8192, 16);
                pp <= "10";
                wait for 50 ns;
            end loop;
            cnty <= to_unsigned(0, 16);
            cntx <= cntx + to_unsigned(8192, 16);
        end loop;
        wait;
    end process;
end architecture;
