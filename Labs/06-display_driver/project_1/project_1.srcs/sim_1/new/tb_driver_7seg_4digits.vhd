------------------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_data0_i    : std_logic_vector(4 - 1 downto 0);
    signal s_data1_i    : std_logic_vector(4 - 1 downto 0);
    signal s_data2_i    : std_logic_vector(4 - 1 downto 0);
    signal s_data3_i    : std_logic_vector(4 - 1 downto 0);
    
    signal s_dp_i       : std_logic_vector(4-1 downto 0);
    signal s_dp_o       : std_logic;    
    signal s_seg_o      : std_logic_vector(7-1 downto 0);    
    signal s_dig_o      : std_logic_vector(4-1 downto 0);      
    --- WRITE YOUR CODE HERE

begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_driver_7seg : entity work.driver_7seg_4digits
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,      
            data0_i => s_data0_i,
            data1_i => s_data1_i,
            data2_i => s_data2_i,
            data3_i => s_data3_i,           
              
            dp_i    => s_dp_i,  
            dp_o    => s_dp_o,  
            seg_o   => s_seg_o, 
            dig_o   => s_dig_o
    );
            

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE
    p_reset_gen : process
        begin
            s_reset <= '0';
            wait for 10 ns;
            s_reset <= '1';   
            wait for 53 ns;
            s_reset <= '0';
            wait;
        end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE
    p_stimulus: process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        s_data3_i     <= "0011";
        s_data2_i     <= "0001";
        s_data1_i     <= "0100";
        s_data0_i     <= "0010";
        s_dp_i        <= "0111";
        
        wait for 600 us;
         s_data3_i     <= "0011";
        s_data2_i      <= "0001";
        s_data1_i      <= "0100";
        s_data0_i      <= "0111";
        
        wait for 300 us;
        assert(s_dp_o = '0') 
        report "Problem with decimal dot" severity note;
        
        wait for 300 us; 
        assert(s_seg_o /= "0000111")         
        report "Something went wrong" severity note;        
        
        
        report "Stimulus process finished. " severity note;
        
        wait;
        end process p_stimulus;
        
end architecture testbench;
