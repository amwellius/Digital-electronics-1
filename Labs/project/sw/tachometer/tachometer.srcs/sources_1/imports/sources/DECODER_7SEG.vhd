----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 13:21:08
-- Design Name: 
-- Module Name: DECODER_7SEG - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module is used for displaying data on 7segment display. If have more displays, MUX has to be used. 
-- By uncomment/comment in proces DECODER can be used Commond Cathode/Anode.
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
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECODER_7SEG is
    Port ( 
           hex_i : in unsigned (4 - 1 downto 0);
           seg_o : out STD_LOGIC_VECTOR (7 - 1 downto 0));
end DECODER_7SEG;

------------------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------------------
architecture behavioral of DECODER_7SEG is
begin

    --------------------------------------------------------------------
    -- p_DECODER:
    -- A combinational process for 7-segment display decoder. 
    -- Any time "hex_i" is changed, the process is "executed".
    --------------------------------------------------------------------
    p_DECODER : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "1111110";            -- 0
              --seg_o <= "0000001";            --/0
            when "0001" =>
                seg_o <= "0110000";            -- 1
              --seg_o <= "1001111";            --/1
            when "0010" =>
                seg_o <= "1101101";            -- 2
              --seg_o <= "0010010";            --/2
            when "0011" =>
                seg_o <= "1111001";            -- 3
              --seg_o <= "0000110";            --/3
            when "0100" =>
                seg_o <= "0110011";            -- 4
              --seg_o <= "1001100";            --/4
            when "0101" =>
                seg_o <= "1011011";            -- 5
              --seg_o <= "0100100";            --/5
            when "0110" =>
                seg_o <= "1011111";            -- 6
              --seg_o <= "0100000";            --/6
            when "0111" =>
                seg_o <= "1110000";            -- 7
              --seg_o <= "0001111";            --/7            
            when "1000" =>
                seg_o <= "1111111";            -- 8
              --seg_o <= "0000000";            --/8                
            when "1001" =>
                seg_o <= "1111011";            -- 9
              --seg_o <= "0000100";            --/9
            when "1010" =>
                seg_o <= "1110111";            -- A
              --seg_o <= "0001000";            --/A
            when "1011" =>
                seg_o <= "0011111";            -- B
              --seg_o <= "1100000";            --/B
            when "1100" =>
                seg_o <= "1001110";            -- C
              --seg_o <= "0110001";            --/C
            when "1101" =>
                seg_o <= "0111101";            -- D
              --seg_o <= "1000010";            --/D       
            when "1110" =>
                seg_o <= "1001111";            -- E
              --seg_o <= "0110000";            --/E  
            when others =>
                seg_o <= "1000111";            -- F
              --seg_o <= "0111000";            --/F
        end case;
    end process p_DECODER;

end architecture behavioral;
