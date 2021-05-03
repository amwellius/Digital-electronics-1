----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 23:40:20
-- Design Name: 
-- Module Name: tb_sensor - Behavioral
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

entity tb_sensor is
end tb_sensor;

architecture Behavioral of tb_sensor is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHz : std_logic;

    signal s_arst   : std_logic;
    signal s_sensor_i : std_logic;
    signal s_trigger_o : std_logic;
    
    signal s_disp_o : unsigned(16-1 downto 0);
    
begin

    uut_sensor : entity work.sensor
        port map(
            clk => s_clk_100MHz,
            arst => s_arst,
            sensor_i => s_sensor_i,
            trigger_o => s_trigger_o,
            disp_o => s_disp_o
        );
        
    p_clk_gen : process
    begin
        while now < 1100 ms loop         -- 1100 ms of 100MHZ clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process -- generate asynchronous reset
    begin
        s_arst <= '0';
        wait for 22 ns;
        s_arst <= '1';
        wait for 1 ns;
        s_arst <= '0';
        wait for 227 ns;
        s_arst <= '1';
        wait for 1 ns;
        s_arst <= '0';
        wait;
    end process p_reset_gen;

--    p_stimulus : process -- generate some sensor pulses    
--    begin                          
--        s_sensor_i <= '0';
--        wait for 10 ns;
--        s_sensor_i <= '1';
--        wait for 30 ns;
--        s_sensor_i <= '0';
--        wait for 300 ms;
--        s_sensor_i <= '1';
--        wait for 30 ns;   
--        s_sensor_i <= '0';    
--        wait for 250 ms;
--        s_sensor_i <= '1';
--        wait for 30 ns;
--        s_sensor_i <= '0';         
--        wait;                      
--    end process p_stimulus;

    p_signal_gen : process
    begin
        while now < 1100 ms loop         -- 1100 ms of 100MHZ clock
            s_sensor_i <= '0';
            wait for c_CLK_100MHZ_PERIOD;
            s_sensor_i <= '1';
            wait for c_CLK_100MHZ_PERIOD;
        end loop;
        wait;
    end process p_signal_gen;
            
end Behavioral;