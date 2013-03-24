; -------------------------------------------------------------------------
;
;  WORKING EXAMPLE
;
;    WATCHDOG 
;
;
;
;
; -------------------------------------------------------------------------

; -------------------------------------------------------------------------
; DEVICE SECTION 
; -------------------------------------------------------------------------
            processor p12f675
;           __CONFIG _CPD_OFF & _CP_OFF & _BODEN_ON & _MCLRE_OFF & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT 
            __CONFIG _CPD_OFF & _CP_OFF & _BODEN_ON & _MCLRE_OFF & _PWRTE_ON &            _INTRC_OSC_NOCLKOUT 
            #include <p12f675.inc>


            org 0x00 
            goto start

;
; INTERRUPT VECTOR
;

            org 0x04
            retfie

#define delay   0xf0

            org 0x20

v1          db 0x00
v2          db 0x00
default     db 0xf0
reboots     db 0x00         ; how many restart due to wdt has occurred

; -------------------------------------------------------------------------
;
; Entry point
;
; -------------------------------------------------------------------------
            org 0x060
            
;
; Page 58 Page 58  
;
;  --- PCON --   --- ST ---
;  /POR   /BOD   /TO    /PD 
;    0      u     1      1      Power on reset                  sempre attivo
;    1      0     1      1      BOD ( on power reset )          attivato
;    u      u     0      u      WDT Reset                       attivato
;    u      u     0      0      WDT Wake Up ( from sleep ) 
;    u      u     u      u      /MCLR normal operations         disabilitato
;    u      u     1      0      /MCLR in sleep mode
;
; u = unchanged

start 
            btfsc PCON, NOT_POR 
            goto checkBOD
            btfss STATUS, NOT_TO
            goto checkBOD
            btfss STATUS, NOT_PD
            goto checkBOD
            goto PowerOnReset
           
checkBOD    
            btfsc PCON, NOT_BOD
            goto checkWDT
            btfss STATUS, NOT_TO
            goto checkWDT
            btfss STATUS, NOT_PD
            goto checkWDT
            goto resetDueVoltage


; if we are there the /TO is 0
checkWDT

            btfsc STATUS, NOT_PD
            goto resetFromWDT            
            goto wakeUpWDT
; __________________________________________________________________

;
; JUST POWERED UP DEVICE
;
PowerOnReset
            call initCalOsc
            call initWatchDog
            goto lo0_1

;
; BOD Reset ( power supply gone )
;
resetDueVoltage
            goto lo0_1             ; continue

;
; WatchDog timer wakeup
;
wakeUpWDT
resetFromWDT
            incf reboots            ; increase reboot counter 
            goto lo0_1             ; restart the main program


; ------------------------------------------------------------------------
; 
;   Hardware init
;
; ------------------------------------------------------------------------

lo0_1       
            ;clrwdt                  ; re-enable to have this code running.
            call wait4
            goto lo0_1



wait4
            return




initWatchDog
            bcf STATUS, RP0         ; bank 0 
            clrwdt                  ; clear watchd.
            clrf TMR0               ; ? ? ? ?
            bsf STATUS, RP0         ; back ito b. 1 

            bsf OPTION_REG, PSA     ; prescalre to WDT

            movlw b'00101111'       ; prescaler to 111 and to WDT 
            movwf OPTION_REG        ; max prescaler value

            bcf STATUS, RP0

            bsf INTCON , GIE
            bsf INTCON , PEIE

            return 


initCalOsc 
            return 
; __DATA __
            bsf STATUS, RP0         ; get back the calibration value
            clrwdt
            call 0x3ff
            movwf OSCCAL
            bcf STATUS, RP0
            return 

            END 
 

