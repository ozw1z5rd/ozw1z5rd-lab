----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:12:21 11/29/2011 
-- Design Name: 
-- Module Name:    module - Behavioral 
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

entity module is
    Port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
			  clock : in STD_LOGIC;
			  rst : in STD_LOGIC; 
           o1 : out  STD_LOGIC;
           o2 : out  STD_LOGIC);
			  
			  
end module;

architecture Behavioral of module is
	
begin

--
-- single process 
--

	process ( i1, i2, i3, clock, rst ) 
	begin
	
	
	if ( rst = '1' ) then 
		o1 <= '0'; 
		o2 <= '0'; 
	end if; 
	
	
	if ( clock = '1' and clock'EVENT  ) then 
		o1 <= i1 and i2; 
		o2 <= i2 or	i1;
	end if;
	
	if ( i3 = '1'  ) then 
		o1 <= '1'; 
		o2 <= '1'; 
	end if; 
	
	o1 <= '1';
	o2 <= i1 and i2;
	
	end process;

end Behavioral;
