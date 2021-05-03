library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_total_time is
end entity tb_total_time;

architecture testbench of tb_total_time is
    constant c_CLK_PERIOD : time := 1 ns;
    signal s_clk       	: std_logic;
    signal s_toggle     : std_logic;
    signal s_rst      	: std_logic;
    signal s_mode		: std_logic;
    signal s_data 		: unsigned(15 downto 0);

begin
    uut_total_time : entity work.total_time
        port map(
        	clk			=> s_clk,
        	rst			=> s_rst,
 			mode_i  	=> s_mode,
 			toggle_i    => s_toggle,
        
        	data_o 		=> s_data	
        );
	p_clock : process
    begin
        while now < 1000 ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_PERIOD / 2;
        end loop;
        wait;
    end process p_clock;
    p_stimulus : process
    begin

        report "---start---" severity note;
        s_mode <= '0';
        s_rst <= '0';
        s_toggle <= '0';
        wait for 10 ns;
        s_toggle <= '1';wait for 5 ns;
        s_toggle <= '0';
        wait for 100 ns;
        s_toggle <= '1';wait for 5 ns;
        s_toggle <= '0';
        wait for 100 ns;
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0';
        
       wait for 100 ns;
        s_toggle <= '1';wait for 1 ns;
        s_toggle <= '0';
        wait for 100 ns;
        s_rst <= '1'; wait for 1 ns;
        s_rst <= '0';
         wait;
        report "---stop---" severity note;
    end process p_stimulus;

end architecture testbench;