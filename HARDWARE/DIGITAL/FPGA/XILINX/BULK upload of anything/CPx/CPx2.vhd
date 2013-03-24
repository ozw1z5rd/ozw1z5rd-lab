----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:10 01/20/2012 
-- Design Name:    MEMORY CONTROLLER FOR BUS EXPANSION
-- Module Name:    CPx2 - Behavioral 
-- Project Name:   DIVIDE NG
-- Target Devices: 
-- Tool versions: 
-- Description:  2ND CPLD IMPLEMENTATION
--
-- Dependencies: NONE
--
-- Revision: 0
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


---
--- Avanza 1 pin.
---


entity CPx2 is
    Port ( 
-- ----------------------------------------------------------------------------------
--  ######## A/D BUSSES #########
-- ----------------------------------------------------------------------------------
           A : in  STD_LOGIC_VECTOR (13 downto 0) ;   
           D : inout  STD_LOGIC_VECTOR (7 downto 0) := "ZZZZZZZZ"; 
--- ADDRESSING LINE FOR SRAM ( THESE LINE FILL UP THE MISSING PART OF THE SRAM ADDRESS BUS
---      SRAM A(0 -13) IS ATTACHED TO THE ADDRESS BUS
---      SRAM A(14-18) are connected to BANK(0-4) bus 
           BANK      : OUT STD_LOGIC_VECTOR (4 downto 0 ) := "00000" ; -- 32 x 16 
--
-- ----------------------------------------------------------------------------------
--  ######## JUMPERS #########
-- ----------------------------------------------------------------------------------
--
-- FUSE / UNFUSE EEPROM 
           JUMPER_EEPROM : in STD_LOGIC;     -- SET TO HIGH TO PREVENT EEPROM WRITING
--
-- ----------------------------------------------------------------------------------
--  ######## CONTROL BUS #########
-- ----------------------------------------------------------------------------------
--
           CLOCK : in  STD_LOGIC;

-- RAM / IO LINES
           N_MREQ : IN  STD_LOGIC;          -- FROM Z80 - GOES LOW WHEN THE ADDRESS IS STABLE ON THE BUS 
           N_RD   : in  STD_LOGIC;          -- FROM Z80 - GOES LOW WHEN THE CPU IS READING THE DATA ( DEVICE PUT DATA ON BUS ) 
           N_WR   : in  STD_LOGIC;          -- FROM Z80 - GOES LOW WHEN THE CPU IS WRITING THE DATA ( DEVICE GET THE DATA FROM THE BUS )
           N_M1   : in  STD_LOGIC;          -- FROM Z80 - GOES LOW WHEN THE Z80 IS FETCHING A NEW OPCODE

-- ADDRESSING LINE FOR ROM ARE A0-A13
           N_ROMCS   : BUFFER STD_LOGIC := '1'; -- SET TO LOW TO DISABLE THE SPECCY ROM

---- SRAM CONTROL BUS
           N_SRAMCS  : BUFFER STD_LOGIC :='1';
           N_SRAMOE  : OUT    STD_LOGIC :='1';
           N_SRAMWR  : OUT    STD_LOGIC :='1';

----    EEPROM CONTROL BUS
           N_EEPROMWR : OUT STD_LOGIC :='0';
           N_EEPROMOE : OUT STD_LOGIC :='0';
           N_EEPROMCS : OUT STD_LOGIC :='0'

    );
end CPx2;


-- -----------------------------------------------------------------------------------
-- ###################################################################################
-- -----------------------------------------------------------------------------------
architecture Behavioral of CPx2 is


--
-- DETECT WHEN ACCESSING THE ENTRY POINT FOR ROM SWITCHING 
--
   SIGNAL S_EN0000    :STD_LOGIC  :='0'; -- 1 => ACCESSING THE ENTRY POINT DEFINED.
   SIGNAL S_EN0008    :STD_LOGIC  :='0';
   SIGNAL S_EN0038    :STD_LOGIC  :='0';
   SIGNAL S_EN0066    :STD_LOGIC  :='0';
   SIGNAL S_EN04C6    :STD_LOGIC  :='0';
   SIGNAL S_EN0562    :STD_LOGIC  :='0';
   SIGNAL S_EN1FF8    :STD_LOGIC  :='0';
   SIGNAL S_EN1FFF    :STD_LOGIC  :='0';

-- WHEN Z80 IS ACCESSING ANY REGISTER OF THIS INTERFACE
   SIGNAL S_INTERFACECS :STD_LOGIC  :='0';
-- DETECT WHEN Z80 IS ACCESSING THIS INTERFACE'S REGISTERS
   SIGNAL S_CFG_REG_EN :STD_LOGIC  :='0'; -- GOES HIGH WHEN THE CPU IS ACCESSING THE CONFIG REGISTER
   SIGNAL S_VER_REG_EN :STD_LOGIC  :='0'; -- GOES HIGH WHEN THE CPU IS ACCESSING THE VERSION REGISTER

-- MULTI SIGNAL TO SKIP THE MULTISOURCE PROBLEM
   SIGNAL S_AUTO_CONMEM_ON      : STD_LOGIC := '0'; -- Z80 IS ACCESSING AN ENTRY POINT FOR ON
   SIGNAL S_AUTO_CONMEM_OFF     : STD_LOGIC := '0'; -- Z80 IS ACCESSING AN ENTRY POINT FOR OFF
   SIGNAL S_SWITCH_CONMEM_ONOFF : STD_LOGIC := '0'; -- SOFTWARE SWITCH, THIS LINE IS ATTACHED TO d(7)

-- Z80 IS ACCESSING THE PAGE0 ( 8K ) ( THE LOWER ROM ADDRESSING SPACE )
   SIGNAL S_ACCESSING_PAGE0 : STD_LOGIC := '0';
--  PAGE1 ( 8K ) UPPER ROM ADDRESSING SPACE
   SIGNAL S_ACCESSING_PAGE1 : STD_LOGIC := '0';

-- EXTERNAL EEPROM CAN BE ACCESSED
   SIGNAL S_EEPROMCS : STD_LOGIC := '0';
-- EXTERNAL SRAM CAN BE ACCESSED
   SIGNAL S_SRAMCS   : STD_LOGIC := '0';

-- THE SRAM IS WORKING AS EEPROM ON PAGE0
   SIGNAL S_MAPRAM : STD_LOGIC := '0';
-- STANDARD INTERFACE LAYOUT : THE EEPROM WORKS ON PAGE1 AND SRAM ON PAGE1
   SIGNAL S_CONMEM : STD_LOGIC := '0';

-- SPARE SIGNAL FOR SINTESYS PROBLEM.
   SIGNAL A1 : STD_LOGIC:= '0';

-- ##############################################################################   
-- ##############################################################################   
BEGIN 

--
-- SWITCHES FOR ENTRY POINTS ( CONMEM ON )
--
    S_EN0000 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND NOT A(3) AND NOT A(4) AND NOT A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);
    S_EN0008 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND     A(3) AND NOT A(4) AND NOT A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);
    S_EN0038 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND     A(3) AND     A(4) AND     A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);
    S_EN0066 <= NOT A(0) AND     A(1) AND     A(2) AND NOT A(3) AND NOT A(4) AND     A(5) AND     A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);
    S_EN04C6 <= NOT A(0) AND     A(1) AND     A(2) AND NOT A(3) AND NOT A(4) AND NOT A(5) AND     A(6) AND     A(7) AND NOT A(8) AND NOT A(9) AND     A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);
    S_EN0562 <= NOT A(0) AND     A(1) AND NOT A(2) AND NOT A(3) AND NOT A(4) AND     A(5) AND     A(6) AND NOT A(7) AND     A(8) AND NOT A(9) AND     A(10) AND NOT A(11) AND NOT A(12) AND NOT A(13);       
