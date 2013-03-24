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
            #include <p12f675.inc>

            #define presetValue 0x60
            #define BEAMPIN GP5


            org 0x0000
            goto main

            org 0x0020
reg1        db 0x00
preset      db presetValue
BSTATUS     db 0x00

            org 0x0004
            goto isr


;;;
;;; MAIN
;;;

main    
            call initHardware
           

l0_1    
            goto l0_1 


;;;
;;; INTERRUPT SERVICE ROUTINE
;;;

isr
            bcf INTCON, GIE         ; disable interrupt
            bcf INTCON, T0IF        ; interrupt ACK
            movfw preset            ; reload the TMR0 with preset
            movwf TMR0             
            incf BSTATUS
;
; --------------------------------------------------------------------------
;
            btfsc BSTATUS, 3         ; beam blinking
            goto beamOff
beamOn
            bsf GPIO, BEAMPIN            
            goto next
beamOff     bcf GPIO, BEAMPIN

next

;
; --------------------------------------------------------------------------
;
            bsf INTCON, GIE         ; re-enable interrupt and return 
            retfie

;;;
;;; INIT HARDWARE ( INTERRUPT, TMR0 AND GPIO )
;;;

initHardware

            bsf STATUS, RP0         ; get back the calibration value
            call 0x3ff
            movwf OSCCAL
            bcf STATUS, RP0 


            banksel INTCON
            clrf INTCON             ; disable all interrupt
            bsf INTCON, T0IE        ; enable timer 0 interrupt
            bsf INTCON, GIE         ; enable interrupt

            banksel OPTION_REG
            movlw 0xf0              ; prescaler 1:2 for tmr0
                                    ; bit 0-2 prescalre value
                                    ; bit 3 prescaler assignment

            andwf OPTION_REG,f      ; prescaler assigned to tmr0

            movlw 0x03
            iorwf OPTION_REG,f


            bcf OPTION_REG, T0CS    ; internal clock source for tmr0

            banksel TRISIO
            clrf TRISIO             ; all output 
            return 

            END
            

        
