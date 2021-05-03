library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_button_int is
end entity tb_button_int;

architecture testbench of tb_button_int is

    signal s_up_i	: std_logic;
    signal s_down_i	: std_logic;
    signal s_ok_i 	: std_logic;
    
    signal s_st_o	: std_logic;
    signal s_up_o	: std_logic;
    signal s_down_o	: std_logic;
    signal s_rst_o	: std_logic;
    
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    signal s_clk : std_logic;

begin
    uut_button_int : entity work.button_int
        port map(
        	clk		=> s_clk,
            up_i	=> s_up_i,
            down_i	=> s_down_i,
            ok_i	=> s_ok_i,
            
            st_o	=> s_st_o,
            up_o	=> s_up_o,
            down_o	=> s_down_o,
            rst_o	=> s_rst_o
        );
	p_clock : process
    begin
    	while now < 1500 ns loop
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clock;
    
    p_stimulus : process
    begin

        report "---start---" severity note;
        s_up_i <= '0';
        s_down_i <= '0';
        s_ok_i <= '0';
        wait for 10 ns;
        
        s_up_i <= '1'; wait for 11 ns;
        s_up_i <= '0'; wait for 160 ns;
        
        s_down_i <= '1'; wait for 11 ns;
        s_down_i <= '0'; wait for 160 ns;
        
        s_ok_i <= '1'; wait for 11 ns;
        s_ok_i <= '0'; wait for 400 ns;
        
        s_ok_i <= '1'; wait for 11 ns;
        s_ok_i <= '0'; wait for 30 ns;
        
        s_ok_i <= '1'; wait for 11 ns;
        s_ok_i <= '0'; wait for 100 ns;
        
        s_ok_i <= '1'; wait for 11 ns;
        s_ok_i <= '0';
        
        
        
        wait;       
        report "---stop---" severity note;
    end process p_stimulus;

end architecture testbench;