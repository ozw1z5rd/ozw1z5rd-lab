; -------------------------------------------------------------------------
;
;  WORKING EXAMPLE
;
;    blink led on GP5
;
;
;
;
; -------------------------------------------------------------------------

; -------------------------------------------------------------------------
; DEVICE SECTION 
; -------------------------------------------------------------------------
            processor p12f675
            __CONFIG _CPD_OFF & _CP_OFF & _BODEN_ON & _MCLRE_OFF & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT 

;;; _CP_OFF:    turn off code protection.  Don't change this unless you
;;;             want a device that can never be programmed again.  This
;;;             is a "bug" in some PIC devices.
;;; _WDT_OFF:   turn off the watchdog timer.
;;; _BODEN_ON:  turn on power brown-out reset.
;;; _PWRTE_ON:  turn on power-up timer.
;;; _XT_OSC:    specify that the device is using an XT oscillator.
;;; _WRT_OFF:   disable write-protection of program FLASH.
;;; _LVP_OFF:   disable low-voltage in-circuit programming.
;;; _CPD_OFF:   disable data EEPROM write protection.
        
            #include <p12f675.inc>


            org 0x00 
            goto start
;
; INTERRUPT VECTOR
;
            org 0x04
            call isr 
            retfie


#define delay   0x20


; timer 1 counter value

#define tmr1vl 159
#define tmr1vh 172


            org 0x20
v1          db 0x00
v2          db 0x00
beatStatus  db 0x00


; -------------------------------------------------------------------------
;
; Entry point
;
; -------------------------------------------------------------------------
            org 0x060
            
start    
                call initHardware       ; enable interupt too
                call initGPIO           ; enable  I/O lines 
                call initTimer1         ; start timer 0

l4_0
                btfsc TMR1L,0
                bsf GPIO,GP5
                bcf GPIO,GP5
                goto l4_0
                 

; - - - - - - -  8< - - - - - -           
wasteTime
                movlw delay
                movwf v1
l2_0            
                movlw delay
                movwf v2
l1_0        
                decfsz v2
                goto l1_0

                decfsz v1
                goto l2_0

                return 
; - - - - - - -  8< - - - - - -           


 
; -------------------------------------------------------------------------
;
; ISR 
;
; -------------------------------------------------------------------------
isr
                bcf PIR1, TMR1IF        ; IE ACK 

                bsf GPIO, GP5
                call wasteTime
                bcf GPIO, GP5

                btfsc beatStatus,0  
                goto set_off
set_on
                bsf beatStatus,0
                bsf GPIO, GP5
                goto reinitTMR1
set_off         
                bcf beatStatus,0
                bcf GPIO, GP5
                                
reinitTMR1
                movlw tmr1vh            ; restart counting 
                movwf TMR1H
                movlw tmr1vl
                movwf TMR1L
                retfie                
 
; -------------------------------------------------------------------------
;
; INIT HARDWARE
;
; -------------------------------------------------------------------------


initHardware 
                bsf STATUS, RP0         ; select bank 1
                clrf TRISIO             ; all output lines
                clrf ANSEL              ; no analog lines
                bcf STATUS, RP0         ; switch back to bank 0
                clrf INTCON             ; stops any interrupt
                bcf PIR1, TMR1IF        ; IE ACK  if any, any ? 

                movlw 0x07              ; switch off comparator
                iorwf CMCON,f

                bsf  INTCON, PEIE       ; enable ADC / TIMER ... COMPARATOR
                bsf  INTCON, GIE        ; Enable interrupts ( Global )
                return 

initGPIO
                clrf GPIO
                return 


; ------------------------------------------------------
;
; INIT TIMER 1 ( 16 bit ) 
;
;  TMR1 Preset = 40876 - Freq = 5.07 Hz - Period = 0.197280 seconds
;
; ------------------------------------------------------

initTimer1
                bsf STATUS, RP0         ; go to bank 1
                bsf PIE1,TMR1IE         ; Peripheral interrupt register

                bcf STATUS, RP0         ; back to bank 0

                bcf T1CON, TMR1CS       ; internal clock for timer 1 
                bsf T1CON, NOT_T1SYNC   ; no sync with external clock

                bsf T1CON, T1CKPS1      ; prescaler at 1:8
                bsf T1CON, T1CKPS0      ; 

                bsf T1CON, T1OSCEN      ; enable LP oscrilaltor ? 

                bcf T1CON, TMR1GE       ; no gate control for timer 1

                                        ; preset value
                movlw tmr1vh
                movwf TMR1H
                movlw tmr1vl
                movwf TMR1L

                bsf T1CON, TMR1ON       ; start the timer 
                return



            END            
