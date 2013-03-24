----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:07:34 11/25/2011 
-- Design Name: 
-- Module Name:    test3 - Behavioral 
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

entity comp1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
			  clk : in STD_LOGIC; 
           f : out  STD_LOGIC);
end comp1;

architecture Behavioral of comp1 is

begin

	process ( a,b,c,clk )
	begin
		if ( clk = '1'  and clk'EVENT ) then 
			if ( b = '1' ) then 
				f <= 'Z';
			end if; 
		end if;
		
		if ( a = '1' ) then 
			f <= c and b;
		end if;
	
		f <= 'X' ; 
		
	end process ;
	
end Behavioral;





-- -------------------------------------------------------



entity comp2 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
			  clk : in STD_LOGIC; 
           f : out  STD_LOGIC);
end comp2;

architecture Behavioral of test3 is

begin

	process ( a,b,c,clk )
	begin
		if ( clk = '1'  and clk'EVENT ) then 
			if ( b = '1' ) then 
				f <= 'Z';
			end if; 
		end if;
		
		if ( a = '1' ) then 
			f <= c and b;
		end if;
	
		f <= 'X' ; 
		
	end process ;
	
end Behavioral;





-- -------------------------------------------------------






entity comp3 is 
	port (
		x1 :in  STD_LOGIC; 
		x2 :in  STD_LOGIC; 
		x3 :in  STD_LOGIC; 
		x4 :in  STD_LOGIC; 
		x5 :in  STD_LOGIC; 
		x6 :in  STD_LOGIC; 
		clk :in  STD_LOGIC; 
		
		
		o : out STD_LOGIC; 
		
	);
end comp3;

architecture Behavioral of comp3 is

	out: wire; 

	port map comp1 ( 
		a => x1, b=> x2; c => x3
		f => x7
	);
	
	
	port map comp2 (
		a => x4, b=> x5, c=> x6,
		
	);

	process( ) begin
		if ( ) then
		
		end if; 
		
		
		if (  ) then 
		
		
		end if; 
		
		



		
		

	end process;

end behv;






