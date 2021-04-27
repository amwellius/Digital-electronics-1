# 3. Console for exercise bike/bike with hall sensor, measuring and displaying speed, distance traveled and calories

### Team members

Martin Kousal 22xxxx <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
Matej Ledvina 22xxxx <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
Tomáš Kříčka 22xxxx <br/> 
xxx[Link to GitHub project folder]( http://github.com/xxx) <br/> 
Samuel Košík 221056 <br/>
xxx[Link to GitHub project folder]( http://github.com/xxx)

### Project objectives

Write your text here.


## Hardware description

Write your text here.


## VHDL modules description and simulations

### (last one). 7 Segment Driver Module <br/>
   This block consists of 4 smaller modules: 'CLOCK', 'UP_DOWN_COUNTER', 'DRIVER_4X7SEG', 'DECODER_7SEG' <br/>
   #### 'CLOCK': <br/>
   Generates 100MHz clock. This periodic signal is used in module 'UP_DOWN_COUNTER', which reacts on rising edge of the signal. <br/>
   #### 'UP_DOWN_COUNTER': <br/>
   According settings, counts as the edge of the clock signal rises. <br/>
   #### 'DRIVER_4X7SEG': <br/>
   Main module, drives four 7segment displays. It is determinated by 'CLOCK' and 'UP_DOWN_COUNTER'.<br/>
   Process MUX uses above modules to set data_outputs to each 7segment display. <br/>
   Input is a 16bit std_vector (`b"xxxx xxxx xxxx xxxx"`)
   
      



## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   1. Write your text here.
