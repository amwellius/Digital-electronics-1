# 3. Console for exercise bike/bike with hall sensor, measuring and displaying speed, distance traveled and calories

### Team members

- **Martin Kousal**, **ID=** *22xxxx* <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
- **Matej Ledvina** **ID=** *22xxxx* <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
- **Tomáš Kříčka** **ID=**  *22xxxx* <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
- **Samuel Košík** **ID=** *221056* <br/>
[Link to GitHub project folder]( https://github.com/amwellius/Digital-electronics-1/tree/main/Labs/project)

### Project objectives

Our application uses two hall sensors for measuring speed, traveled distance, burnt calories and time (not by the hall sensor). <br/>
This data is shown on four 7segment displays (one part).


## Hardware description

   ### Programming Board
   ![image](images/arty_a7.PNG)
   - Main programming board is **Arty A7-100T**. It has four Pmod connectors (16.), we have used all of them.
   - 
   ### Main Board
   ![image](images/main_board.PNG)
   - **Consists of:** three buttons, 7segmet display, Pmod connectors, ...
   - 

   ### Hall sensor board
   ![image](images/hall_sensor_boars.PNG)
   - ...
   - ...

## VHDL modules description and simulations

### (last one). 7 Segment Driver Module <br/>
   This block consists of 4 smaller modules: `CLOCK`, `UP_DOWN_COUNTER`, `DRIVER_4X7SEG`, `DECODER_7SEG` <br/>
#### `CLOCK`:
   Generates 100MHz clock. This periodic signal is used in module `UP_DOWN_COUNTER`, which reacts on rising edge of the signal. <br/>
   Originally uses 4ms for each segment.
#### `UP_DOWN_COUNTER`:
   According settings (g_CNT_WIDTH), counts as the edge of the clock signal rises. <br/>
#### `DRIVER_4X7SEG`:
   Main module, drives four 7segment displays. It is determinated by `CLOCK` and `UP_DOWN_COUNTER`.<br/>
   Process MUX uses above modules to set data_outputs to each 7segment display. <br/>
   Input is a 16bit std_vector (`b"xxxx xxxx xxxx xxxx"`)
#### `DECODER_7SEG`:
   This module is used for displaying data on 7segment display. If have more displays, MUX has to be used. <br/>
   Both, common cathode and common anode can be used as well.
   
### Testbenches

#### `CLOCK`: <br/>
   ![image](images/tb_CLOCK.PNG)
   
#### `UP_DOWN_COUNTER`: <br/>
   ![image](images/tb_UP_DOWN_COUNTER_01.PNG)
   ![image](images/tb_UP_DOWN_COUNTER_02.PNG)
   
#### `DRIVER_4X7SEG`:
   - These screenshots show how the multiplexer works. 
   - `s_data` is the main 16bit data input.
   - `s_hex` is the 4bit data output, which is used in `DECODER_7SEG`. This module decodes the 4bit data value and diplays it on a specific 7segment display.
   - `s_dig_o` shows which one of four displays is being used. `b"0001"` means display on very right side. 
   - `s_seg_o` represents common cathode bits. 
   ![image](images/tb_DRIVER_4x7SEG_01.PNG)
   ![image](images/tb_DRIVER_4x7SEG_02.PNG)
   
   - This screenshot shows a real situation, when input data will be refreshed every one second (tachometer). 
   - If data is not changed for a while, displays will use last data. This prevents from bad/unwanted values. 
   ![image](images/tb_DRIVER_4x7SEG_03.PNG)
#### `DECODER_7SEG`:
   ![image](images/tb_DECODER_7SEG.PNG)


## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   ### Used:
   - Theoretical knowledge from Digital-Electronics-1 Labs, 2021> [Link]( https://github.com/tomas-fryza/Digital-electronics-1/tree/master/Labs)
   - Labs from classes from DE1
   - DE1 Lecture PDF
   -
   -
   ### Links:
   - [7 Segment Display]( https://docs.rs-online.com/6e0e/0900766b8130126b.pdf)
   - [Vivado tutorials]( https://vhdlwhiz.com/basic-vhdl-tutorials/ )
   - [Tutorial from Xilinx]( https://www.xilinx.com/support/documentation/university/Vivado-Teaching/HDL-Design/2013x/Nexys4/Verilog/docs-pdf/Vivado_tutorial.pdf)
   - [7 Segment Display]( https://docs.rs-online.com/6e0e/0900766b8130126b.pdf)
   - [Board Editor]( https://jamboard.google.com/)
   
