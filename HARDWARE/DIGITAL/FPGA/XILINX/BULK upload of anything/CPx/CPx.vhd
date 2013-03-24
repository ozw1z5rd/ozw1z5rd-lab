----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:41 01/13/2012 
-- Design Name: 
-- Module Name:    CPx - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPx is
    Port ( 
	 
--
--  ######## A/D BUSSES #########
--	 
	 
	        A : in  STD_LOGIC_VECTOR (15 downto 0);   --16
           D : inout  STD_LOGIC_VECTOR (7 downto 0); --8 ( non dovrebbe essere ro ? 
			  
--
--  ######## JUMPERS #########
--			  

-- COMPATIBILITY MODE ( NO 512K SRAM, JUST 32K )			  
			  COMP_MODE : in STD_LOGIC; 
-- FUSE / UNFUSE EEPROM
           EEPROM : in STD_LOGIC; 
           CLOCK : in  STD_LOGIC;

-- RAM / IO LINES
			  N_IOREQ : OUT STD_LOGIC;
           N_MREQ : IN  STD_LOGIC; -- FROM Z80
           N_RD : in  STD_LOGIC;
           N_WR : in  STD_LOGIC;
           N_M1 : in  STD_LOGIC;			

-- LEDS ...
			  LED_MAPRAM : out STD_LOGIC;
			  LED_COMP_MODE : out STD_LOGIC;
			  
			  
-- NO EXTERNAL DEVICE WHICH CAN ACCESS THE ROM MAPPING FUNCTION ( IE INTEFACE 2) 			  
--- ADDRESSING LINE FOR ROM ARE A0-A13			  
			  ROMCS   : BUFFER STD_LOGIC; 

			  
-- DMA LINES ( NOT YET USED )
			  N_BUSREQ : OUT STD_LOGIC;
			  N_BUSACK : IN STD_LOGIC;
			  
-- INTERRUPTS ( NOT HANDLED IN TRUE )
           N_NMI : IN  STD_LOGIC;
			  NMI   : BUFFER STD_LOGIC;
			  
			  N_INT : IN STD_LOGIC; 
			  INT : buffer STD_LOGIC;
			  
           N_RESET : in  STD_LOGIC;
---- SRAM CONTROL BUS			  
			  
			SRAM_EN : OUT  STD_LOGIC :='0';
			SRAMOE  : OUT STD_LOGIC :='0';
			SRAMWR  : OUT STD_LOGIC :='0';
			SRAMCS  : OUT STD_LOGIC :='0';
			  
----	EEPROM CONTROL BUS
			  N_EEPROMWR : OUT STD_LOGIC :='0';
			  N_EEPROMOE : OUT STD_LOGIC :='0';
			  N_EEPROM_EN: OUT STD_LOGIC :='0';
			  EEPROMCS   : OUT STD_LOGIC :='0';
			  
-- SRAM is mapped as ROM and write is disabled 	
-- BANK3 
           NMAP :    BUFFER STD_LOGIC;   --  "     "
			  
--- ADDRESSING LINE FOR SRAM ( THESE LINE FILL UP THE MISSING PART OF THE SRAM ADDRESS BUS
--- SRAM is attached to the A(0 to 13) 
---      SRAM A(14-18) are connected to BANK() bus 
---
			  BANK   : buffer STD_LOGIC_VECTOR (5 downto 0 ) -- 32 x 16 
          );
end CPx;

architecture Behavioral of CPx is


   signal S_CONMEM : STD_LOGIC := '0'; -- CONMEM enable the 8K EEPROM to act as ROM and maps the SRAM page selected by Bank0 Bank1 and SEL into the 2000 3fff address
	signal S_NMI    : STD_LOGIC := '0'; -- Handled NMI 
	signal S_MAPTERM : STD_LOGIC :='0'; 
	signal S_MAPRAM  : STD_LOGIC :='0'; 
	signal S_MAPCOND : STD_LOGIC := '0'; 
	
-- stores the given configuration	
   signal S_CFREG  : STD_LOGIC_VECTOR (7 downto 0 );	
	
-- WHEN THE SPECTRUM ROM MUST DISABLED
   SIGNAL S_ROMOFF   :STD_LOGIC := '0';

-- ACCESSING THE IO REGISTEROF THE INTERFACE
   SIGNAL S_IO_EN    : STD_LOGIC := '0';
-- 	
   SIGNAL S_EN0000    :STD_LOGIC  :='0';
   SIGNAL S_EN0008    :STD_LOGIC  :='0';
   SIGNAL S_EN0038    :STD_LOGIC  :='0';
   SIGNAL S_EN0066    :STD_LOGIC  :='0';
   SIGNAL S_EN04C6    :STD_LOGIC  :='0';
   SIGNAL S_EN0562    :STD_LOGIC  :='0';

   SIGNAL S_ROMCS     :STD_LOGIC := '0';
   SIGNAL S_SRAMEN     :STD_LOGIC := '0';

	SIGNAL S_ACCESSING_P0 : STD_LOGIC :='0';
	SIGNAL S_ACCESSING_P1 : STD_LOGIC :='0';
	
	SIGNAL S_N_EEPROM_EN : STD_LOGIC :='0';
	signal s_mapcond_off : STD_LOGIC := '0';
	SIGNAL S_RAMEN : STD_LOGIC := '0';
	SIGNAL CFG_REG_EN : STD_LOGIC := '0'; 
	SIGNAL VER_REG_EN : STD_LOGIC := '0'; 
begin
	

-- device  output reset
   RST: PROCESS( N_RESET ) 
	begin 
	   IF N_RESET = '1' THEN 
		 	S_NMI    <= '0';
			-- S_CONMEM <= '0';
			NMAP   <= '0';	
			BANK     <= "000000";
			
		END IF;
	end PROCESS;
	
-- Access is into the ROM address !
   S_ROMCS <= not A( 15 ) and not A( 14 ); 

-- Access the SRAM PAGES ( 16K address space ) page size 8K ? 
-- Page0 : 0x0000 0x1fff
-- Page1 : 0x2000 0x3fff
   S_ACCESSING_P0 <= NOT A(15) AND NOT A(14) AND NOT A(13) AND NOT A(12);
	S_ACCESSING_P1 <= NOT A(15) AND NOT A(14) AND NOT A(13) AND     A(12);

-- disable standard ROM and allow to access EEPROM / SRAM;
--
-- AUTOMAP IS SET INTERNALLY WHEN ACCESING THE CORRECT ENTRY POINT WHICH TRIGGERS THE MAPMODE
-- MAPRAM -- SET BY SOFTWARE DETACH THE ROM AND REPLACES THE ROM WHITH BANK3 SRAM
-- CONMEM -- SET BY SOFTWARE FORCE THE EEPROM INTO THE LOWER 8K OF ADDRESSING SPACE AND MAP ONE BANK OR SRAM IN THE UPPER 8K
-- 
	S_ROMOFF <= '1'; -- ( S_AUTOMAP AND EEPROM ) OR ( S_AUTOMAP AND NMAP ) OR S_CONMEM;

-- EEPROM WR RD SIGNAL  ( check datasheet about polarity )
-- SEE DATASHEET 
-- OE => ACTIVE together the RD
-- WR => ACTIVE together the WR
-- CS => MREQ ( Z80 )


-- ACCESSING THE ROM ADDRESS
	S_N_EEPROM_EN <= NOT ( NOT A( 15 ) AND NOT A( 14 ) AND S_ROMOFF ); -- SPECCY ROM DISABLED 

	N_EEPROMWR  <= N_WR AND S_N_EEPROM_EN AND NMAP;
	N_EEPROMOE  <= N_RD AND S_N_EEPROM_EN;
	EEPROMCS    <= N_MREQ; -- Z80 

-- ACCESSING THE EXTERNAL 512K SRAM 
-- SEE DATASHEET 
-- OE => ACTIVE together the RD
-- WR => ACTIVE together the WR
-- CS => MREQ ( Z80 )

   S_SRAMEN <=  S_CONMEM AND '1';
	SRAM_EN     <= S_SRAMEN;
   SRAMOE     <= NOT ( NOT N_RD AND S_SRAMEN );
	
-- WRITE ENABLE IF AND ONLY IF THE NMAP IS DISABLED OTHERWISE ACT AS ROM AND NO WRITE ACCESS IS POSSIBLE
-- CONMEM overrides the Write protect
-- P1 always writable

	SRAMWR    <= ( NOT ( NOT N_WR AND S_SRAMEN ) AND ( NOT NMAP AND NOT S_CONMEM )) OR (S_ACCESSING_P1); 
	SRAMCS    <= N_MREQ; -- Z80 



-- ACCESSING INTERFACE CONTROL REGISTER 8 on M1
-- [ CONTROL REGISTER (READ/Write) ]
-- xxxx xxxx 1110 0011, 0e3h, 227

    CFG_REG_EN <= A(0) and A(1) and not A(2) and not A(3) and not A(4) and A(5)  and A(6) and A(7) and N_M1;
	
--- [ VERSION REGISTER ]
--- xxxx xxxx 1110 0111, 0e3h, 227
    VER_REG_EN <= A(0) and A(1) and not A(2) and A(3) and not A(4) and A(5)  and A(6) and A(7) and N_M1;
	

	
-- storing data when CPU is accessing the interface
    SAVEREG: PROCESS( VER_REG_EN, N_RD ) 
	 BEGIN 
			IF ( VER_REG_EN ='1' AND falling_edge(N_RD)) THEN 
				D <= "00000000"; --- this version
			END IF; 
	 END PROCESS;
   
	
--  CONFIGURATION REGISTER	
--    7        6      5      4      3      2      1      0
-- [ CONMEM , MAPRAM, BANK5, BANK4, BANK3, BANK2, BANK1, BANK0 ]	
--
-- IF COMPatibility MODE is on ( external jumper ignore the RAM expansion 
--


    
    SAVE_CFG_REG: PROCESS( CFG_REG_EN )
	 BEGIN 
			IF ( CFG_REG_EN = '1' AND rising_edge(N_WR) ) THEN
			   S_CONMEM <= D(7);
				S_MAPRAM <= D(6);
				
				
				IF COMP_MODE = '1' THEN 
				   BANK( 5 DOWNTO 0 ) <= D( 5 downto 0 );
--				ELSE 
--				   BANK(1 downto 0 ) <= D( 1 downto 0 );
--					BANK(5 downto 2 ) <= "0000";
				END IF;
				
			END IF;	
	 END PROCESS;

-- 
-- AUTOMAP LOGIC 
--
-- THE FUNCTION DESCRIBED BELOW ALLOWS THE AUTOMATIC SWTICHING BETWEEN THE STANDARD MEMORY LAYOUT 
-- AND THE ONE FORCED BY THE INTERFACE.
--

-- Automatic mapping occurs at the begining of refresh cycle after fetching
-- opcodes (M1 cycle) from 0000h, 0008h, 0038h, 0066h, 04c6h and 0562h. It's
-- also mapped instantly (100ns after /MREQ of that fetch is falling down) after
-- executing opcode from area 3d00..3dffh. Memory is automatically disconnected in
-- refresh cycle of the instruction fetch from so called off-area, which is 
-- 1ff8-1fffh.   		
	
-- mapterm - detected 0000, 0008, 0038, 0066, 04c6 and 0562
-- mapcond - entered 0000, 0008, 0038, 0066, 04c6, 0562, <3d00,3dff> & !<1ff8,1fff>
	
-- 0X0000     
-- 0X0008	
-- 0X0038 
-- 0X0066
-- 0X04c6
-- 0X0562
--
--S_EN0000 <= ( NOT A(0)  ) AND NOT A(1) AND NOT A(2) AND NOT A(3) AND NOT A(4) AND NOT A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;
--S_EN0008 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND     A(3) AND NOT A(4) AND NOT A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;
--S_EN0038 <= NOT A(0) AND NOT A(1) AND NOT A(2) AND     A(3) AND     A(4) AND NOT A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;
--S_EN0066 <= NOT A(0) AND     A(1) AND     A(2) AND NOT A(3) AND     A(4) AND     A(5) AND NOT A(6) AND NOT A(7) AND NOT A(8) AND NOT A(9) AND NOT A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;
--S_EN04C6 <= NOT A(0) AND     A(1) AND     A(2) AND NOT A(3) AND NOT A(4) AND     A(5) AND     A(6) AND NOT A(7) AND NOT A(8) AND     A(9) AND NOT A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;
--S_EN0562 <= NOT A(0) AND     A(1) AND NOT A(2) AND NOT A(3) AND NOT A(4) AND     A(5) AND     A(6) AND NOT A(7) AND     A(8) AND NOT A(9) AND     A(10) AND NOT A(11) AND NOT (12) AND NOT A(13) AND  S_ROMCS AND NOT N_M1;		 

S_EN0000 <=  NOT A(1);
S_EN0008 <=  NOT A(2);
S_EN0038 <=  NOT A(3) AND NOT A(4);
S_EN0066 <=  A(5);
S_EN04C6 <=  A(6);
S_EN0562 <=  A(7);




S_MAPTERM <= S_EN0000 OR S_EN0008 OR S_EN0038 OR S_EN0066 OR S_EN04C6 OR S_EN0562;

    
S_MAPCOND <= S_MAPTERM ;
--    + S_MAPCOND*/M1 
--    + S_MAPCOND*/S_ROMCS
--    + S_MAPCOND*A13 
--    + S_MAPCOND*/A12
--    + S_MAPCOND*/A11
--    + S_MAPCOND*/A10
--    + S_MAPCOND*/A9
--    + S_MAPCOND*/A8
--    + S_MAPCOND*/A7
--    + S_MAPCOND*/A6
--    + S_MAPCOND*/A5
--    + S_MAPCOND*/A4
--    + S_MAPCOND*/A3
	
	
-- It's also mapped instantly (100ns after /MREQ of that fetch is falling down) after
-- executing opcode from area 3d00..3dffh. 
--
-- Memory is automatically disconnected in
-- refresh cycle of the instruction fetch from so called off-area, which is 
-- 1ff8-1fffh.


-- 0X1FF8	
-- 0X1FFF	
-- ( NOT A(0) AND NOT A(1) AND NOT A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11) AND (12) AND NOT A(13) AND NOT A(15) AND NOT A(14)  AND NOT A(13) ); -- OR ( A(0) AND A(1) AND A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11) AND (12) AND NOT A(13) AND NOT A(15) AND NOT A(14) AND NOT A(13) ) ;
S_MAPCOND_OFF <= 	NOT A(0) AND NOT A(1) AND NOT A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11); -- AND (12) AND NOT A(13) ; --AND NOT A(15) AND NOT A(14) ; --  OR ( A(0) AND A(1) AND A(2) AND A(3) AND A(4) AND A(5) AND A(6) AND A(7) AND A(8) AND A(9) AND A(10) AND A(11) AND (12) AND NOT A(13) AND NOT A(15) AND NOT A(14) ) ;

