{{

  File:                   SpO2 DEMO.spin
  Date:                   January 4, 2013
  Author[s]:              Daniel Harris
  Company:                Parallax Inc. ***

  Description:

                modified modified modified
                for test purposes only


=== Nellcor SpO2 Sensor ===


  !!Looking into the connector

      ┌─────── Photodiode Anode
      │ ┌───── Photodiode Cathode
      │ │   ┌─ Red LED Cathode / IR LED Anode
          
\---------------/
 \  x o o   o  /
  \  x x   o  /        
   \---------/
           
           └── Red LED Anode / IR LED Cathode



=== SpO2 Sensor example ===
 
                +5v
                                               
                 │                              
                                                    NOTE: There are actually two LEDs,
  P0   ───┐   │                                    red and infrared, in a single part
             │   ┣──── AD0 on Propeller BOE          on the sensor. Each LED is back-to-
  P1   ─────┘   │                                    back; the red anode is the IR cathode,
                   4.7 MΩ (very large resistance)    while the red cathode is the IR anode.
                 │
                 
                GND


Note:
To make the SpO2 (Pulse Oximeter) sensor work with your project,
you will have to do a little signal conditioning to be able to
use the Propeller BOE's onboard ADC to readings.  There are many
ways to use a photodiode - this way (as a voltage divider) may not
be the best way. It is up to you to find a method that works for
you!

                        
}}

CON

  'let the compiler know which crystal and PLL settings to use
  _xinfreq = 5_000_000
  _clkmode = xtal1 + pll16x

  PC_BAUD       = 115_200       'PC serial terminal's baud rate

  '=== sp02 settings ========
  data_set_size = 2
        
OBJ

  pc    :       "Parallax Serial Terminal"              'Requires 1 cog
  spO2  :       "spO2"
  
VAR
  'Globally accessible variables, shared by all cogs
  byte DATA[data_set_size]  
  
  long rawReading1
  long rawReading2

PRI Initialize
  
  dira[0-1]~~
  dira[0]~~
  dira[1]~~
  
  repeat
    outa[1] := 1
    outa[0] := 0
    waitcnt(1_000_000 + cnt)
    outa[1] := 0
    outa[0] := 1
    waitcnt(1_000_000 + cnt)
    
     
PUB Go | county, toggler, theMax, theDiff

  'Initialize   
  toggler := "*"
  'Start other objects
  pc.Start(PC_BAUD)
  
  spO2.start(@DATA) 

  pc.Clear
  theMax := 60
  
  
    
    '===== Print to the PC serial terminal =====
    pc.Clear
    pc.Home
    wait
    pc.Str(string("=== SpO2 Pulse Oximeter Test ==="))
    pc.NewLine

    rawReading1 := DATA[0]
    rawReading2 := DATA[1] 
    
    pc.Str(string("Red: "))
    pc.Dec(rawReading1)
    pc.Chars(" ", 2)
    pc.NewLine

    pc.Str(string(" IR: "))
    pc.Dec(rawReading2)
    pc.Chars(" ", 2)
    pc.NewLine

    repeat
      repeat 50    
        chart_the_data(DATA[0], DATA[1])
        wait
      pc.Clear
      pc.Home   

PRI chart_the_data(red, ir) | theDiff, theMax, theStart
    theMax := 60
    
    '---------*
    '----------------*
    '         -------* 
        
    theDiff := ir - red
    if theDiff < 0
      theDiff := 1
    if theDiff > theMax
      theDiff := 1

    'pc.Str(string(" diff: ")) 
    'pc.Dec(theDiff)
     'pc.NewLine
     
    'draw_a_line(red - 160, 0)
    'draw_a_line(ir - 160, 0)


    
    'theStart :=  ir - (theDiff / 2)- 20
    'write to an array to make a rolling average
    'for theStart
    
    '***********************************
    'noise removed
    draw_a_line(theDiff, ir - theStart)
    '***********************************
    'with noise
    'draw_a_line(theDiff, red - 160)    
    

PRI wait
  waitcnt(5_000_000 + cnt)
    
PRI draw_a_line(this_long, starting_at) | theMax
    theMax := 60
    if this_long < 1
      this_long := 1
    if this_long > theMax
      this_long := theMax

    if starting_at < 0
      starting_at := 0
    if starting_at > theMax
      starting_at := theMax
      
    repeat starting_at
      pc.Char(" " )
    pc.Char("*" )
    repeat this_long
      pc.Char("-" )
    pc.Char("*" )
    repeat 3
      pc.Char(" " ) 
    pc.NewLine

DAT

{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}