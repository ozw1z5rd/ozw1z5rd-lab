LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY testSmallGal IS
END testSmallGal;
 
ARCHITECTURE behavior OF testSmallGal IS 
 
    COMPONENT smallGAL
    PORT(
         c1 : IN  std_logic;
         c2 : IN  std_logic;
         c3 : IN  std_logic;
         s1 : OUT  std_logic;
         s2 : OUT  std_logic;
         s3 : OUT  std_logic;
         o1 : OUT  std_logic;
         o2 : OUT  std_logic;
         o3 : OUT  std_logic;
         clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal c1 : std_logic := '0';
   signal c2 : std_logic := '0';
   signal c3 : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal s1 : std_logic;
   signal s2 : std_logic;
   signal s3 : std_logic;
   signal o1 : std_logic;
   signal o2 : std_logic;
   signal o3 : std_logic;

   -- Clock period definitions
   constant clock_period : time :=10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: smallGAL PORT MAP (
          c1 => c1,
          c2 => c2,
          c3 => c3,
          s1 => s1,
          s2 => s2,
          s3 => s3,
          o1 => o1,
          o2 => o2,
          o3 => o3,
          clock => clock
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for'1'00 ns.
		c1 <='1'; 
		c2 <='1'; 
		c3 <='1'; 
		
      wait for 100 ns;	

		c1 <='0'; 
		c2 <='0'; 
		c3 <='0'; 
		
      wait for 20 ns;	

		c1 <='0'; 
		c2 <='0'; 
		c3 <='1'; 
		
      wait for 20 ns;	
				c1 <='0'; 
		c2 <='1'; 
		c3 <='0'; 
		
      wait for 20 ns;	
				c1 <='0'; 
		c2 <='1'; 
		c3 <='1'; 
		
      wait for 20 ns;	
				c1 <='1'; 
		c2 <='0'; 
		c3 <='0'; 
		
      wait for 20 ns;	
				c1 <='1'; 
		c2 <='0'; 
		c3 <='1'; 
		
      wait for 20 ns;	
				c1 <='1'; 
		c2 <='1'; 
		c3 <='0'; 
		
      wait for 20 ns;	

      -- insert stimulus here 

   end process;

END;
