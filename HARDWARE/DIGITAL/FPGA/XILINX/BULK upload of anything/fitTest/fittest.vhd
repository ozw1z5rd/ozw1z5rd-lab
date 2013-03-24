----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:25 11/22/2011 
-- Design Name: 
-- Module Name:    fittest - Behavioral 
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
-- arithmetic functions with Signed + Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fittest is

	Port (
-- controll bus lines 	

		romoff: 	out STD_LOGIC;
		automap: in STD_LOGIC; 
		eprom:   in STD_LOGIC;
		mapram: 	in STD_LOGIC; 
		conmem: 	in STD_LOGIC;
		
		
		WR: 	in STD_LOGIC;		
		not_doe: 	in STD_LOGIC;		
		mgalclk: in STD_LOGIC;
		RD: in STD_LOGIC; 
		loe: in STD_LOGIC; 		
		not_romacc: in STD_LOGIC; 
		evenodd: out STD_LOGIC; 		
		IORQ: in STD_LOGIC; 		
		mgalclk: in STD_LOGIC; 		
		rgalclk: in STD_LOGIC; 				
		bank0: out STD_LOGIC; 
		bank1: out STD_LOGIC; 		
		
-- address bus slices 		
		A13: in STD_LOGIC; 
		A14: in STD_LOGIC; 
		A15: in STD_LOGIC; 		
		
-- data Bus slices		
		D0: in STD_LOGIC;
		D1: in STD_LOGIC;
		D6: in STD_LOGIC;
		D7: in STD_LOGIC;
		
-- external bus
		ideio0: out STD_LOGIC;
		ideio1: out STD_LOGIC;
		hdrd: out STD_LOGIC;
		
		hdrw:
		
	
  
	
	
	);


end fittest;

-- -------------------------------------------------------------------------------

architecture Behavioral of fittest is
begin

    process (
		CLK, not_WR,
		eprom, mapram, romacc, 
		D0, D1, not RD, automap, 
		D7, D6, A13,  
		eprom, romoff, not_romoe, 
		conmem, bank0, bank1, 
		ramoe, addr1, 
		not mgalclk,
		addr0, not_ramwr, mapram)
		
		
		
		
		
				mgalclk	<=  IORQ and mgalclk
					 +  not RD and not WR and mgalclk
					 +  not ideio0 and not ideio1 and mgalclk
					 +  ideio1 and evenodd and not RD and not hdwr and mgalclk
					 +  ideio1 and not ideio0 and not RD and not hdwr and mgalclk
					 +  ideio1 and ideio0 and not RD and not loe and mgalclk
					 +  ideio1 and not WR and not_doe and mgalclk
					 +  not IORQ and not RD and not WR and not loe and not_doe and not hdrd;		
		
    begin

        if clock = '1' and clock'event then 

            romoff <= automap * eprom
                   + automap * mapram
                   + conmem;					  

            addr0	<= bank0
                 +  not_A13;

            addr1	<= bank1
                 +  not A13;

            not_romoe	<= not RD +  not romacc +  A13 +  not conmem and mapram +  not conmem and not automap +  not_conmem and not eprom;

            not_ramoe	<= not RD
                 +  not_romacc
                 +  not A13 and not mapram
                 +  not A13 and conmem
                 +  not conmem and not automap
                 +  not conmem and not eprom and not mapram;

            not_ramwr	<= not WR
                 +  not romacc
                 +  not A13
                 +  not conmem and mapram and bank0 and bank1 
                 +  not conmem and not automap
                 +  not conmem and not eprom and not mapram;

            bank0	<= D0;

            bank1	<= D1;

            mapram	<= D6 +  mapram;

            conmem	<= D7;

            mgalclk	<= not IORQ and mgalclk
                 +  not RD and not WR and mgalclk
                 +  not_ideio0 and not ideio1 and mgalclk
                 +  ideio1 and evenodd and not RD and not hdwr and mgalclk
                 +  ideio1 and not ideio0 and not RD and not hdwr and mgalclk
                 +  ideio1 and ideio0 and not RD and not loe and mgalclk
                 +  ideio1 and not WR and not doe and mgalclk
                 +  not IORQ and not RD and not WR and not loe and not doe and not hdrd;

            rgalclk	<= not IORQ and rgalclk
                 +  not WR and rgalclk
                 +  not ideio0 and rgalclk
                 +  ideio1 and rgalclk
                 +  mgalclk and rgalclk
                 +  not IORQ and not WR;

            romacc	<= not A14 and not A15;

            not_romwr <= not WR
                 +  A13
                 +  A14
                 +  A15
                 +  eprom
                 +  not conmem;

            not loe	<= not IORQ and not loe
                 +  not RD and not WR and not loe
                 +  not_ideio1 and not loe
                 +  not_ideio0 and not loe
                 +  not_WR and not evenodd and not loe
                 +  not IORQ and not RD and not WR and not lclk and not hdwr and not doe;

            not_doe	<= not IORQ and not doe
                 +  not RD and not WR and not doe
                 +  not_ideio1 and not doe
                 +  not RD and ideio0 and not doe
                 +  not_WR and not loe and not hdrd and not doe
                 +  not IORQ and not RD and not WR and not hdwr;

            lclk	<= IORQ and RD and ideio1 and ideio0 and not evenodd and not mgalclk
                 +  IORQ and WR and ideio1 and ideio0 and not evenodd and not mgalclk
                 +  IORQ and lclk
                 +  RD and lclk
                 +  WR and lclk;

            not_hdwr	<= not IORQ and not hdwr
                 +  not_WR and not hdwr
                 +  not_ideio1 and not hdwr
                 +  ideio0 and not evenodd and not hdwr
                 +  not loe and not doe and not hdwr
                 +  not IORQ and not WR;

            not_hdrd	<= not IORQ and not hdrd
                 +  not RD and not hdrd
                 +  not_ideio1 and not hdrd
                 +  ideio0 and evenodd and not hdrd
                 +  not IORQ and not RD and not lclk and not doe;

            evenodd	 <= not_evenodd and ideio0 and ideio1;
