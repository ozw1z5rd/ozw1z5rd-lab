; -------------------------------------------------------------------------
;
;  WORKING EXAMPLE
;
;    ADC conversion example
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

; -------------------------------------------------------------------------
;
; Entry point
;
; -------------------------------------------------------------------------
            org 0x060
            

start 
            call initCalOsc
            call initADC
            bcf STATUS, RP0         ; go bank 0 
;
; MAIN LOOP
;

lo0_cycle_again
            bsf ADCON0, GO          ; start conversion 

;
; wait the conversion completes ( no interrupt version ) 
;

lo0_conv
            btfss ADCON0, NOT_DONE  ; wait conversion
            goto nextStep
            goto  lo0_conv


nextStep
           call wait4
           call wait4
           call wait4
           call wait4
           goto lo0_cycle_again 



wait4
            return

; ------------------------------------------------------------------------
; 
;   Hardware init
;
; ------------------------------------------------------------------------


initADC
            bcf STATUS, RP0
            bsf ADCON0, VCFG        ; use Vdd as Vref for adc conversion
           
            bsf ADCON0, ADFM        ; just align the msb to left ( drop the LSB byte ) # round to 8 bit the result
            movlw b'11110011'
            andwf ADCON0
            iorwf ADCON0, 0x0c ; signal on AN3 pin
break1           
            movlw 0xc3
            movfw ADCON0

break2
            bsf STATUS, RP0          
            clrf  ANSEL
            iorwf ANSEL, b'01101000' ; [NC][Clock selection][input type digital/analog]

            bsf ADCON0, ADON        ; enable adc and returns
            return

;
; Non simulabile, perchè ? 
;
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
 

