----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:20:55
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture Behavioral of tb_d_latch is

    signal s_en     : std_logic;
    signal s_arst   : std_logic;
    signal s_d      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;

begin
    uut_d_latch : entity work.d_latch
    port map(
        en      => s_en,
        arst    => s_arst,
        d       => s_d,
        q       => s_q,
        q_bar   => s_q_bar
        
    );
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process 
    begin
        s_arst <= '0';
        wait for 50 ns;        

        s_arst <= '1';
        wait for 10 ns;

        s_arst <= '0';
        wait for 109 ns;
        s_arst <= '1';   
        
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_en    <= '0';
        s_d     <= '0';


        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns;

        s_en <= '1'; wait for 5 ns;
        assert(s_q = '0' and s_q_bar = '1') --ak to neni nula vypise sa to co je v tom reporte
        report " s_q and q_bar expected 01" severity error;
        
        s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        
        s_en <= '0';
        s_arst <= '1'; wait for 10 ns;
        assert(s_q = '0' and s_q_bar = '1') 
        report " asrt expected 1" severity error;
        
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '1';
        wait for 10 ns; s_d <= '0';
        wait for 10 ns; s_d <= '0';
        
        s_arst <= '0'; wait for 10 ns;
        
        s_en <= '1'; wait for 10 ns;
        assert(s_q = '0' and s_q_bar = '1') 
        report " asrt expected 1" severity error;

     
     
     
     
        report "Stimulus process finished" severity note;
        
        wait;
    end process p_stimulus;

--end architecture testbench;



end Behavioral;