--
-- EQ broken missing term before IORQ
--

				mgalclk	<=  IORQ and mgalclk
					 +  not RD and not WR and mgalclk
					 +  not ideio0 and not ideio1 and mgalclk
					 +  ideio1 and evenodd and not RD and not hdwr and mgalclk
					 +  ideio1 and not ideio0 and not RD and not hdwr and mgalclk
					 +  ideio1 and ideio0 and not RD and not loe and mgalclk
					 +  ideio1 and not WR and not_doe and mgalclk
					 +  not IORQ and not RD and not WR and not loe and not_doe and not hdrd;

				rgalclk	<= not IORQ and rgalclk
					 +  not_WR and rgalclk
					 +  not_ideio0 and rgalclk
					 +  ideio1 and rgalclk
					 +  mgalclk and rgalclk
					 +  not IORQ and not_WR;

				romacc	<= not_A14 and not_A15;

				not_romwr	<= not_WR
					 +  A13
					 +  A14
					 +  A15
					 +  eprom
					 +  not_conmem;

				not loe	<= not IORQ and not loe
					 +  not RD and not_WR and not loe
					 +  not ideio1 and not loe
					 +  not ideio0 and not loe
					 +  not WR and not evenodd and not loe
					 +  not IORQ and not RD and not WR and not lclk and not_hdwr and not_doe;

				not_doe	<= not IORQ and not doe
					 +  not RD and not_WR and not doe
					 +  not ideio1 and not doe
					 +  not RD and ideio0 and not_doe
					 +  not_WR and not loe and not_hdrd and not_doe
					 +  not IORQ and not RD and not WR and not hdwr;

				lclk	<= IORQ and RD and ideio1 and ideio0 and not evenodd and not mgalclk
					 +  IORQ and WR and ideio1 and ideio0 and not evenodd and not mgalclk
					 +  IORQ and lclk
					 +  RD and lclk
					 +  WR and lclk;

				not_hdwr	<= not IORQ and not_hdwr
					 +  not WR and not hdwr
					 +  not ideio1 and not hdwr
					 +  ideio0 and not evenodd and not hdwr
					 +  not loe and not_doe and not hdwr
					 +  not IORQ and not WR;

				not_hdrd	<= not IORQ and not_hdrd
					 +  not RD and not_hdrd
					 +  not ideio1 and not hdrd
					 +  ideio0 and evenodd and not hdrd
					 +  not IORQ and not RD and not lclk and not doe;

				evenodd	<= not evenodd and ideio0 and ideio1;

        end if;
    end process;
end Behavioral;








