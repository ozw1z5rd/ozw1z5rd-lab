----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity a1 is 
	port ( 
		a1_i1 : in STD_LOGIC; 
		a1_i2 : in STD_LOGIC; 
		a1_o1 : out STD_LOGIC );
end a1; 

architecture behv of a1 is
begin
	process( a1_i1, a1_i2 )
	begin
		a1_o1 <= a1_i1 and a1_i2;
	end process; 
end behv;

-- ---------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
entity a2 is 

	port ( 
		a2_i1 : in STD_LOGIC; 
		a2_i2 : in STD_LOGIC; 
		a2_o1 : out STD_LOGIC
	);
	
end a2;

architecture behv of a2 is 


begin

	process ( a2_i1, a2_i2 )
	begin
		a2_o1 <= a2_i1 or a2_i2; 
	end process; 
	
end behv; 

-- ------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity composite is
    port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           o1 : out  STD_LOGIC);
end composite;

architecture structure of composite is

-- 
-- componenti che saranno cablati all'interno della struttura di questo 
-- elemento 
-- Il comportamento è definito sopra 
--
  
	component a1 is 
	Port ( 
		a1_i1 : in STD_LOGIC; 
		a1_i2 : in STD_LOGIC; 
		a1_o1 : out STD_LOGIC 
	);
	end component; 
	
	component a2 is 
	Port ( 
		a2_i1 : in STD_LOGIC; 
		a2_i2 : in STD_LOGIC; 
		a2_o1 : out STD_LOGIC 
	);
	end component; 
	
	signal wire: STD_LOGIC; 

begin

	G1: a1 port map ( a1_i1 => i1, a1_i2 => i2, a1_o1 => wire );
	G2: a2 port map ( a2_i1 => wire, a2_i2 =>i3, a2_o1 => o1 ); 

end structure;

