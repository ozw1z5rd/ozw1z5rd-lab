library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity smallGAL is
    Port ( c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           c3 : in  STD_LOGIC;
-- --- sequential logic 			  
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC;
-- --- comb logic			  
           o1 : out  STD_LOGIC;
           o2 : out  STD_LOGIC;
           o3 : out  STD_LOGIC;
           clock : in  STD_LOGIC
	  );
end smallGAL;

architecture Behavioral of smallGAL is

	signal ss1 : STD_LOGIC;
	signal ss2 : STD_LOGIC;
	signal ss3 : STD_LOGIC;
	signal clk : STD_LOGIC;

begin

-- sincronizzata / sequenziale

	sequential : process ( c1,c2,c3, clock )
	begin 

		if (  c1 = '1' and c2 ='1' and c3 = '1' ) then 
				ss1 <= '0'; 
				ss2 <= '0';
				ss3 <= '0';
		end if;
		
		if ( clock ='1' and clock'EVENT ) then
				s2 <= c1 xor c2;
				s3 <= ss2 xor c1;
		end if;		
		
		
	end process;

-- combinatoria 

			o1 <= c1 and c2 and c3;
			o2 <= c3 and c2;
			o3 <= c1 xor c2;

end Behavioral;

