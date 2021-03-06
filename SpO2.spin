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
   
  cog_size = 2000
  '=== sp02 settings ========
  data_set_size = 2

'=== A/D settings ========
  ADC_CH0       = 1 << 0
  ADC_CH1       = 1 << 1
  ADC_CH2       = 1 << 2
  ADC_CH3       = 1 << 3
  ADC_ALL       = ADC_CH0 + ADC_CH1 + ADC_CH2 + ADC_CH3
'=== LED settings ========
  IR_LED_PIN    = 1
  RED_LED_PIN   = 0

'== other settings =======
  wait_time = 1_000     
        
VAR
  long  symbol
  long DATA_start_pointer
  long Cog_Stack[cog_size]
  long DATA[data_set_size]
  byte red_reading
  byte ir_reading
   
OBJ
  'nickname      : "nickname"
   adc   :       "PropBOE ADC"                           'Requires 1 cog 
  
PUB start (DATA_pointer)
  DATA_start_pointer := DATA_pointer

  'Initialize
  
  cognew(Write_DATA_to_pointer, @Cog_Stack)

PRI Initialize
  dira[RED_LED_PIN]~~
  dira[IR_LED_PIN]~~
  {
  repeat
    TurnOnRed
    'TurnOffLEDs
    wait
    TurnOnIR
    'TurnOffLEDs
    wait 
   }
   
PRI wait
  waitcnt(wait_time + cnt)
            
PRI Write_DATA_to_pointer | sampleMultiple, rawReading1, rawReading2

  Initialize
  'DATA_start_pointer
  'sampleMultiple := 1 

  adc.Start(ADC_CH0)
   
  repeat
    'waitcnt(10_000 + cnt)
    '============ Red sampleMultiple 
    TurnOnRed
    wait
    'read the oxymiter
    rawReading1 := adc.In(0)
    'rawReading1 := rawReading1 + 1
    'if rawReading1 > 1000
     ' rawReading1 := 0
    'repeat sampleMultiple
     ' rawReading1 += adc.In(0)
    
    'rawReading1 /= sampleMultiple    

   '============ Infrared sampleMultiple    
    TurnOnIR
    wait
    rawReading2 := adc.In(0)
    
    {repeat sampleMultiple
      rawReading2 += adc.In(0)

    rawReading2 /= sampleMultiple
    }
    write_red(rawReading1)
    write_ir(rawReading2)
    
PRI write_red(the_value)
  byte[DATA_start_pointer][0] := the_value

PRI write_ir(the_value)
  byte[DATA_start_pointer][1] := the_value

pub TurnOnRed

  outa[RED_LED_PIN] := 1
  outa[IR_LED_PIN] := 0

pub TurnOnIR

  outa[RED_LED_PIN] := 0
  outa[IR_LED_PIN] := 1

pub TurnOffLEDs

  outa[RED_LED_PIN] := 0
  outa[IR_LED_PIN] := 0
  
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