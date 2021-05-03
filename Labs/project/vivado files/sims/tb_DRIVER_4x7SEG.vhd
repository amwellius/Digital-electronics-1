----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 14:56:33
-- Design Name: 
-- Module Name: tb_DRIVER_4x7SEG - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_DRIVER_4x7SEG is
    -- Entity of testbench is always empty
end entity tb_DRIVER_4x7SEG;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_DRIVER_4x7SEG is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    
    signal s_data_i     : std_logic_vector(16 - 1 downto 0);        -- Main data input. Refresh time is changed
                                                                    -- according to diffrent modules
    --std_logic can be used as well
    signal s_dp_i       : std_logic_vector(1 - 1 downto 0);
    signal s_dp_o       : std_logic_vector(1 - 1 downto 0);
    signal s_dd_i       : std_logic_vector(1 - 1 downto 0);
    signal s_dd_o       : std_logic_vector(1 - 1 downto 0);   
    --output signals, will be used and connected in TOP module
    signal s_seg_o      : std_logic_vector(7-1 downto 0);    
    signal s_dig_o      : std_logic_vector(4-1 downto 0);     

begin
    -- Connecting testbench signals with DECODER_7SEG entity
    uut_DRIVER_4x7SEG : entity work.DRIVER_4x7SEG
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,  
            data_i  => s_data_i,
            
            dp_i    => s_dp_i,  
            dp_o    => s_dp_o,
            dd_i    => s_dd_i,  
            dd_o    => s_dd_o,  
            
            seg_o   => s_seg_o, 
            dig_o   => s_dig_o
    );
            

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 8000 ms loop         -- number of periods of 100MHz clock
      --while now < 750 ns loop          -- only for tests! (note ns(nano seconds) istead of ms(mili seconds))
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
            wait for 5 ns;
            s_reset <= '1';
            wait for 1 ns;
            s_reset <= '0';
            wait;
        end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus: process
    begin
        
        wait for 5 ns;
        s_data_i      <= "1111000000000001";
        wait for 1000 ms;
                
        s_dp_i        <= "1";
        s_dd_i        <= "1";        
        s_data_i      <= "1001001111010011"; 
        wait for 2000 ms;
        
        s_data_i      <= "0000001000000000";       
        wait for 1000 ms;  
        
        s_dp_i        <= "0";
        s_dd_i        <= "0";   
        s_data_i      <= "0000001000010011";        
        wait for 1000 ms;
        
        s_data_i      <= "0100001010010000";        
        wait for 1500 ms;
        
        s_data_i      <= "1111001010010010";        
        wait for 1500 ms;
        
        wait;
        end process p_stimulus;
        
end architecture testbench;

