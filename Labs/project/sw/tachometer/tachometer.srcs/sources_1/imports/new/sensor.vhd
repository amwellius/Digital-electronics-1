----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2021 23:05:48
-- Design Name: 
-- Module Name: sensor - Behavioral
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

entity sensor is
--  Port ( );
    port(
        clk       : in  std_logic;  -- Clock signal
        arst      : in  std_logic;  -- Asynchronous reset
        sensor_i  : in  std_logic;  -- Hall sensor input
        trigger_o : out std_logic;  -- Trigger output
        disp_o    : out unsigned(16-1 downto 0) -- 16bit word into display
    );
end sensor;

architecture Behavioral of sensor is
    signal s_speed      : integer := 0; -- integer variable for storing speed
    signal s_speed_cnt  : integer := 0; -- integer counter used for speed calculation
    signal s_temp       : std_logic := '0'; -- logical value used in speed calculation
    signal s_cnt        : integer := 0; 
    
    signal s_sensor_i_d  : std_logic := '0'; -- signals for detecting rising edge
    signal s_sensor_i_re : std_logic;
    
    function int2bcd ( temp : integer ) return unsigned is -- function for getting data for display from integer value
    variable i 		: integer:=0;
    variable bcd 	: unsigned(15 downto 0) := (others => '0');
    variable myint 	: unsigned(13 downto 0) := TO_UNSIGNED (temp, 14);

	begin
	for i in 0 to 13 loop
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

    p_cnt : process (clk, sensor_i, arst)
    variable cnt : unsigned (6 - 1 downto 0) := (others => '0');  -- Internal 6bit counter for counting pulses from Hall sond
    begin
        if arst = '1' then  -- asynchronous reset for meter counter
            cnt := (others => '0'); 
        end if;
        
        if s_sensor_i_re = '1' then -- count every rotation of wheel, in our project 1 rot = 2 meters
            cnt := cnt + 1;
        end if;
        
--        if (rising_edge (clk) and cnt >= 50) then -- set trigger output every 100 meters
--            trigger_o <= '1';
--            cnt := (others => '0');
--        end if;
--        if (rising_edge (clk) and cnt < 50) then -- if distance <100 meters, set trigger to '0'
--            trigger_o <= '0';
--        end if;
        if rising_edge (clk) then
            if cnt >= 50 then
                trigger_o <= '1';      
                cnt := (others => '0');
            else
                trigger_o <= '0';
            end if;
        end if;                     
    end process p_cnt;
    
    p_speed : process (clk, sensor_i)
    begin
        if rising_edge (clk) then
            s_sensor_i_d <= sensor_i;   -- detecting rising edge of signal
            s_sensor_i_re <= not s_sensor_i_d and sensor_i; -- write pulse to signal that detects rising edge
            
            if sensor_i = '1' then
                s_temp <= '1';
                s_speed_cnt <= 0;
            end if;
            
            if s_temp = '1' and sensor_i = '0' then -- count period time between two sensor signals
                s_speed_cnt <= s_speed_cnt + 1;
            end if;     
            
            if s_speed_cnt > 50000000 then -- speed will not be detected if < 3.6 km/h, display 0
                s_speed_cnt <= 0;
                s_temp <= '0';
                s_speed <= 0;
                disp_o <= int2bcd(temp => integer(0));
            end if;       
        end if;
        
        if sensor_i = '1' and clk = '0' then
            if (s_speed_cnt = 0) then
                s_speed <= 0;
            else
                s_speed <= (200000000/(s_speed_cnt))*36; -- counting real speed
            end if;
        end if;
        
        if s_sensor_i_re = '1' and clk = '0' then
            disp_o <= int2bcd(temp => (s_speed)); -- write speed to display output
        end if;
        
    end process p_speed;
end Behavioral;