--
-- ACTIVATE THE CONMEM ( 2 CLOCK LATER... )
--
-- N_M1    : IS ON WHEN THE CPU IS FETCHING THE NEW OP CODE.
-- N_ROMCS : IS ON WHEN THE EEPROM IS ACTIVE AND THE SPECTRYUM'S ROM IS OFF LINE.
-- CONMEM STARTS IF NOT YET STARTED :-) AND THE CPU IS FETCHING FROM THE ABOVE ENTRY POINTS
--
   S_AUTO_CONMEM_ON <= ( S_EN0000 OR S_EN0008 OR S_EN0038 OR S_EN0066 OR S_EN04C6 OR S_EN0562 ) AND N_ROMCS AND NOT N_M1;

--
--
-- SWITCHES FOR ENTRY POINT ( CONMEM OFF )
--
    S_EN1FF8 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11) AND A(12) AND NOT A(13); 
    S_EN1FFF <=     A(0) AND     A(1) AND     A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11) AND A(12) AND NOT A(13); 

-- WHEN TRUE THE CONMEM MODE GOES OFF
    S_AUTO_CONMEM_OFF  <= ( S_EN1FF8 OR S_EN1FFF ) AND NOT N_M1; 

--
-- SWITCHES FOR PAGE0 AND PAGE1
--
-- A(13) DETECT IF WE ARE ADDRESSING SOMETHING INTO THE ROM ADDRESSINGS SPACE ( LOW )
--              OR WE ARE ACCESSING THE RAM ADDRESSING SPACE
-- A(12) DETECT THE ROM'S PAGE ( 2 8K PAGES : A(12) = 1 => PAGE 1, A(12) = 0 => PAGE0 )
--
   S_ACCESSING_PAGE0 <= NOT A(13) AND NOT A(12);
   S_ACCESSING_PAGE1 <= NOT A(13) AND     A(12);


