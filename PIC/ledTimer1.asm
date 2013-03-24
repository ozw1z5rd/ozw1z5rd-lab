;12F675 Flashing LED using Timer1

    list    p=12F675
    #include "p12f675.inc"

    __CONFIG  _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _INTRC_OSC_NOCLKOUT & _MCLRE_OFF & _CPD_OFF

TEMP    equ 0x20

    org 0x00
    nop
    goto    init

    org 0x04
    return

init
    banksel 0x80
    clrf    ANSEL   ;make all I/O ports digital
    movlw   0f
    movwf   TRISIO  ;make GP4 and GP5 outputs
    banksel 0x00
    movlw   0x31
    movwf   T1CON   ;start Timer1 running with 8:1 prescale
    clrf    GPIO    ;turn off leds

flash
    clrf    TEMP
    rlf TMR1H,w ;rotate TMR1H bit 7 into carry flag
    rlf TEMP,f  ;rotate carry flag to TEMP bit 0
    swapf   TEMP,f  ;swap TEMP bit 0 to bit 4
    movf    TEMP,w
    movwf   GPIO    ;copy TEMP to GPIO
    goto    flash

    end
