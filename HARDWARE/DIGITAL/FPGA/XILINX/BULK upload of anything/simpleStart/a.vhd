----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:30 11/23/2011 
-- Design Name: 
-- Module Name:    a - Behavioral 
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

entity a is
    Port ( in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (3 downto 0);
           F : out  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC);
end a;

architecture Behavioral of a is

begin
	process ( in1, in2, data, clk ) 
	begin
	
		if ( in1 = '1' and clk = '1' and clk'EVENT ) then 
			if ( data = "0000" ) then
				F <= "0000";
			end if; 
			if ( in1 = '0' ) then 
				F <= "ZZZZ";
			end if; 
			if ( in2 = '0' and in2 = '1' ) then 
				F <="XXXX";
			end if;
			if ( in1 = '0' and in2 = '0' ) then 
				F <= "1001"; 
			end if; 
		end if;
	end process ;
end Behavioral;