-- 
-- ACTIVATE AUTOMAP ON OP CODE FETCH FROM ENTRY POINTS ( S_MAPTERM ) 
-- SWITCH IT OFF WHEN ACCESSING FROM THE OFF-AREA 
-- NMAP OVERRIDES ANYTHING.
--
	 AUTOMAP_ON_OFF: PROCESS( S_MAPTERM, S_MAPCOND, NMAP, N_M1 )
	 VARIABLE A : STD_LOGIC;
	 BEGIN 
			-- IF ( ( S_MAPTERM AND NOT NMAP AND rising_edge(N_M1) ) OR ( S_MAPCOND ) ) THEN -- controllare il refresh 
			   A := S_MAPTERM AND NOT NMAP; -- AND rising_edge(N_M1);
			   IF  A = '1' THEN -- controllare il refresh 
		--	   S_CONMEM <= S_MAPTERM AND NOT S_MAPCOND_OFF;
			END IF;
	 END PROCESS;

--
-- So, when CONMEM is set, there is:
-- 0000-1fffh - EEPROM/EPROM/NOTHING(if empty socket), and this area is
--	     flash-writable if EPROM jumper is open.
-- 2000-3fffh - 8k bank, selected by BANK 0..5 bits, always writable.
--
-- When MAPRAM is set, but CONMEM is zero, and entrypoint was reached:
-- 0000-1fffh - Bank No.3, read-only
-- 2000-3fffh - 8k bank, selected by BANK 0..5. If it's different from Bank No.3,
--	     it's writable.
--
--
-- When MAPRAM is zero, CONMEM is zero, EPROM jumper is closed and entrypoint was
-- reached:
-- 0000-1fffh - EEPROM/EPROM/NOTHING(if empty socket, so open jumper in this case),
--	     read-only.
-- 2000-3fffh - 8k bank, selected by BANK 0..5, always writable.
-- 

 	
	
end Behavioral;

