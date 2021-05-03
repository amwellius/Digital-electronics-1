--km_total.vhd
-- counts kilometers, saves data for general
-- and for the trip device
-- made by Matej Ledvina (221339)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity total_km_cnt is
    port(
		clk			: in  std_logic; --global 100MHz clock
        rst			: in  std_logic; -- local reset
 		mode_i  	: in  std_logic; --trip mode input
 		enable_i    : in  std_logic; --trip enable input
        meters_i	: in  std_logic; --passed 100m input
        
        data_o 		: inout unsigned(15 downto 0) := (others => '0')
    );  -- output data to display coded in 4 digit BCD
end entity total_km_cnt;


architecture Behavioral of total_km_cnt is
    --rising edge conversion signals
    signal s_meters_d  : std_logic := '0';
    signal s_meters_re : std_logic;
    signal s_mode_d  : std_logic := '0';
    signal s_mode_re : std_logic;
    
    --converts integer do BCD code via the "Double Dabble" algorithm
    function int2bcd ( temp : unsigned(13 downto 0) ) return unsigned is
		variable i 		: integer:=0;
		variable bcd 	: unsigned(15 downto 0) := (others => '0');
		variable myint 	: unsigned(13 downto 0) := temp;

	begin
	for i in 0 to 13 loop
		bcd(15 downto 1) := bcd(14 downto 0); --shifts input
		bcd(0) := myint(13); --adds the latest bit
		myint(13 downto 1) := myint(12 downto 0); --shifts output bits
		myint(0) :='0'; --blanks last bit

        --conversion of individual digits via the algorithm
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
    p_cnt : process(clk)
    --internal storage of traveled distance
    variable km_total : unsigned(13 downto 0):= (others => '0');
    variable km_trip  : unsigned(13 downto 0):= (others => '0');
    begin 
        if rising_edge(clk) then
            --rising edge detection
            s_meters_d <= meters_i;  
            s_meters_re <= not s_meters_d and meters_i;
            s_mode_d <= mode_i;  
            s_mode_re <= not s_mode_d and mode_i;  
            
            --reset if reset aplied or mode turned on
            if ((rst = '1') and (mode_i = '1')) or (s_mode_re = '1') then
                km_trip := (others => '0');
            --reset if reset aplied
            elsif (rst = '1') and (mode_i = '0') then
                km_total := (others => '0');
            end if;
            
            --adds 100m to total distance
            if ((s_meters_re = '1') and (mode_i = '0')) then
            	km_total := km_total + 1;
                if (km_total >= "10011100010000") then
                	km_total := (others => '0'); --overflow protection
                end if;
                -- sends data to output after the BCD conversion
                data_o <= int2bcd(temp => km_total);
            
            --adds 100m to both totl distance and trip distance
            elsif (s_meters_re = '1') and (mode_i = '1')
                               and (enable_i = '1') then
        		km_total := km_total + 1;
                km_trip := km_trip + 1;
                data_o <= int2bcd(temp => km_trip);
            --on pause only ottal distance is counted    
            elsif ((meters_i = '1') and (mode_i = '1') 
                               and (enable_i = '0')) then
                km_total := km_total + 1;
            end if;
        end if;
    end process p_cnt;
    
end architecture Behavioral;