-- ACCESSING INTERFACE CONTROL REGISTER 8 on M1
-- [ CONTROL REGISTER (READ/Write) ]
-- xxxx xxxx 1110 0011, 0e3h, 227
    S_CFG_REG_EN <= A(0) and A(1) and not A(2) and not A(3) and not A(4) and A(5)  and A(6) and A(7) and N_M1;
--- [ VERSION REGISTER ]
--- xxxx xxxx 1110 0111, 0e3h, 227
    S_VER_REG_EN <= A(0) and A(1) and not A(2) and A(3) and not A(4) and A(5)  and A(6) and A(7) and N_M1;  
    S_INTERFACECS <= S_CFG_REG_EN OR S_VER_REG_EN;

-- #########################################################################
-- ACCESSING THIS INTERFACE LOGIC ( SEQ )
-- #########################################################################

    PROC_INTERFACE_EN : PROCESS( S_INTERFACECS, N_RD, N_WR ) 
    BEGIN
        IF S_CFG_REG_EN = '1' AND rising_edge(N_WR) THEN -- CHECK WR Z80 CICLE
           S_SWITCH_CONMEM_ONOFF <= D(7);
            S_MAPRAM <= D(6);
            BANK( 4 DOWNTO 0 ) <= D( 4 downto 0 );
        ELSIF S_VER_REG_EN = '1' AND RISING_EDGE(N_RD) THEN 
           D <= "00000000"; -- THIS INTERFACE VERSION
       END IF;
-- LEAVE D BUS IS HIGH IMPEDENCE STATE
       D <= "ZZZZZZZZ";
    END PROCESS;


     
-- OUTPUTS THE SIGNALS 
-- CONMEM IS TRUE IF ENTRY POINT ON IS ACTIVE, ENTRY POINT OFF IS NOT ACTIVE 
--                AND THERE IS NO MANUAL SWITCH
--
-- KEEP THE VALUE UNTIL THE SIGNALS CHANGES
-- CHANGES ON OP CODE FETCHING 
--

    A1 <= S_AUTO_CONMEM_ON OR S_AUTO_CONMEM_OFF; -- NEVER OVERLAPS 
    PROCESS_CONMEM : PROCESS( S_AUTO_CONMEM_ON , S_AUTO_CONMEM_OFF, A1  )
     BEGIN

-- LATCH WHEN THE OP FETCH CYCLE IS ENDED    
         IF RISING_EDGE( A1 ) THEN 
              S_CONMEM <= S_AUTO_CONMEM_ON AND NOT S_AUTO_CONMEM_OFF;
          END IF;
     END PROCESS;
     
     
-- ###########################################################
-- SRAM ACCESS 
-- ###########################################################
--
-- RAM ENABLE IF: 
--    CONMEM OR MAPRAM IS ACTIVE 
--    ACCESSING IS ON PAGE1

