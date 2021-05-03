----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2021 13:17:31
-- Design Name: 
-- Module Name: top - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port(
        CLK100MHZ   : in std_logic;
        ja          : inout std_logic_vector (8-1 downto 0);
        jb          : inout std_logic_vector (8-1 downto 0);
        jc          : inout std_logic_vector (8-1 downto 0);
        jd          : inout std_logic_vector (8-1 downto 0)
    );
end top;

architecture Behavioral of top is
    signal s_reset1     : std_logic;
    signal s_reset2     : std_logic;
    signal s_reset3     : std_logic;
    signal s_reset4     : std_logic;
    signal s_reset_km   : std_logic := s_reset1 or s_reset4;
    signal s_reset_time : std_logic := s_reset4 or s_reset2;
    signal s_reset_cal  : std_logic := s_reset4 or s_reset3;
    signal s_data1      : unsigned(16-1 downto 0);
    signal s_data2      : unsigned(16-1 downto 0);
    signal s_data3      : unsigned(16-1 downto 0);
    signal s_data4      : unsigned(16-1 downto 0);
    signal s_data_7seg  : unsigned(16-1 downto 0);
    signal s_dd         : std_logic;
    signal s_dp         : std_logic;
    signal s_trigger    : std_logic;
    signal s_mode       : std_logic;
    signal s_enable     : std_logic;
    signal s_rst        : std_logic;
    signal s_startstop  : std_logic;
    signal s_up         : std_logic;
    signal s_down       : std_logic;
    signal s_toggle     : std_logic;
    
begin
    driver_seg_4 : entity work.DRIVER_4x7SEG
        port map(
            clk                 => CLK100MHZ,
            reset               => '0',
            data_i              => s_data_7seg,
            dd_o                => jc(7),
            dp_o                => jc(6),
            dp_i                => s_dd,
            dd_i                => s_dp,
            seg_o(0)            => jb(7),
            seg_o(6 downto 1)   => jc(5 downto 0), 
            dig_o               => jb(5 downto 2),
            dd_dig_o            => jb(6)
        );
        
    sensor : entity work.sensor
        port map(
            clk         => CLK100MHZ,
            arst        => '0',
            sensor_i    => jd(7),
            trigger_o   => s_trigger,
            disp_o      => s_data4
        );
        
    km_total : entity work.total_km_cnt
        port map(
            clk         => CLK100MHZ,
            rst         => s_reset_km,
            mode_i      => s_mode,
            enable_i    => s_enable,
            meters_i    => s_trigger,
            data_o      => s_data1
        );
        
    time_total : entity work.total_time
        port map(
            clk         => CLK100MHZ,
            rst         => s_reset_time,
            mode_i      => s_mode,
            toggle_i    => s_toggle,
            data_o      => s_data2
        );
        
    calories : entity work.calories
        port map(
            clk     => CLK100MHZ,
            arst    => s_reset_cal,
            mode_i  => s_mode,
            sensorpads_i    => jd(6),
            enable_i        => s_enable,
            calsdisp_o      => s_data3
        );
        
    state_machine : entity work.state_machine
        port map(
            clk         => CLK100MHZ,
            rst         => s_rst,
            startstop   => s_startstop,
            up_i        => s_up,
            down_i      => s_down,
            data_1      => s_data1,
            data_2      => s_data2,
            data_3      => s_data3,
            data_4      => s_data4,
            data_o      => s_data_7seg,
            mode_o      => s_mode,
            enable_o    => s_enable,
            toggle_o    => s_toggle,
            reset_1     => s_reset1,
            reset_2     => s_reset2,
            reset_3     => s_reset3,
            reset_4     => s_reset4,
            dp_o        => s_dp,
            dd_o        => s_dd,
            LED_1       => ja(3),
            LED_2       => ja(7),
            LED_3       => ja(5),
            LED_4       => ja(4),
            LED_5       => ja(6)
        );
        
    button_int : entity work.button_int
        port map(
            clk     => CLK100MHZ,
            up_i    => ja(2),
            down_i  => ja(0),
            ok_i    => ja(1),
            st_o    => s_startstop,
            up_o    => s_up,
            down_o  => s_down,
            rst_o   => s_rst
        );
        
end Behavioral;
