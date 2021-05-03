-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 



entity calories is
    port(
    	clk				: in std_logic;                     -- clock signal
        arst			: in std_logic;                     -- arst signal
      	sensorpads_i	: in std_logic;                     -- signal from pedal
       	calsdisp_o		: out unsigned(16 - 1 downto 0);    -- 16bit word to display
       	mode_i          : in std_logic;                     -- signal from buttons
       	enable_i        : in std_logic                      -- signal from buttons
    );
end entity calories;

architecture Behavioral of calories is

    signal s_klik_total     : integer := 0 ;            -- clock counting for total
    signal s_klik_trip      : integer := 0 ;            -- clock counting for trip
    signal s_counter_total	: integer := 0;             -- time counting fot total
    signal s_counter_trip	: integer := 0;             -- time counting for trip
    signal s_temp_total		: std_logic := '0';
    signal s_temp_trip		: std_logic := '0';
    
    signal s_tempp_total    : integer := 0;             -- counting repetiotin of s_temp_total
    signal s_tempp_trip     : integer := 0;             -- counting repetiotin of s_temp_trip
    
    function int2bcd ( temp : integer  ) return unsigned is
        variable i          : integer:=0;
        variable bcd        : unsigned(15 downto 0) := (others => '0');
        variable myint      : unsigned (13 downto 0) := TO_UNSIGNED(temp, 14);

    begin
    for i in 0 to 13 loop  -- transfer number from decimal to binary
        bcd(15 downto 1) := bcd(14 downto 0); 
        bcd(0) := myint(13);
        myint(13 downto 1) := myint(12 downto 0);
        myint(0) :='0';


        if(i < 13 and bcd(3 downto 0) > "0100") then
            bcd(3 downto 0) := bcd(3 downto 0) + "0011";
        end if;

        if(i < 13 and bcd(7 downto 4) > "0100") then 
            bcd(7 downto 4) := bcd(7 downto 4) + "0011";
        end if;

        if(i < 13 and bcd(11 downto 8) > "0100") then 
            bcd(11 downto 8) := bcd(11 downto 8) + "0011";
        end if;

        if(i < 13 and bcd(15 downto 12) > "0100") then 
            bcd(15 downto 12) := bcd(15 downto 12) + "0011";
        end if;
    end loop;
    return bcd;
    end int2bcd;

begin

	p_count : process(clk, arst, sensorpads_i, mode_i, enable_i)
	
	
	   begin
	   
	       if arst = '1' then              -- arst
               s_klik_total <= 0;
               s_klik_trip <= 0;
  
	       end if;
       
           if arst = '1' and mode_i = '0' then
                s_counter_total <= 0;
                
           elsif arst = '1' and mode_i = '1' then
                s_counter_trip <= 0;
                
           elsif mode_i = '1' then
                s_counter_trip <= 0;
                
           end if;
       
           if rising_edge(clk) then
	           
	           if sensorpads_i = '0' then              -- clock counting for next operations
	               s_klik_total <= s_klik_total + 1;
	               s_klik_trip <= s_klik_trip + 1;

	           end if;
	           
	           if sensorpads_i = '1' then              -- resetting values, which stopping counting, when is no signalon pedals
	               s_tempp_total <= 0;
	               s_tempp_trip <= 0;
	           end if;
	           
	           if sensorpads_i = '0' and mode_i = '0' then         -- counting lenght when is trip off
                   if s_klik_total = 50000000 then                 -- 0.5 s
                       s_klik_total <= 0;
                       s_temp_total <= '1';
                   
                       if s_temp_total = '1' and s_tempp_total < 4 then  -- stop couting if pedals are not used 2s
                            s_temp_total <= '0';
                            s_counter_total <= s_counter_total + 1;
                            s_tempp_total <= s_tempp_total + 1;
                                   
                       else
                            s_counter_total <= s_counter_total + 0;
                            
                            
                       end if;
                   end if;
               end if;   
                   
                   
               if sensorpads_i = '0' and mode_i = '1' and enable_i = '1' then   --- counting lenght when are trip and total on
               
                   if s_klik_total = 50000000 then
                       s_klik_total <= 0;
                       s_temp_total <= '1';
                   
                       if s_temp_total = '1' and s_tempp_total < 4 then
                            s_temp_total <= '0';
                            s_counter_total <= s_counter_total + 1;
                            s_tempp_total <= s_tempp_total + 1;
                            
                       else
                            s_counter_total <= s_counter_total + 0;
                            
                            
                       end if;
                   end if;
               
               
                   if s_klik_trip = 50000000 then   
                       s_klik_trip <= 0;
                       s_temp_trip <= '1';
                       
                       if s_temp_trip = '1' and s_tempp_trip < 4 then
                            s_temp_trip <= '0';
                            s_counter_trip <= s_counter_trip + 1;
                            s_tempp_trip <= s_tempp_trip + 1;
                            
                       else
                            s_counter_trip <= s_counter_trip + 0;
                            
                       end if;
        
                   end if;
                end if;
	           
	           if sensorpads_i = '0' and mode_i = '1' and enable_i = '0' then   ----- counting lenght when is trip off
	       
                   if s_klik_total = 50000000 then   
                       s_klik_total <= 0;
                       s_temp_total <= '1';
                   
                       if s_temp_total = '1' and s_tempp_total < 4 then
                            s_temp_total <= '0';
                            s_counter_total <= s_counter_total + 1;
                            s_tempp_total <= s_tempp_total + 1;
                            
                       else
                            s_counter_total <= s_counter_total + 0;

                       end if;  
                    end if;
	            end if;
	           
 	       if mode_i = '0' then
	           calsdisp_o <= int2bcd(temp => (((s_counter_total)/60) * 1344)); -- diaplay number  on display
	               -- formula   calsdisp_o = (s_counter*120*((8*3.5*80kg)/20)) burned calories in [J]
	       
	       elsif mode_i = '1' and enable_i = '1' then
	           calsdisp_o <= int2bcd(temp => (((s_counter_trip)/60) * 1344));
	           
	       elsif mode_i = '1' and enable_i = '0' then
	           calsdisp_o <= int2bcd(temp => (((s_counter_trip)/60) * 1344));  
	       
	       end if;
	       
	   end if;
        	   
	   
    end process p_count;

end architecture behavioral;
	      