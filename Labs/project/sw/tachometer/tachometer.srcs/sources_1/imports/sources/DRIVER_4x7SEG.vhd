----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 13:21:08
-- Design Name: 
-- Module Name: DECODER_7SEG - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module drives four 7segment displays. It is determinated by CLOCK and UP_DOWN_COUNTER modules. 
-- Process MUX uses above modules to set data_outputs to each 7segment display.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity DRIVER_4x7SEG is
    port(
        clk     : in  std_logic;        -- Main clock
        reset   : in  std_logic;        -- Synchronous reset
        --16-bit main input data
        data_i  : in   unsigned(16 - 1 downto 0);  
        -- 1-bit input value for decimal points and colon
        dp_i    : in  std_logic;
        dd_i    : in  std_logic; 
        
        dp_o     : out std_logic;
        dd_o     : out std_logic;
        dd_dig_o : out std_logic := '1';
        -- Cathode values for individual segments
        seg_o   : out std_logic_vector(7 - 1 downto 0);
        -- Common catode signals to individual displays
        dig_o   : out std_logic_vector(4 - 1 downto 0)
    );
end entity DRIVER_4x7SEG;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of DRIVER_4x7SEG is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(2 - 1 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : unsigned(4 - 1 downto 0);

begin
    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 4 ms 
    clk_en0 : entity work.CLOCK
        generic map(
           -- g_MAX => 4            --only for tests
            g_MAX => 400000         --every 4ms

        )
        port map(
            clk   => clk,      -- Main clock
            reset => reset,  -- Synchronous reset
            ce_o  =>  s_en


        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit down
    -- counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
                  g_CNT_WIDTH => 2
                                       
        )
        port map(
            clk         =>  clk,
            reset       =>  reset,
            en_i        =>  s_en,
            cnt_up_i    =>  '0',
            cnt_o       =>  s_cnt
        );

    --------------------------------------------------------------------
    -- Instance (copy) of DECODER_7SEG entity performs a 7-segment display
    -- decoder
    hex2seg : entity work.DECODER_7SEG
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );

    --------------------------------------------------------------------
    -- p_mux:
    -- A combinational process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point signal, and 
    -- switches the common catodes of each display.
    --------------------------------------------------------------------
    p_mux : process(s_cnt, data_i, dp_i, dd_i)
    begin
-- Main input data is 1x16bits. We have 4 7segmnet displays. This main data input has to be changed
-- to be used in this code. In that case, this operation is displayed below(only demonstation(cannot be used in VHDL as below)): 
--        data3_i <= data_i(3  downto 0 );
--        data2_i <= data_i(7  downto 4 );
--        data1_i <= data_i(11 downto 8 );
--        data0_i <= data_i(15 downto 12);

        case s_cnt is
            when "11" =>
                s_hex <= data_i(15 downto 12);
                dd_o  <= dd_i;               
                dig_o <= "1000";    --1st disp(from left to right)
            when "10" =>
                s_hex <= data_i(11 downto 8);
                dd_o  <= dd_i;
                dig_o <= "0100";    --2nd disp
            when "01" =>
                s_hex <= data_i(7 downto 4);
                dp_o  <= dp_i;      --dp will be used only with this display
                dd_o  <= dd_i;
                dig_o <= "0010";    --3rd disp
            when others =>
                s_hex <= data_i(3 downto 0);
                dd_o  <= dd_i;
                dig_o <= "0001";    --4th disp
        end case;

-- In TOP module:        
-- s_hex is the data to be displayed
-- dig_o is the definition of which display to be used for representation the s_hex data (data_i)
--      
    end process p_mux;
end architecture Behavioral;

