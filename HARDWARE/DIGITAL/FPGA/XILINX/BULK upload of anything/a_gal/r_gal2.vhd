----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:05:49 12/07/2011 
-- Design Name: 
-- Module Name:    r_gal2 - Behavioral 
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

entity r_gal2 is

 port ( 
     D : in STD_LOGIC_VECTOR (7 downto 0);
     NOT_WR : in STD_LOGIC;
     romacc : in STD_LOGIC;
     NOT_RD : in STD_LOGIC;
     automap : in STD_LOGIC;
     RESET : in STD_LOGIC;
     A13 : in STD_LOGIC;
     NOT_eprom : in STD_LOGIC;
     romoff :out STD_LOGIC;
     NOT_romoe : out STD_LOGIC;
     conmem :out STD_LOGIC;
     bank0 :out STD_LOGIC;
     bank1 :out STD_LOGIC;
     NOT_ramoe : out STD_LOGIC;
     addr1 :out STD_LOGIC;
     addr0 :out STD_LOGIC;
     NOT_ramwr :out STD_LOGIC;
	  CLOCK : in STD_LOGIC;
     mapram :out STD_LOGIC
	 );
end r_gal2;

architecture Behavioral of r_gal2 is

	signal sig_romoff: STD_LOGIC := '0';
	signal sig_NOT_romoe: STD_LOGIC:= '0' ;
	signal sig_conmem : STD_LOGIC:= '0'; 
	signal sig_bank0 : STD_LOGIC := '0';
	signal sig_bank1 : STD_LOGIC := '0'; 
	signal sig_NOT_ramoe : STD_LOGIC := '0';
	signal sig_addr1 : STD_LOGIC := '0'; 
	signal sig_addr0 : STD_LOGIC := '0';
	signal sig_NOT_ramwr : STD_LOGIC := '0';
	signal sig_mapram : STD_LOGIC := '0';


begin  

process( D, NOT_WR, romacc, NOT_RD, automap, RESET, A13,NOT_eprom, CLOCK  )
begin 

		sig_romoff  <= ( automap and not_eprom )
			  or (  automap and sig_mapram )
			  or (  sig_conmem );
			 
		romoff <= sig_romoff; 
		
		addr0   <= sig_bank0  or not A13;
		addr1   <= sig_bank1  or not A13;
		
		NOT_romoe <= ( NOT_RD )
			  or (  NOT romacc)
			  or (  A13 )
			  or (  not sig_conmem and sig_mapram )
			  or (  not sig_conmem and not automap )
			  or (  not sig_conmem and not_eprom );
			  
		NOT_ramoe  <= ( NOT_RD )
			  or (  not romacc ) 
			  or (  not A13 and  not sig_mapram ) 
			  or (  not A13 and sig_conmem ) 
			  or (  not sig_conmem and not automap )
			  or (  not sig_conmem and not_eprom and not sig_mapram );
			  
		NOT_ramwr  <= ( NOT_WR )
			  or (  not romacc )
			  or (  not A13 )
			  or (  not sig_conmem and sig_mapram and sig_bank0 and sig_bank1 )
			  or (  not sig_conmem and not automap )
			  or (  not sig_conmem and not_eprom and  not sig_mapram );

		bank0 <= sig_bank0;
		bank1 <= sig_bank1;
		mapram <= sig_mapram;
		conmem <= sig_conmem;
		

--	   if ( RESET = '1' ) then 
--			sig_bank0 <= '0'; 
--			sig_bank1 <= '0';
--			sig_mapram <= '0';
--			sig_conmem <= '0';
--		end if;

	   if ( CLOCK = '1' and CLOCK'EVENT  ) then 
			sig_bank0   <= D(0);
			sig_bank1   <= D(1);
			sig_mapram  <= D(6) or ( sig_mapram );
			sig_conmem  <= D(7);
		end if;
		
end process;

end Behavioral;

