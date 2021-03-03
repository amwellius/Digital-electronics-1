# LAB 04-segment


### Link to GitHub repository
[GitHub repository](https://github.com/amwellius/Digital-electronics-1)


## Part 1: Preparation tasks

### Figure or table with connection of 7-segment displays on Nexys A7 board

### Decoder truth table for common anode 7-segment display

| **Hex** | **Inputs** | **A** | **B** | **C** | **D** | **E** | **F** | **G** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |
#### SCHEMA: <br/>
![ScreenShot](images/part1_1.png)    


## Part 2: Seven-segment display decoder
### Listing of VHDL architecture from source file hex_7seg.vhd with syntax highlighting
### VHDL CODE 
```vhdl
------------------------------------------------------------------------
-- Architecture body for mux_2bit_4to1 multiplexor
------------------------------------------------------------------------
architecture Behavioral of mux_2bit_4to1 is
begin
    
    f_o <=  a_i when (sel_i = "00") else 
            b_i when (sel_i = "01") else
            c_i when (sel_i = "10") else
            d_i;     


end architecture Behavioral;
```

### Listing of VHDL stimulus process from testbench file tb_hex_7seg.vhd with syntax highlighting
### VHDL CODE
```vhdl
 --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

       s_a <= "00";
       s_b <= "01";
       s_c <= "10";
       s_d <= "11";
       
       s_sel <= "00"; wait for 100ns;
       s_sel <= "01"; wait for 100ns;
       s_sel <= "10"; wait for 100ns;
       s_sel <= "11"; wait for 100ns;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

### Screenshot with simulated time waveforms; always display all inputs and outputs
![ScreenShot](images/part2_1.PNG)  

### Listing of VHDL code from source file top.vhd with 7-segment module instantiation
```vhdl

```

## Part 3: LED(7:4) indicators
### LED(7:4) indicators

### Screenshot with simulated time waveforms; always display all inputs and outputs
![ScreenShot](images/part3_2.png)




