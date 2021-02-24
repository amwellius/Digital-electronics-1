------------------------------------------------------------------------
--
-- Testbench for 4-bit binary comparator.
-- EDA Playground
--
-- Copyright (c) 2020-2021 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_comparator_4bit is
    -- Entity of testbench is always empty
end entity tb_comparator_4bit;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_comparator_4bit is

    -- Local signals
    signal s_a       	 : std_logic_vector(4 - 1 downto 0);
    signal s_b       	 : std_logic_vector(4 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    -- Connecting testbench signals with comparator_4bit entity (Unit Under Test)
    uut_comparator_4bit : entity work.comparator_4bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;


        -- 0 test values
        s_b <= "0001"; s_a <= "1111"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0001, 1111" severity error;
        
        -- 1 test values
        s_b <= "0010"; s_a <= "1110"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0010, 1110" severity error;
        
        -- 2 test values				WRONG (001)
        s_b <= "0011"; s_a <= "1101"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 0011, 1101" severity error;
        
        -- 3 test values
        s_b <= "0100"; s_a <= "1100"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0100, 1100" severity error;
        
        -- 4 test values
        s_b <= "0101"; s_a <= "1011"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0101, 1011" severity error;
        
        -- 5 test values
        s_b <= "0110"; s_a <= "1010"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0110, 1010" severity error;
        
        -- 6 test values
        s_b <= "0111"; s_a <= "1001"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))        
        -- If false, then report an error
        report "Test failed for input combination: 0111, 1001" severity error;
        
        -- 7 test values
        s_b <= "1000"; s_a <= "1000"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1000, 1000" severity error;
        
        -- 8 test values
        s_b <= "1001"; s_a <= "0111"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1001, 0111" severity error;
        
        -- 9 test values
        s_b <= "1010"; s_a <= "0110"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1010, 0110" severity error;
        
        -- 10 test values
        s_b <= "1011"; s_a <= "0101"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1011, 0101" severity error;
        
        -- 11 test values
        s_b <= "1100"; s_a <= "0100"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1100, 0100" severity error;
        
        -- 12 test values
        s_b <= "0000"; s_a <= "0000"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 0000, 0000" severity error;
        
        -- 13 test values
        s_b <= "1101"; s_a <= "0011"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 0011, 0001" severity error;
        
        -- 14 test values
        s_b <= "1110"; s_a <= "0010"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1110, 0010" severity error;
        
        -- 15 test values
        s_b <= "1111"; s_a <= "0001"; wait for 100 ns;        
        -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))        
        -- If false, then report an error
        report "Test failed for input combination: 1111, 0001" severity error;
        
        
        
        -- WRITE OTHER TESTS HERE


        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