--
---------------------------
--
-- So, when CONMEM is set, there is:
-- 0000-1fffh - EEPROM/EPROM/NOTHING(if empty socket), and this area is
--       flash-writable if EPROM jumper is open.
--
-- 2000-3fffh - 8k bank, selected by BANK 0..1 bits, always writable.
--
----------------------------
--
-- When MAPRAM is set, but CONMEM is zero, and entrypoint was reached:
-- 0000-1fffh - Bank No.3, read-only
--
-- 2000-3fffh - 8k bank, selected by BANK 0..1. If it's different from Bank No.3,
--       it's writable.
--
--------------------------
--
--
-- When MAPRAM is zero, CONMEM is zero, EPROM jumper is closed and entrypoint was
-- reached (S_CONMEM SET ) :
-- 0000-1fffh - EEPROM/EPROM/NOTHING(if empty socket, so open jumper in this case),
--       read-only.
--
-- 2000-3fffh - 8k bank, selected by BANK 0..1, always writable.
--
--                                                          JMP
--                                                         /
--   PAGE1 PAGE0 N_WR N_RD N_M1 N_MREQ S_CONMEM S_MAPRAM  J   |   SRAMCS  SEEPROMCS  EEPROMWR  BANK(0-2)
--       0     0    1    1    1      1 0        0         0   |    0      0    
--       0     1    0    1    1      1 0        0         0   |    0      1          0
--       0     1    1    1    1      1 0        0         0   |    0      1          1
--       0     1    0    1    1      1 0        0         1   |    0      1          0
--       0     1    1    1    1      1 0        0         1   |    0      1          0
--       1     0    1    1    1      1 0        0         0   |    1      0
--       X     X    1    1    1      1 0        0         0   |    X      X
--       0     0    1    1    1      1 1        0         0   |    0      0
--       X     X    1    1    1      1 0        1         0   |    X      0                    011
--       0     0    1    1    1      1 0        0         0   |    0      0
--
--
--
--
--
--
--
--
--
--
--






-- SRAM CHIP SELECT 
--
--  CONMEM    NMAP     CHIP_SELECT 
--  TRUE      FALSE   ON PAGE1 ACCESS, PAGE 0 IS EEPROM 
--  TRUE      TRUE    ON PAGE0,1 ACCESS.
--  FALSE     FALSE   OFF
--  FALSE     TRUE     ON  PAGE0,1 ACCESS.
    -- ko --
     N_SRAMCS <= NOT (S_CONMEM OR ( S_MAPRAM  AND S_ACCESSING_PAGE1 ) ) ;
    -- KO --
     N_SRAMOE <= NOT N_RD AND N_MREQ AND N_SRAMCS; 
     -- KO --
     N_SRAMWR <= NOT N_WR AND N_MREQ AND N_SRAMCS AND NOT S_MAPRAM; -- WRITE ONLY IF MAPRAM IS OFF
    
-- ###########################################################
-- EEPROM ACCESS 
-- ###########################################################

--  CONMEM    NMAP     CHIP_SELECT 
--  TRUE      FALSE   ON PAGE0 ACCESS ***** LA PAGINA 0 NON SELEZIONA LA LINEA
--  TRUE      TRUE    OFF ( NO EEPROM ACCESS IS DONE ) 
--  FALSE     FALSE   OFF ( NO EEPROM ACCESS IS DONE )
--  FALSE     TRUE     OFF ( NO EEPROM ACCESS IS DONE 9

-- WHEN ACCESSING THE EEPROM DISABLE THE ROM 
-- ROM ONLY IN PAGE0, DISABLE ROM WHEN ACCESSING SOOMETHING OUT OF THE PAGE12 RANGE
   S_EEPROMCS <= S_CONMEM AND NOT S_MAPRAM AND S_ACCESSING_PAGE0;
    N_EEPROMCS <= NOT S_EEPROMCS;
-- DISABLE INTERNAL ROM IF THE MAPRAM IS OFF AND CONMEM IS ON ( STANDARD INTERFACE LAYOUT ) AND EEPROM IS ADDRESSED
    N_ROMCS <= ( NOT S_EEPROMCS AND N_MREQ)  OR (NOT S_CONMEM ) ;
    
--
-- WRITE MODE IS AVAILABLE IF AND ONLY IF THE EEPROM JUMPER IS SET AND WE ARE ACCESING THE ROM ADDRESSING SPACE
-- 
-- EEPROM IS WRITABLE IF THE JUMPER IS ACTIVATED, A WRITE CYCLE IS STARTED AND INTEFACE HAS STANDARD LAYOUT
    N_EEPROMWR <= JUMPER_EEPROM OR N_WR OR N_MREQ OR NOT S_CONMEM OR NOT S_EEPROMCS ;
    
-- EEPROM IS READABLE WHEN ADDRESSED ON APGE0 ( S_EEPROMCS & ACCESSING_PAGE0 ) 
--                         MAPRAM IS OFF AND CONMEM IS ON ( STANDARD INTERFACE MEMORY LAYOUT )
--                         AND WE ARE PERFORMING A STANDARD RD CYCLE 
--
    N_EEPROMOE <= NOT S_EEPROMCS OR N_RD OR N_MREQ ;
    -- ( NOT N_RD AND N_MREQ ) OR ( ( S_CONMEM AND NOT S_MAPRAM ) OR ( S_ACCESSING_PAGE0 OR NOT S_EEPROMCS ) );
    
    
end Behavioral;

