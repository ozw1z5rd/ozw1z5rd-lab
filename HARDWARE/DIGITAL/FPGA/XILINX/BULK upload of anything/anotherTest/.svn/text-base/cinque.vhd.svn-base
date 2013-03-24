----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:05:45 11/29/2011 
-- Design Name: 
-- Module Name:    cinque - Behavioral 
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

entity cinque is
    Port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           clock : in  STD_LOGIC;
			  o1 : out  STD_LOGIC;
			  o2 : out STD_LOGIC 
			 );
end cinque;

architecture Behavioral of cinque is


	signal test : STD_LOGIC;

begin

   process ( i1,i2, i3, clock ) 
	begin 
	
	   if ( clock = '1' and clock'EVENT ) then 
			test <= i1 and i2 ; 
			o1 <= test;
			o2 <= test xor i3;
		end if;
		
	end process;
end Behavioral;
