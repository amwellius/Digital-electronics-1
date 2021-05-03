--button_int.vhd
--Button interface, reads inputs from buttons and
--sends signals to the main state machine.
--made by Matej Ledvina (221339)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity button_int is
    port(
        clk		: in  std_logic; --global 100MHz clock
        up_i	: in  std_logic; -- "up" button
        down_i	: in  std_logic; -- "down" button
        ok_i	: in  std_logic; -- "ok" button
        
        st_o	: out std_logic := '0'; --startstop command
        up_o	: out std_logic := '0'; -- up command
        down_o	: out std_logic := '0'; --down command
        rst_o	: out std_logic := '0' --reset command
    );
end entity button_int;


architecture Behavioral of button_int is
    --state signal for the state machine
    type t_State is (calm, wrath, send_up, send_down, send_ok, send_rst);
    signal State : t_State := calm;
    signal s_cnt : integer := 0; --cooldown counter
    --temporary storage of button presses
    signal temp_up : std_logic := '0'; 
    signal temp_down : std_logic := '0'; 
    signal temp_ok : integer := 0; 
    --signals for rising_edge conversion
    signal s_up_d  : std_logic := '0'; 
    signal s_up_re : std_logic;
    signal s_down_d  : std_logic := '0'; 
    signal s_down_re : std_logic;
    signal s_ok_d  : std_logic := '0'; 
    signal s_ok_re : std_logic;
    
begin
	--switching state
    p_switch : process(clk)
    begin  
        if rising_edge(clk) then
            --rising edge generation
            s_up_d <= up_i;   
            s_up_re <= not s_up_d and up_i;
            s_down_d <= down_i;   
            s_down_re <= not s_down_d and down_i;
            s_ok_d <= ok_i;   
            s_ok_re <= not s_ok_d and ok_i;
        	case State is
            
                --idle state  
            	when calm =>  --Slay The Spire reference ;)
            	--upon a button press the state changes
                    if (s_up_re = '1') then 
                    	temp_up <= '1';
                    	State <= wrath;
                    elsif (s_down_re = '1') then
                    	temp_down <= '1';
                    	State <= wrath;
                    elsif (s_ok_re = '1') then
                    	temp_ok <= 1;
                    	State <= wrath;
                    end if;

                --cooldown state to prevent jitter    
                when wrath =>
                	if(s_cnt < 10) then
						s_cnt <= s_cnt + 1;
                    else
                    	s_cnt <= 0;
                    	if(temp_up = '1') then
                        	State <= send_up;
                        elsif(temp_down = '1') then
                        	State <= send_down;
                        elsif(temp_ok = 1) then
                        	State <= send_ok;
                        elsif(temp_ok = 2) then
                        	State <= send_rst;
                        else State <= calm;
                        end if;
                     end if;
                	
                --setup down command   
                when send_up =>
                	if(s_cnt < 2) then
						s_cnt <= s_cnt + 1;
                    else
                    	s_cnt <= 0;
                        State <= calm;
                    end if;
                   temp_up		<= '0';
            	   temp_down	<= '0';
            	   temp_ok		<= 0;
                
                --setup down command   
                when send_down =>
                	if(s_cnt < 2) then
						s_cnt <= s_cnt + 1;
                    else
                    	s_cnt <= 0;
                        State <= calm;
                    end if;
                   temp_up		<= '0';
            	   temp_down	<= '0';
            	   temp_ok		<= 0;
                --send ok command
                when send_ok =>
                	if(s_cnt < 25) then
						s_cnt <= s_cnt + 1;
				    else

                    	s_cnt <= 0;
                        State <= calm;
                        temp_ok	<= 0;
				    end if;
                    if  (s_ok_re = '1') then
                    	temp_ok <= 2;
                        State <= wrath;
                    end if;
                   temp_up		<= '0';
            	   temp_down	<= '0';
                --send rst command  
                when send_rst =>
                	if(s_cnt < 2) then
						s_cnt <= s_cnt + 1;
                    else
                    	s_cnt <= 0;
                        State <= calm;
                    end if;
                    
                   temp_up		<= '0';
            	   temp_down	<= '0';
            	   temp_ok		<= 0;
                --safety   
                when others =>
                		State <= calm; 
        	end case;
            
            
        end if;
    end process p_switch;
    
    -- output send
    p_output : process(clk)
    begin
    case State is
        --clear outputs
    	when calm =>
            st_o 		<= '0';
            up_o 		<= '0';
            down_o 		<= '0';
            rst_o 		<= '0';
                    
        when wrath =>
        	st_o 		<= '0';
            up_o 		<= '0';
            down_o 		<= '0';
            rst_o 		<= '0';
        --send up command
        when send_up =>
        	st_o 		<= '0';
            up_o 		<= '1';
            down_o  	<= '0';
            rst_o 		<= '0';
        --send down command
        when send_down =>
        	st_o 		<= '0';
            up_o 		<= '0';
            down_o  	<= '1';
            rst_o 		<= '0';
        --send ok command    
        when send_ok =>
        	if(s_cnt > 20) and (temp_ok < 2) then
        	st_o 		<= '1';
        	end if;
            up_o 		<= '0';
            down_o  	<= '0';
            rst_o 		<= '0';
        --send reset command
        when send_rst =>
        	st_o 		<= '0';
            up_o 		<= '0';
            down_o  	<= '0';
            rst_o 		<= '1';
    end case;  
    end process p_output;
end architecture Behavioral;
