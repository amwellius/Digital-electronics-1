-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_calories is

end entity tb_calories;

architecture testbench of tb_calories is
	
    constant clk_freq   : integer := 100e6; -- 100 MHz
	constant clk_per    : time    := 1000 ms / clk_freq;
	
	

	signal s_clk			: std_logic := '0';
    signal s_arst 			: std_logic := '0';
    signal s_sensorpads_i	: std_logic := '0';
    signal s_calsdisp_o		: unsigned (16 - 1 downto 0);
    signal s_mode_i         : std_logic := '0';
    signal s_enable_i       : std_logic := '0';


   
begin

	uut_calories: entity work.calories(behavioral)
    port map(
    	clk => s_clk,
        arst => s_arst,
        mode_i => s_mode_i,
        enable_i => s_enable_i,
        
        sensorpads_i => s_sensorpads_i,
        calsdisp_o => s_calsdisp_o
        );
        
     s_clk <= not s_clk after clk_per / 2;

     
    p_arst_gen : process is
    begin
        
        s_arst <= '1';
        
        wait for 2 ms; --first period of trigger (100ms), reset on
        s_arst <= '0'; --the rest of the time reset off
        wait;
    end process p_arst_gen;
    
    p_sensorpads_gen : process is
    begin
    
        s_mode_i <= '0';
        s_enable_i <= '0';
        s_sensorpads_i <= '1';
        wait for 10 ms;
        
        s_mode_i <= '1';
        s_enable_i <= '1';
        s_sensorpads_i <= '0';
        wait for 2500 ms;
        
        s_mode_i <= '1';
        s_enable_i <= '1';
        s_sensorpads_i <= '1';
        wait for 10 ms;
        
        s_mode_i <= '1';
        s_enable_i <= '0';
        s_sensorpads_i <= '0';
        wait for 2000 ms;
        
        s_mode_i <= '1';
        s_enable_i <= '0';
        s_sensorpads_i <= '1';
        wait for 10 ms;
        
        s_mode_i <= '0';
        s_enable_i <= '0';
        s_sensorpads_i <= '0';
        wait for 2500 ms;
        
        s_mode_i <= '0';
        s_enable_i <= '0';
        s_sensorpads_i <= '1';
        wait for 10 ms;
        
        wait;

        
    end process p_sensorpads_gen;
        
    
end architecture testbench;

