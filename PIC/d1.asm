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
dv          db 0xf0

; -------------------------------------------------------------------------
;
; Entry point
;
; -------------------------------------------------------------------------
            org 0x060
            
start    
            bsf STATUS, RP0     ; banco 1
            clrf TRISIO         ; tutte linee di output
            clrf ANSEL          ; nessuna linea analogica
            bcf STATUS, RP0     ; banco 0

            clrf GPIO
            bsf GPIO, GP5
        
forEver
            bcf GPIO, GP5
            call wasteTime
            bsf GPIO, GP5
            call wasteTime
            decf dv
            goto forEver
            
           
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
 

            END            
