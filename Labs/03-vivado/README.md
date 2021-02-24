# LAB 03-vivado


### Link to GitHub repository
[GitHub repository](https://github.com/amwellius/Digital-electronics-1)


## Part 1: Preparation tasks
### Figure or table with connection of 16 slide switches and 16 LEDs on Nexys A7 board
   From switches 0-15 (SW0-SW0) we are using switches SW0-SW7 and SW14 and SW15 <br/>
   From LEDs 0-15 (LD0-LD15) we are using LEDs LD0 and LD1 <br/>
   Used Schema link: <br/>
   (https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) <br/>
#### SCHEMA: <br/>
![ScreenShot](images/part1_1.png)    


## Part 2: Two-bit wide 4-to-1 multiplexer
### Listing of VHDL architecture from source file mux_2bit_4to1.vhd with syntax highlighting
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

### Listing of VHDL stimulus process from testbench file tb_mux_2bit_4to1.vhd with syntax highlighting
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

### Screenshot with simulated time waveforms
![ScreenShot](images/part2_1.png)  

### Used nexys-a7-50t inputs
```vhdl
##Switches
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { a_i[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { a_i[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { b_i[0] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { b_i[1] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { c_i[0] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { c_i[1] }]; #IO_L7N_T1_D10_14 Sch=sw[5]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { d_i[0] }]; #IO_L17N_T2_A13_D29_14 Sch=sw[6]
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { d_i[1] }]; #IO_L5N_T0_D07_14 Sch=sw[7]

set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { sel_i[0] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=sw[14]
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { sel_i[1] }]; #IO_L21P_T3_DQS_14 Sch=sw[15]

## LEDs
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { f_o[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { f_o[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1]
```


## Part 3: A 4-bit binary comparator
### VHDL CODE design.vhd

### Console LOG
```bash
[2021-02-17 12:23:54 EST] ghdl -i design.vhd testbench.vhd  && ghdl -m  tb_comparator_4bit && ghdl -r  tb_comparator_4bit   --vcd=dump.vcd && sed -i 's/^U/X/g; s/^-/X/g; s/^H/1/g; s/^L/0/g' dump.vcd 
analyze design.vhd
analyze testbench.vhd
elaborate tb_comparator_4bit
testbench.vhd:51:9:@0ms:(report note): Stimulus process started
testbench.vhd:71:9:@300ns:(assertion error): Test failed for input combination: 0011, 1101
testbench.vhd:173:9:@1600ns:(report note): Stimulus process finished
Finding VCD file...
./dump.vcd
[2021-02-17 12:23:54 EST] Opening EPWave...
Done
```


##### Link to EDA PlayGround
[EDA PlayGroud](https://www.edaplayground.com/x/ptjA)

