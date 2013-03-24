----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:27:17 12/01/2011 
-- Design Name: 
-- Module Name:    a_gal - Behavioral 
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

entity a_gal is
    Port ( A : in  STD_LOGIC_VECTOR (13 downto 0);
           CLOCK : in  STD_LOGIC;
--
-- RESET NON IMPLEMENTATO ( NON ANCORA )
--			  
			  
           M1      : in  STD_LOGIC;
           mapcond : out  STD_LOGIC;
           mapterm : out  STD_LOGIC;
           ideio0 : out  STD_LOGIC;
           ideio1 : out  STD_LOGIC;
           romacc : in  STD_LOGIC;
           automap : out  STD_LOGIC);
end a_gal;

architecture Behavioral of a_gal is

	signal sig_mapcond : STD_LOGIC := '0';
	signal sig_mapconf : STD_LOGIC := '0';
	signal sig_mapterm : STD_LOGIC := '0';
	
begin

--
-- Synced
--
SYNC: process (A,CLOCK, M1 ) 
begin

--	if ( RST = '1' ) then 
--		sig_mapconf <= '0';
--		sig_mapterm <= '0';
--		mapcond <= '0';
--		mapterm <= '0';
--		ideio0 <= '0';
--		ideio1 <= '0';
--	end if; 

	if ( CLOCK = '1' and CLOCK'EVENT ) then 

		sig_mapcond <= sig_mapterm
		--    + A8*/A9*A10*A11*A12*A13*romacc*M1 ;Beta
			or ( sig_mapcond and  not M1 )
			or ( sig_mapcond and  not romacc )
			or ( sig_mapcond and A(13) )
			or ( sig_mapcond and  not A(12) )
			or ( sig_mapcond and  not A(11) )
			or ( sig_mapcond and  not A(10) )
			or ( sig_mapcond and  not A(9) )
			or ( sig_mapcond and  not A(8) )
			or ( sig_mapcond and  not A(7) )
			or ( sig_mapcond and  not A(6) )
			or ( sig_mapcond and  not A(5) )
			or ( sig_mapcond and  not A(4) )
			or ( sig_mapcond and  not A(3) );
		
		mapcond <= sig_mapcond;
		
		automap <= sig_mapcond;
		
	end if;
end process;

--
-- comb
--
ideio0 <= A(0) and A(1) and not A(2) and not A(3) and not A(4) and A(5) and A(7);
ideio1 <= A(0) and A(1) and A(5) and not A(6) and A(7);

sig_mapterm <=   (  not A(0) and  not A(1) and  not A(2) and  not A(3) and  not A(4) and  not A(5) and  not A(6) and  not A(7) and  not A(8) and  not A(9) and  not A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 )
			OR (  not A(0) and  not A(1) and  not A(2) and A(3) and  not A(4) and  not A(5) and  not A(6) and  not A(7) and  not A(8) and  not A(9) and  not A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 )
			OR (  not A(0) and  not A(1) and  not A(2) and A(3) and A(4) and A(5) and  not A(6) and  not A(7) and  not A(8) and  not A(9) and  not A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 )
			OR (  not A(0) and A(1) and A(2) and  not A(3) and  not A(4) and A(5) and A(6) and  not A(7) and  not A(8) and  not A(9) and  not A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 )
			OR (  not A(0) and A(1) and A(2) and  not A(3) and  not A(4) and  not A(5) and A(6) and A(7) and  not A(8) and  not A(9) and A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 )
			or (  not A(0) and A(1) and  not A(2) and  not A(3) and  not A(4) and A(5) and A(6) and  not A(7) and A(8) and  not A(9) and A(10) and  not A(11) and  not A(12) and  not A(13) and romacc and M1 );

mapterm <= sig_mapterm;


end Behavioral;







