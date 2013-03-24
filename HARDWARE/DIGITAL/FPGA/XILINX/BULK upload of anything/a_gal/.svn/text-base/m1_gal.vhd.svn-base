----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:13 12/05/2011 
-- Design Name: 
-- Module Name:    m1_gal - Behavioral 
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

entity m1_gal is
    Port ( mgalclk : out  STD_LOGIC;
           rgalclk : out  STD_LOGIC;
           A15 : in  STD_LOGIC;
           A14 : in  STD_LOGIC;
           A13 : in  STD_LOGIC;
           ideio0 : in  STD_LOGIC;
           ideio1 : in  STD_LOGIC;
			  NOT_WR : in  STD_LOGIC;
           NOT_RD : in  STD_LOGIC;
           conmem : in  STD_LOGIC;
           NOT_eprom : in  STD_LOGIC;
           NOT_loe : out  STD_LOGIC;
           NOT_doe : out  STD_LOGIC;
           NOT_hdwr : out  STD_LOGIC;
           NOT_hdrd : out  STD_LOGIC;
           romacc : out  STD_LOGIC;
           lclk : out  STD_LOGIC;
           evenodd : out  STD_LOGIC;
           NOT_romwr : out  STD_LOGIC;
			  CLOCK : in STD_LOGIC;
           NOT_IORQ : in  STD_LOGIC);
end m1_gal;



architecture Behavioral of m1_gal is


	signal sig_mgalclk : STD_LOGIC := '0';
	signal sig_rgalclk : STD_LOGIC := '0';
	signal sig_NOT_loe : STD_LOGIC := '0';	
	signal sig_NOT_doe : STD_LOGIC := '0';	
	signal sig_lclk    : STD_LOGIC := '0';	
	signal sig_NOT_hdrd: STD_LOGIC := '0';	
	signal sig_NOT_hdwr: STD_LOGIC := '0';	
	signal sig_evenodd : STD_LOGIC := '0';	
	

begin


-- sequential 

process (A13,A14,A15,ideio0, ideio1, NOT_WR, NOT_RD, conmem, NOT_eprom, NOT_IORQ )
begin

-- sequential and synced
			
		if ( CLOCK = '1' and CLOCK'EVENT ) then 
			sig_evenodd <= not sig_evenodd and ideio0 and ideio1;
		end if;
		
		evenodd <= sig_evenodd;

-- 
		sig_mgalclk <= ( NOT_IORQ and sig_mgalclk  )
			  or (NOT_RD and  NOT_WR  and  sig_mgalclk )
			  or (not ideio0 and not ideio1 and sig_mgalclk )
			  or (ideio1 and sig_evenodd and NOT_RD and sig_NOT_hdwr and sig_mgalclk )
			  or (ideio1 and not ideio0 and NOT_RD and sig_NOT_hdwr and sig_mgalclk )
			  or (ideio1 and not ideio0 and NOT_RD and sig_NOT_loe and sig_mgalclk )
			  or (ideio1 and NOT_WR and sig_NOT_doe and sig_mgalclk )
			  or (NOT_IORQ and NOT_RD and NOT_WR and sig_NOT_loe and sig_NOT_doe and sig_NOT_hdrd );

		mgalclk <= sig_mgalclk;
		
		sig_rgalclk <= ( NOT_IORQ and sig_rgalclk )
			  or (NOT_WR and sig_rgalclk )
			  or ( not ideio0 and sig_rgalclk )
			  or (ideio1 and sig_rgalclk )
			  or (sig_mgalclk and sig_rgalclk )
			  or (NOT_IORQ and NOT_WR );
			  
		rgalclk <= sig_rgalclk;

		romacc  <=  not A14 and not A15;

		NOT_romwr  <= NOT_WR 
			  or (A13)
			  or (A14)
			  or (A15)
			  or (not_eprom)
			  or ( not conmem);

		NOT_loe    <= ( NOT_IORQ AND sig_NOT_loe )
			  or (NOT_RD and NOT_WR and sig_NOT_loe )
			  or ( not ideio1 and sig_NOT_loe )
			  or ( not ideio0 and sig_NOT_loe )
			  or (NOT_WR and not sig_evenodd and sig_NOT_loe )
			  or (NOT_IORQ and NOT_RD and NOT_WR and not sig_lclk and sig_NOT_hdwr and sig_NOT_doe );

		NOT_doe    <= ( NOT_IORQ and sig_NOT_doe )
			  or (NOT_RD and NOT_WR and sig_NOT_doe )
			  or ( not ideio1 and sig_NOT_doe )
			  or (NOT_RD and ideio0 and sig_NOT_doe )
			  or (NOT_WR and sig_NOT_loe and sig_NOT_hdrd and sig_NOT_doe )
			  or (NOT_IORQ and NOT_RD and NOT_WR and sig_NOT_hdwr );

		sig_lclk    <=  (not NOT_IORQ and not NOT_RD and ideio1 and ideio0 and not sig_evenodd and not sig_mgalclk )
				  or (not NOT_IORQ and not NOT_WR and ideio1 and ideio0 and not sig_evenodd and not sig_mgalclk )
				  or (not NOT_IORQ and sig_lclk )
				  or (not NOT_RD and sig_lclk )
				  or (not NOT_WR and sig_lclk );
				  
			lclk <= sig_lclk;
			
			NOT_hdwr   <= ( NOT_IORQ and sig_NOT_hdwr )
				  or (NOT_WR and sig_NOT_hdwr )
 				  or ( not ideio1 and sig_NOT_hdwr )
				  or (ideio0 and not sig_evenodd and sig_NOT_hdwr )
				  or (sig_NOT_loe and sig_NOT_doe and sig_NOT_hdwr )
				  or (NOT_IORQ and NOT_WR );

			NOT_hdrd   <= ( NOT_IORQ and sig_NOT_hdrd )
				  or (NOT_RD and sig_NOT_hdrd )
				  or ( not ideio1 and sig_NOT_hdrd )
				  or (ideio0 and sig_evenodd and sig_NOT_hdrd )
				  or (NOT_IORQ and NOT_RD and not sig_lclk and sig_NOT_doe );

	end process;

end Behavioral;

