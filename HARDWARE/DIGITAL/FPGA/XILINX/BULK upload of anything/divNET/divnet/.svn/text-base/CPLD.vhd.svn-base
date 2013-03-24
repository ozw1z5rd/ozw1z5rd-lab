----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:56 01/04/2012 
-- Design Name: 
-- Module Name:    CPLD - Behavioral 
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


-- mapterm  - detected 0000, 0008, 0038, 0066, 04c6 and 0562
-- mapcond  - entered 0000, 0008, 0038, 0066, 04c6, 0562, <3d00,3dff> & !<1ff8,1fff>
-- automap  - fetched 0000, 0008, 0038, 0066, 04c6, 0562, <3d00,3dff> & !<1ff8,1fff>

-- ideio0   - address is xxxxxxxx1x100011
-- ideio1   - address is xxxxxxxx101xxx11

-- loe - latch output enable
-- doe - driver output enable
-- hdwr    - harddrive write
-- hdrd    - harddrive read

-- lclk    - latch clock
-- mgalclk - clocks for m_gal
-- rgalclk - clocks for r_gal

-- romacc  - address is 00xx xxxx xxxx xxxx       SIGNAL 
-- evenodd - byte order flag
-- romwr   - 8k (e)eprom write

entity CPLD is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           D : inout  STD_LOGIC_VECTOR (7 downto 0);
           RD : in  STD_LOGIC;                              -- CPU RD cycle 
           WR : in  STD_LOGIC;                              -- CPU WR cycle
           NMI : out  STD_LOGIC;                            
           M1 : in  STD_LOGIC;                              -- CPU M1 cycle 
           IOREQ : in  STD_LOGIC;                           -- CPU IO access
           MREQ : in  STD_LOGIC;                            -- CPU memory access
           ROMCS : out  STD_LOGIC; 									-- disconnect the original ROM
           HDRD : out  STD_LOGIC;                           -- IDE RD cycle
           HDWR : out  STD_LOGIC;                           -- IDE RW cycle 
           HDRST : out  STD_LOGIC;                          -- IDE RESET
			  
           H : inout  STD_LOGIC_VECTOR (15 downto 0);       -- IDE Data bus
			  
           MAPRAM_LED : out  STD_LOGIC;                     -- User led ( for mapram mode activate )
			  MAPRAM : out STD_LOGIC; 								   -- ( activate the RAM in the ROM space address, locks the write cycle )
			                                                   -- start 8k (e)eprom emulation and lock sram bank 3
																				
           CONMEM : out STD_LOGIC;                          --	 EEPROM into the rom addressing space with flashing enabled, activate the 32K (sram) on the upper addressing space.
           EPROM : in  STD_LOGIC;                           -- user's switch, this will block the flashing for EEPROM and maps the EEPROM into the ROM space address
           RAMWR : out  STD_LOGIC;									-- SRAM Accessing mode
           RAMOE : out  STD_LOGIC;                          -- SRAM enable
			  BANK0 : out STD_LOGIC;                           -- SRAM bank 0
			  BANK1 : out STD_LOGIC;                           -- SRAM bank 1	
			  ADDR0 : out STD_LOGIC;                           -- line a13 for SRAM
			  ADDR1 : out STD_LOGIC;                           -- line a14 for SRAM
           ROMWR : out  STD_LOGIC;                          -- EEPROM accesing mode
           ROMOE : out  STD_LOGIC);                         -- EEPROM enable
end CPLD;

architecture Behavioral of CPLD is


	signal romacc : STD_LOGIC := '0';
   signal ideio0 : STD_LOGIC := '0'; 
	signal ideio1 : STD_LOGIC := '0'; 
	
	signal evenodd : STD_LOGIC := '0';
	signal romoff : STD_LOGIC := '0';  -- todo ma chi lo usa ? 
	signal clock1 : STD_LOGIC := '0';  -- todo verificare ....
	
	
	signal latch_r : STD_LOGIC := '0' ; 
	
	
	
	
	
begin


--
-- PURE COMBINATORY LOGIC BLOCKS 
--




--
-- internal signaling ( were the standard pal outputs line when the logic was on more than one chip ) 
--

-- accessing the rom area
	romacc <= not ( A(15) or A(14) );
-- accessing the io IDE interface ( ? ) 	
	ideio0 <= A(0) and A(1) and not A(2) and not A(3) and  not A(4) and A(5) and A(7);
	ideio1 <= A(0) and A(1)  and A(5) and  not A(6) and A(7);
	
	
--
-- SEQUENTIAL LOGIC BLOCKS
--

-- evenodd ( what part of the IDE databus we are accessing 
-- 
-- TODO in realtà sarebbe un buffer

--   if rising_edge( clock ) then 
--		evenodd <= not evenodd and ideiio0 and ideio1;
--		conmem <= '1';
--	end if;


-- ex r_gal ( clock line is driver by buffer signal



	RGAL : process ( latch_r ) 
	begin 
		if  latch_r = '1' and latch_r'event then 
			bank0 <= D(0);
			bank1 <= D(1);
			mapram <= D(6); -- todo sistemare i/O
			addr0 <= A(13);
			addr1 <=  A(13);
-- verificare se sono cloccati oppure no.
		--	romoff  <= ( automap and eprom )  or ( automap and mapram and conmem );
		--	romoe  <= RD or romacc or A(13) or ( conmem and mapram ) or ( conmem and automap ) or ( conmem and eprom  ),
--			ramoe  <= RD or romacc or ( A(13) and mapram ) or ( A(13) and conmem ) or ( conmem and automap ) or ( conmem and eprom and mapram );
--			ramwr <= WR or romacc or A(13) or  ( conmem and mapram and bank0 and bank1 ) or ( conmem and automap  and  conmem and eprom and mapram );
-- todo : perchè romwr è in un altro chip ? 		
		end if;
	end process; 

--
-- RESET BLOCK LOGIC 
--

--	process ( reset ) 
--	begin
--		if  reset = '1' then 
--			bank0 <= '0';
--			bank1 <= '0';
--			mapram <= '0';
--			conmem <= '0';
--		end if;
--	end process;






end Behavioral;

