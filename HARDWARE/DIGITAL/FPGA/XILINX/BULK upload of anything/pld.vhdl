R_GAL (register set and memory controller)
poweron - power-on reset
eprom	- 8k (e)eprom present and flashing disabled
bank0	- 32k sram bank for <2000,3fff>, bit 0 
bank1	- 32k sram bank for <2000,3fff>, bit 1
mapram	- start 8k (e)eprom emulation and lock sram bank 3
conmem	- unlock and force 8k (e)eprom and selected 32k sram bank to <0000,3fff>
addr0	- bit A13 for 32k sram
addr1	- bit A14 for 32k sram
romoff	- detach original rom
romoe	- 8k (e)eprom output enable
ramoe	- 32k sram output enable
ramwr	- 32k sram write

M_GAL (harddrive controller and additional logic)
loe	- latch output enable
doe	- driver output enable
hdwr	- harddrive write
hdrd	- harddrive read
lclk	- latch clock
mgalclk	- clocks for m_gal
rgalclk	- clocks for r_gal
romacc	- address is 00xxxxxxxxxxxxxx
evenodd	- byte order flag
romwr	- 8k (e)eprom write

CHIP m_gal gal22v10

CLK NC A15 A14 ideio0 ideio1 /WR /RD conmem A13 /eprom GND
/IORQ /romwr evenodd lclk romacc rgalclk /doe /hdrd /hdwr /loe mgalclk VCC

EQUATIONS

mgalclk	= /IORQ*mgalclk
	+ /RD*/WR*mgalclk
	+ /ideio0*/ideio1*mgalclk
	+ ideio1*evenodd*/RD*/hdwr*mgalclk
	+ ideio1*/ideio0*/RD*/hdwr*mgalclk
	+ ideio1*ideio0*/RD*/loe*mgalclk
	+ ideio1*/WR*/doe*mgalclk
	+ /IORQ*/RD*/WR*/loe*/doe*/hdrd

rgalclk	= /IORQ*rgalclk
	+ /WR*rgalclk
	+ /ideio0*rgalclk
	+ ideio1*rgalclk
	+ mgalclk*rgalclk
	+ /IORQ*/WR

romacc	= /A14*/A15

/romwr	= /WR
	+ A13
	+ A14
	+ A15
	+ eprom
	+ /conmem

/loe	= /IORQ*/loe
	+ /RD*/WR*/loe
	+ /ideio1*/loe
	+ /ideio0*/loe
	+ /WR*/evenodd*/loe
	+ /IORQ*/RD*/WR*/lclk*/hdwr*/doe

/doe	= /IORQ*/doe
	+ /RD*/WR*/doe
	+ /ideio1*/doe
	+ /RD*ideio0*/doe
	+ /WR*/loe*/hdrd*/doe
	+ /IORQ*/RD*/WR*/hdwr

lclk	= IORQ*RD*ideio1*ideio0*/evenodd*/mgalclk
	+ IORQ*WR*ideio1*ideio0*/evenodd*/mgalclk
	+ IORQ*lclk
	+ RD*lclk
	+ WR*lclk

/hdwr	= /IORQ*/hdwr
	+ /WR*/hdwr
	+ /ideio1*/hdwr
	+ ideio0*/evenodd*/hdwr
	+ /loe*/doe*/hdwr
	+ /IORQ*/WR

/hdrd	= /IORQ*/hdrd
	+ /RD*/hdrd
	+ /ideio1*/hdrd
	+ ideio0*evenodd*/hdrd
	+ /IORQ*/RD*/lclk*/doe

evenodd	:= /evenodd*ideio0*ideio1

evenodd.c	= CLK

_____________________________________________________________________________________________
architettural behaviour of chip is 

begin

    process (CLK, /WR, romacc, D0, D1, /RD, automap, /poweron, D7, D6, A13, GND /eprom, romoff, /romoe, conmem, bank0, bank1, /ramoe, addr1, addr0, /ramwr, mapram, VCC) 
    begin

        if clock = '1' and clock'event then 

            romoff	<= automap and eprom
                 or  automap and mapram
                 or  conmem

            addr0	<= bank0
                 or  /A13

            addr1	<= bank1
                 or  /A13

            /romoe	<= /RD
                 or  /romacc
                 or  A13
                 or  /conmem and mapram
                 or  /conmem and not automa
                 or  /conmem and not eprom

            /ramoe	<= /RD
                 or  /romacc
                 or  /A13 and not mapram
                 or  /A13 and conmem
                 or  /conmem and not automap
                 or  /conmem and not eprom and not mapram

            /ramwr	<= /WR
                 or  /romacc
                 or  /A13
                 or  /conmem and mapram and bank0 and bank1
                 or  /conmem and not automap
                 or  /conmem and not eprom and not mapram

            bank0	<= D0

            bank1	<= D1

            mapram	<= D6
                 or  mapram

            conmem	<= D7

            mgalclk	<= /IORQ and mgalclk
                 or  /RD and not WR and mgalclk
                 or  /ideio0 and not ideio1 and mgalclk
                 or  ideio1 and evenodd and not RD and not hdwr and mgalclk
                 or  ideio1 and not ideio0 and not RD and not hdwr and mgalclk
                 or  ideio1 and ideio0 and not RD and not loe and mgalclk
                 or  ideio1 and not WR and not doe and mgalclk
                 or  /IORQ and not RD and not WR and not loe and not doe and not hdrd

            rgalclk	<= /IORQ and rgalclk
                 or  /WR and rgalclk
                 or  /ideio0 and rgalclk
                 or  ideio1 and rgalclk
                 or  mgalclk and rgalclk
                 or  /IORQ and not WR

            romacc	<= /A14 and not A15

            /romwr	<= /WR
                 or  A13
                 or  A14
                 or  A15
                 or  eprom
                 or  /conmem

            /loe	<= /IORQ and not loe
                 or  /RD and not WR and not loe
                 or  /ideio1 and not loe
                 or  /ideio0 and not loe
                 or  /WR and not evenodd and not loe
                 or  /IORQ and not RD and not WR and not lclk and not hdwr and not doe

            /doe	<= /IORQ and not doe
                 or  /RD and not WR and not doe
                 or  /ideio1 and not doe
                 or  /RD and ideio0 and not doe
                 or  /WR and not loe and not hdrd and not doe
                 or  /IORQ and not RD and not WR and not hdwr

            lclk	<= IORQ and RD and ideio1 and ideio0 and not evenodd and not mgalclk
                 or  IORQ and WR and ideio1 and ideio0 and not evenodd and not mgalclk
                 or  IORQ and lclk
                 or  RD and lclk
                 or  WR and lclk

            /hdwr	<= /IORQ and not hdwr
                 or  /WR and not hdwr
                 or  /ideio1 and not hdwr
                 or  ideio0 and not evenodd and not hdwr
                 or  /loe and not doe and not hdwr
                 or  /IORQ and not WR

            /hdrd	<= /IORQ and not hdrd
                 or  /RD and not hdrd
                 or  /ideio1 and not hdrd
                 or  ideio0 and evenodd and not hdrd
                 or  /IORQ and not RD and not lclk and not doe

            evenodd	 <= /evenodd and ideio0 and ideio1

            evenodd.c	= CLK
























        end fi
    endprocess 

end behavior


