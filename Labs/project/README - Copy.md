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