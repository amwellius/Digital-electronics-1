--state_machine.vhd
-- Main control block switching data outputs to display driver, 
--activates resets and lights up status LED's.
-- made by Matej Ledvina (221339)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port(
		startstop	: in  std_logic; -- st command from button_int
        clk		: in  std_logic; -- global 100MHz clock
        rst		: in  std_logic; -- rst command from button_int
        up_i	: in  std_logic; -- up command from button_int
        down_i	: in  std_logic; -- down command from button_int	
 		data_1	: in  unsigned(15 downto 0); --data from km_cnt
        data_2	: in  unsigned(15 downto 0); --data from time_cnt
        data_3	: in  unsigned(15 downto 0); --data from kal_cnt
        data_4	: in  unsigned(15 downto 0); --data from avg_speed
        
        data_o 		: inout unsigned(15 downto 0) := (others => '0'); --data to 7seg
        mode_o		: inout std_logic := '0'; --trip running signal
        enable_o	: inout std_logic := '0'; --trip pause/stop signal
	    toggle_o	: inout std_logic := '0'; --stopwatch toggle
        reset_1		: inout std_logic := '0'; --reset to km_cnt
        reset_2		: inout std_logic := '0'; --reset to time_cnt
        reset_3		: inout std_logic := '0'; --reset to kal_cnt
        reset_4		: inout std_logic := '0'; --global trip reset
        dp_o        : out   std_logic := '0';
        dd_o        : out   std_logic := '0';
        LED_1		: inout std_logic := '0'; --display km LED
        LED_2		: inout std_logic := '0'; --display time LED
        LED_3		: inout std_logic := '0'; --display kals LED
        LED_4		: inout std_logic := '0'; --display speed LED
        LED_5       : inout std_logic := '0' --display trip running LED
    );
end entity state_machine;


architecture Behavioral of state_machine is
    --signls for rising edge detection
    signal s_up_d  : std_logic := '0'; 
    signal s_up_re : std_logic;
    signal s_down_d  : std_logic := '0'; 
    signal s_down_re : std_logic;
    signal s_startstop_d  : std_logic := '0'; 
    signal s_startstop_re : std_logic;
    signal s_rst_d  : std_logic := '0'; 
    signal s_rst_re : std_logic;
    
    --state machine variable
    type t_State is (km_cnt, time_cnt, speed_cnt, kal_cnt, trip_ena);
    signal State : t_State := km_cnt;
begin
	
	
	--State switching process
    p_switch : process(clk)
    
    begin  
        if rising_edge(clk)then 
            --rising_edge conversion for input signals
            s_up_d <= up_i;   
            s_up_re <= not s_up_d and up_i;
            s_down_d <= down_i;   
            s_down_re <= not s_down_d and down_i;
            s_startstop_d <= startstop;   
            s_startstop_re <= not s_startstop_d and startstop;
            s_rst_d <= rst;   
            s_rst_re <= not s_rst_d and rst;
        	case State is
            
            	when km_cnt =>
                    if --rising_edge(up_i) then
                       (s_up_re = '1')then
                		State <= time_cnt; --move to next data to display
                	elsif --rising_edge(down_i) then
                	   (s_down_re = '1')then
                		State <= trip_ena; --move to previous data to display
                    end if;
                	
                    
                when time_cnt =>
                	if --rising_edge(up_i) then
                	   (s_up_re = '1')then
                		State <= kal_cnt;
                	elsif --rising_edge(down_i) then 
                	   (s_down_re = '1')then
                		State <= km_cnt;
                    end if;
                    
                when kal_cnt =>
                	if --rising_edge(up_i) then
                	(s_up_re = '1')then
                		State <= speed_cnt;
                	elsif --rising_edge(down_i) then
                	(s_down_re = '1')then
                		State <= time_cnt;
                    end if;
                
                when speed_cnt =>
                	if --rising_edge(up_i) then
                	(s_up_re = '1')then
                		State <= trip_ena;
                	elsif --rising_edge(down_i) then
                	(s_down_re = '1')then
                		State <= kal_cnt;
                    end if;
                    
                when trip_ena =>
                    if --rising_edge(up_i) then
                    (s_up_re = '1')then
                		State <= km_cnt;
                	elsif --rising_edge(down_i) then
                	(s_down_re = '1')then
                		State <= speed_cnt;
                    end if;
                when others =>
                	State <= km_cnt;
                
        	
        	end case;
        end if;
    end process p_switch;
    
    --State data output process
    p_output : process(clk)
    variable temp_trip  : std_logic := '0'; --trip status variable
    begin
    if rising_edge(clk) then
    case State is
    	when km_cnt =>
    	            --turns on status LED, routes correct data and reset
                	LED_1 	<= '1';
                    LED_2 	<= '0';
                    LED_3 	<= '0';
                    LED_4 	<= '0';
                    LED_4 	<= '0';
                    dp_o    <= '1';
                    dd_o    <= '0';
                	reset_1 <= rst;
                	data_o 	<= data_1;
                    
        when time_cnt =>
                	LED_1 	<= '0';
                    LED_2 	<= '1';
                    LED_3 	<= '0';
                    LED_4 	<= '0';
                    dp_o    <= '0';
                    dd_o    <= '1';
                	reset_2 <= rst;
                	data_o 	<= data_2;
		    if --rising_edge(startstop) then
                        (s_startstop_re = '1')then --starts/pauses timer
			toggle_o <= not toggle_o;
                    end if;
                    
        when kal_cnt =>
                	LED_1 	<= '0';
                    LED_2 	<= '0';
                    LED_3 	<= '1';
                    LED_4 	<= '0';
                    dp_o    <= '0';
                    dd_o    <= '0';
                	reset_3 <= rst;
                	data_o 	<= data_3;
        
        when speed_cnt =>
                	LED_1 	<= '0';
                    LED_2 	<= '0';
                    LED_3 	<= '0';
                    LED_4 	<= '1';
                    dp_o    <= '1';
                    dd_o    <= '0';
                    --avg speed has no reset
                	data_o 	<= data_4;
        
        when trip_ena =>
                	LED_1 	<= '0';
                    LED_2 	<= '0';
                    LED_3 	<= '0';
                    LED_4 	<= '0';
                    dp_o    <= '1';
                    dd_o    <= '0';
                	data_o 	<= (others => '0'); --blanks the display
                	
                    if --rising_edge(startstop) then
                        (s_startstop_re = '1')then --starts/pauses trip
                    	temp_trip := not temp_trip;
                    	LED_5 	<= temp_trip; --status LED
			            toggle_o <= not toggle_o; --start/pause timer
                    	enable_o <= temp_trip; --enable for blocks
                        mode_o <= '1';
                    end if;
                        
                    if --rising_edge(s_rst_re) then
                        (s_rst_re = '1')then --stops trip
                    	reset_4 <= rst; --resets all trip data on all blocks
                        temp_trip := '0';
                        LED_5 <= '0'; 
                        enable_o <= '0';
			toggle_o <= '0';
                        mode_o <= '0'; --trip is off
                        data_o <= (others => '0'); --blanks display
                    end if;
                    
    end case; 
    end if; 
    end process p_output;
end architecture Behavioral;
