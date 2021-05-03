--time_total.vhd
-- stopwatch for trip block, 
-- made by Matej Ledvina (221339)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity total_time is
    port(
    clk		: in  std_logic; --global 100Mhz clock
    rst		: in  std_logic; -- rst command from button_int
    mode_i  	: in  std_logic; --trip mode input
    toggle_i	: in  std_logic; --trip start toggle
        
    data_o 	: inout unsigned(15 downto 0) := (others => '0')
    ); -- output data to display coded in 4 digit BCD
end entity total_time;

architecture Behavioral of total_time is
    --rising edge conversion signals
    signal s_reset_d  : std_logic := '0';
    signal s_reset_re : std_logic;
    signal s_toggle_d  : std_logic := '0';
    signal s_toggle_re : std_logic;
 
    --converts integer do BCD code via the "Double Dabble" algorithm
    function int2bcd ( temp : unsigned(5 downto 0)) return unsigned is
		variable i 		: integer:=0;
		variable bcd 	: unsigned(7 downto 0) := (others => '0');
		variable myint 	: unsigned(5 downto 0) := temp;

	begin
	for i in 0 to 5 loop
		bcd(7 downto 1) := bcd(6 downto 0);  --shifts input
		bcd(0) := myint(5); --adds the latest bit
		myint(5 downto 1) := myint(4 downto 0); --shifts output bits
		myint(0) :='0'; --blanks last bit

	--conversion of individual digits via the algorithm
		if(i < 5 and bcd(3 downto 0) > "0100") then
			bcd(3 downto 0) := bcd(3 downto 0) + "0011";
		end if;

		if(i < 5 and bcd(7 downto 4) > "0100") then 
			bcd(7 downto 4) := bcd(7 downto 4) + "0011";
		end if;
	end loop;
    return bcd;
	end int2bcd;

begin  
    p_cnt : process(clk)
    
    variable minutes : unsigned(5 downto 0):= (others => '0');
    variable seconds  : unsigned(5 downto 0):= (others => '0');
    variable milis    : unsigned(26 downto 0):= (others => '0');
    variable running : std_logic := '0';
    
    begin               
        if rising_edge(clk) then 
            --rising edge detection
            s_reset_d <= rst;  
            s_reset_re <= not s_reset_d and rst;
            s_toggle_d <= toggle_i;  
            s_toggle_re <= not s_toggle_d and toggle_i; 
 
            --reset if reset aplied or mode turned on
            if (s_toggle_re = '1') then
                running := not running;
            end if;
            
            --reset gen
            if (s_reset_re = '1') then
                milis := (others => '0');
                seconds := (others => '0');
                minutes := (others => '0');
            end if;
            --start counting
            if (running = '1') then
                milis := milis + 1;
                if (milis >= 100) then
                    milis := (others => '0');
                    seconds := seconds + 1;
                end if;
                
                if (seconds >= 60) then
                    seconds := (others => '0');                    
                    minutes := minutes + 1;
                end if;
            end if;
            --sends data out
            data_o(7 downto 0)  <= int2bcd(temp => seconds);
            data_o(15 downto 8) <= int2bcd(temp => minutes);

         end if;   
    end process p_cnt;
    
end architecture Behavioral;
