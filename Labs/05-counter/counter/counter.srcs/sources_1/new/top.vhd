----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 14:09:08
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    
    Port ( 
     CLK100MHZ :    in STD_LOGIC;
     BTNC :         in STD_LOGIC;
     BTNL :         in STD_LOGIC;
     BTNR :         in STD_LOGIC;
     SW :           in STD_LOGIC_VECTOR (2 - 1 downto 0);
     LED :          out STD_LOGIC_VECTOR (16 - 1  downto 0);
     CA :           out STD_LOGIC;
     CB :           out STD_LOGIC;
     CC :           out STD_LOGIC;
     CD :           out STD_LOGIC;
     CE :           out STD_LOGIC;
     CF :           out STD_LOGIC;
     CG :           out STD_LOGIC;
     AN :           out STD_LOGIC_VECTOR (8 - 1  downto 0)
     );
     
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal counter
    signal s_cnt : std_logic_vector(4 - 1 downto 0);
    -- Internal clock enable
    signal s_en16  : std_logic;
    -- Internal counter
    signal s_cnt16 : std_logic_vector(16 - 1 downto 0);

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    CLOCK4_250ms : entity work.clock_enable
        generic map(
            g_MAX   => 250000000
        )
        port map(
             clk    =>  CLK100MHZ,
             reset  =>  BTNC,
             ce_o   =>  s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    Counter_4BIT : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH =>  4
        )
        port map(
            clk         => CLK100MHZ,  
            reset       => BTNL,
            en_i        => s_en,    
            cnt_up_i    => SW(0),
            cnt_o       => s_cnt
        );
--------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity           16BIT COunter
    CLOCK16_4ms : entity work.clock_enable
        generic map(
                g_MAX   => 400000
        )
        port map(
             clk    =>  CLK100MHZ,
             reset  =>  BTNC,
             ce_o   =>  s_en16
        );

    --------------------------------------------------------------------
      --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    Counter_16_BIT : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH =>  16
        )
        port map(
            clk         => CLK100MHZ,  
            reset       => BTNR,
            en_i        => s_en16,    
            cnt_up_i    => SW(1),
            cnt_o       => s_cnt16
        );
    -- Display input value on LEDs
    LED(16 - 1 downto 0) <= s_cnt16;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex7seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";

end architecture Behavioral;
