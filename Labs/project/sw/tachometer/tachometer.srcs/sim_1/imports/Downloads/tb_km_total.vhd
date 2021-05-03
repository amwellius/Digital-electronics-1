library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_total_km_cnt is
end entity tb_total_km_cnt;

architecture testbench of tb_total_km_cnt is
    constant c_CLK_PERIOD : time := 1 ns;
    signal s_clk       	: std_logic;
    signal s_rst      	: std_logic;
    signal s_mode		: std_logic;
    signal s_enable     : std_logic;
    signal s_meters		: std_logic;
    signal s_data 		: unsigned(15 downto 0);

begin
    uut_total_km_cnt : entity work.total_km_cnt
        port map(
        	clk			=> s_clk,
        	rst			=> s_rst,
 			mode_i  	=> s_mode,
 			enable_i    => s_enable,
        	meters_i	=> s_meters,
        
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
        s_enable <= '1';
        s_rst <= '0';
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        
        s_mode <= '1';
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '0';
        
        s_mode <= '0'; wait for 10 ns;
        
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 10 ns;
        s_meters <= '1'; wait for 10 ns;
        s_meters <= '0'; wait for 30 ns;
        s_meters <= '0';
         wait;
        report "---stop---" severity note;
    end process p_stimulus;

end architecture testbench;