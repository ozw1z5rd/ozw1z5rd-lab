;
;

; -------------------------------------------------------------------------
; DEVICE SECTION 
; -------------------------------------------------------------------------
            processor p12f675
            __config _WDT_OFF ;  _RC_OSC
            #include <p12f675.inc>

;  de Data -> EEROM
;  db 1 byte into  RAM 
;  dw 1 word into  RAM
;

            org 0x00 
            goto start
;
; INTERRUPT VECTOR
;

            org 0x04
            goto ISR

            goto start 
;
; DATA 
;
            org 0x20
reg1        db 0x00
reg2        db 0x00
reg3        db 0x00

; -------------------------------------------------------------------------
;
; Entry point ( da verificare ) 
;
; -------------------------------------------------------------------------
            org 0x100
start       equ $

            call init           ; stop anything 
            call enableIT0      ; enable timer 0 interrupt 


; /////////////////////////////////////

            movlw 0x01
            movwf reg2
            movwf reg3
l1
            call wait4
            decfsz reg3,f
            goto l1
            decfsz reg2,f
            goto l1

; //////////////////////////////////////

            movlw 0x20
            movwf FSR
            movlw 0x55
            movlw INDF

            movlw 0x10
            movwf FSR
            movf  INDF

forever     sleep               ; wait for interrupt
            goto forever



wait4       return


; -------------------------------------------------------------------------
;
; INIT HARDWARE
;
; 1. switch off interrupt
; 2. set GPIO 
; 3. init timer
;
; -------------------------------------------------------------------------

init        bankisel INTCON
            bcf INTCON, PEIE              
            bcf STATUS, RP0
; GPIO
            clrf GPIO

; TIMER 1
            bankisel T1CON
            bcf T1CON, TMR1ON       ; stop timer
            bcf T1CON, TMR1CS       ; internal clock
            bsf T1CON, NOT_T1SYNC   ; do not sync with external clock 
            bcf T1CON, TMR1ON       ; timer able to start
            
            bsf T1CON, T1CKPS0      ; prescaler
            bsf T1CON, T1CKPS1

            return

; -------------------------------------------------------------------------
;
; T1 Switches
;
; -------------------------------------------------------------------------
startTimer1 bankisel T1CON
            bsf T1CON, TMR1ON
            return


stopTimer1  bankisel T1CON
            bcf T1CON, TMR1ON
            return


clearT1Int  bankisel PIR1
            bcf PIR1, TMR1IF
            return


; -------------------------------------------------------------------------
;
; Enable Timer 0 interrupt
;
; -------------------------------------------------------------------------
enableIT0   return

;enableIT0   bankisel INTCON
;            clrwdt                  ; clear WDT adn prescaler 
;            bsf INTCON, GIE         ; Global interrupt enabled
;            bsf INTCON, T0IE        ; Timer0 overflow interrupt
;            bcf STATUS, RP0
;            bcf OPTION_REG, T0SE    ; Select internal clock source
;            bcf OPTION_REG, PSA     ; No prescaler for timer 0
;            return 

; -------------------------------------------------------------------------
;
; FILE REGISTERS
;
; Indirizzamento indiretto
;
; -------------------------------------------------------------------------

clrFReg     movlw 0x20
            movwf FSR               ; points to 1st ram file location 
            return 
            


; -------------------------------------------------------------------------
;
; ISR 
;
; TODO : it is missing a dispatcher 
; -------------------------------------------------------------------------

ISR         incf reg1               ; interrupt counter
            bcf INTCON, T0IF        ; clear timer0 interrupt flag
            retfie                  ; return from interrupt

            END            
