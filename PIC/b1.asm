; ------------------------------------------------------
; 
;    B1
;
; ------------------------------------------------------


                processor p12f675
                __config _WDT_OFF
                include <p12f675.inc>


                org 0x0000
                goto main


                org 0x0004
                goto ISRTMR1        ; ISR for timer 1

#define REG1    0x00
#define REG2    0x01
#define REG3    0x03
#define TIM0V   0x55

; timer 0 counting value
#define TIM1VL  0x00
#define TIM1VH  0x01

#define PIN_CLOCK 0
#define PIN_TX    1
#define PIN_RX    2


#define PIN_SNG   3
#define PIN_LED   4
#define PIN_SNG2  5

;
; General Purpose Registers ( 64 bytes ) 
;
                org 0x0020

v1              db 0x30
v2              db 0x31
v3              db 0x32



                org 0x0060


mainTT            movlw REG1
                movwf v1
l2_1
                movlw REG2
                movwf v2
l1_1                
                decfsz v2
                goto l1_1
                decfsz v1
                goto l2_1
  
main          call dis
;                call initTimer0
                call initTimer1         ; 'cause the timer0 is not emulated 
                call initGPIO           ; all oputput lines will be low 
                call ledOn
                call ei


                movlw 0x20
                movwf FSR
                movlw REG2
                movwf INDF
l2_0
                incf FSR,f
                movlw REG3
                movwf INDF
                
l1_0
                decfsz INDF     
                goto l1_0
                decf FSR,f
                decfsz INDF
                goto l2_0

                sleep                             

; ------------------------------------------------------
;
; Interrupt service routine
;
; ------------------------------------------------------
ISRTMR0
                bcf INTCON, T0IE        ; timer0 interrupts halted
                bcf INTCON, T0IF        ; ACK interrupt Timer0
                movlw TIM0V             ; reset counting value 
                movwf TMR0
                bsf INTCON, T0IE        ; restart timer0 interrupt
                retfie


ISRTMR1 
                bcf PIR1, TMR1IF
                retfie                


; ------------------------------------------------------
;
; Disable interrupt
;
; ------------------------------------------------------
dis 
                bcf INTCON, GIE
                return

; ------------------------------------------------------
;
; enable interrupt
;
; ------------------------------------------------------
ei
                bsf INTCON, GIE
                return 

; ------------------------------------------------------
;
; INIT TIMER 0 ( 8 bit ) 
;
; ------------------------------------------------------

initTimer0       

                bsf INTCON, T0IE        ; Timer0 overflow interrupt
                banksel OPTION_REG
                bcf OPTION_REG, PSA     ; No prescaler for timer 0
                bsf OPTION_REG, T0CS    ; internal clock  TODO : but errato

                bcf STATUS, RP0         ; bank 0 

                movlw TIM0V             ; counting value 
                movwf TMR0

                bcf STATUS, RP0
                bcf OPTION_REG, T0SE    ; Select internal clock source
                banksel GPIO
                return

; ------------------------------------------------------
;
; INIT TIMER 1 ( 16 bit ) 
;
; ------------------------------------------------------

initTimer1
                bsf INTCON, PEIE
                bsf INTCON, GIE
                bsf PIE1, 

                bcf T1CON, TMR1CS       ; internal clock for timer 1 
                bsf T1CON, NOT_T1SYNC   ; no sync with external clock
                bcf T1CON, T1CKPS1      ; prescaler at 1:1
                bcf T1CON, T1CKPS0      ; 
                bcf T1CON, TMR1GE       ; no gate control for timer 1

                movwl TIM1VH
                movwf TMR1H
                movwl TIM1VL
                movwf TMR1L

                bsf T1CON, TMR1ON       ; start the timer 
                return
                

; ------------------------------------------------------
;
; INIT GPIO LINES
;
; ------------------------------------------------------
initGPIO        
                clrf TRISIO
                clrf GPIO               ; all outputs low
                bsf TRISIO,PIN_RX       ; 0 => 0utput 1 => 1nput
                bsf GPIO,PIN_TX         ; output -> 1
                return

; ------------------------------------------------------
;
; LED CONTROL
;
; ------------------------------------------------------

ledOn           bsf GPIO, PIN_LED           
                return

ledoff          bcf GPIO, PIN_LED
                return


; ------------------------------------------------------
;
; SNG CONTROL 
;
; ------------------------------------------------------
sngOn           bsf GPIO, PIN_SNG
                return 

sngOff          bcf GPIO, PIN_SNG
                return 

                END
