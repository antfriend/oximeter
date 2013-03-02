{_________________
Sp02 sensor object
  **************************************************
  *          SpO2 Oximeter Object Library          *
  *                   Version 1                    *
  *                    2/18/13                     *
  *                Author: Dan Ray                 *
  *                                                *
  *          http://youtube.com/antfriend          *
  *                                                *
  **************************************************
  *   See end of files for distribution terms      *
  **************************************************

Example:
' **************************
CON
  data_set_size = 2
VAR
  long DATA[data_set_size]
OBJ 
    spO2 : "spO2"       

Pub Start
    ' spO2.start(@DATA) 
    . the sp02 is now posting data to DATA array

' ****************************

}


CON
        _clkmode = xtal1 + pll16x 'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        cog_size = 200
        '=== sp02 settings ========
        data_set_size = 2
        
        
VAR
  long  symbol
  long DATA_start_pointer
  long Cog_Stack[cog_size]
  long DATA[data_set_size]
   
OBJ
  'nickname      : "nickname"
  
  
PUB start (DATA_pointer)
  DATA_start_pointer := DATA_pointer
  cognew(Write_DATA_to_pointer, @Cog_Stack)

PRI Write_DATA_to_pointer
  'DATA_start_pointer
  
  
  repeat
    'read the oxymiter
    

DAT
name    byte  "string_data",0        

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