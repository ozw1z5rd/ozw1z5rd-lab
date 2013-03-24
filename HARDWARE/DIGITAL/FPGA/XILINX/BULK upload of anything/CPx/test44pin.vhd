--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:01:19 01/30/2012
-- Design Name:   
-- Module Name:   /host/Garage/Garage/home-computer-group/vhdl/CPx/test44pin.vhd
-- Project Name:  CPx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPx2
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test44pin IS
END test44pin;
 
ARCHITECTURE behavior OF test44pin IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPx2
    PORT(
         A : IN  std_logic_vector(13 downto 0);
         D : INOUT  std_logic_vector(7 downto 0);
         JUMPER_EEPROM : IN  std_logic;
         CLOCK : IN  std_logic;
         N_MREQ : IN  std_logic;
         N_RD : IN  std_logic;
         N_WR : IN  std_logic;
         N_M1 : IN  std_logic;
         N_ROMCS : BUFFER  std_logic;
         N_SRAMCS : BUFFER  std_logic;
         N_SRAMOE : OUT  std_logic;
         N_SRAMWR : OUT  std_logic;
         BANK : OUT  std_logic_vector(4 downto 0);
         N_EEPROMWR : OUT  std_logic;
         N_EEPROMOE : OUT  std_logic;
         N_EEPROMCS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(13 downto 0) := (others => '0');
   signal JUMPER_EEPROM : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal N_MREQ : std_logic := '1';
   signal N_RD : std_logic := '1';
   signal N_WR : std_logic := '1';
   signal N_M1 : std_logic := '1';

	--BiDirs
   signal D : std_logic_vector(7 downto 0);

 	--Outputs
   signal N_ROMCS : std_logic;
   signal N_SRAMCS : std_logic;
   signal N_SRAMOE : std_logic;
   signal N_SRAMWR : std_logic;
   signal BANK : std_logic_vector(4 downto 0);
   signal N_EEPROMWR : std_logic;
   signal N_EEPROMOE : std_logic;
   signal N_EEPROMCS : std_logic;

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPx2 PORT MAP (
          A => A,
          D => D,
          JUMPER_EEPROM => JUMPER_EEPROM,
          CLOCK => CLOCK,
          N_MREQ => N_MREQ,
          N_RD => N_RD,
          N_WR => N_WR,
          N_M1 => N_M1,
          N_ROMCS => N_ROMCS,
          N_SRAMCS => N_SRAMCS,
          N_SRAMOE => N_SRAMOE,
          N_SRAMWR => N_SRAMWR,
          BANK => BANK,
          N_EEPROMWR => N_EEPROMWR,
          N_EEPROMOE => N_EEPROMOE,
          N_EEPROMCS => N_EEPROMCS
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
--
-- READ 
-- RANDOM ACCESS  ----------------------------------------- ( 1 )
--			
--                                                           SUCCESS IS : CONMEM IS NOT ACTIVATED
	A <= "01010101010000"; 
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';

   WAIT FOR 30 NS;

-- STANDARD Z80 FETCH CYCLE.
-- READ 
-- RANDOM ACCESS  ----------------------------------------- ( 2 )
--			
--                                                           SUCCESS IS : CONMEM IS * ACTIVATED *
	A <= "00000000000000";   -- 0000
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_MREQ <= '1';
	N_M1 <= '1';

-- CONMEM IS TRUE

--
-- RANDOM ACCESS  PAGE 1 ( SRAM CONMEM SET TO TRUE )
--	SRAM ACCESS => A(13) AND A(12) 
--       12    7      0
--        |    |      |
	A <= "11000000001111";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
		
		





	







-- 
-- READ CICLE WITH CONMEM ENABLED.
--
--                                                  ( write )
   WAIT FOR 100 NS;
	A <= "00000000110010"; -- 1FF8
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END WR CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
	




-- READ 
-- RANDOM ACCESS  ----------------------------------------- ( 3 )
--			
--                                                           SUCCESS IS : CONMEM IS STILL ACTIVATED



	A <= "01010101010111"; 
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';



	
	A <= "00000000001000"; -- 0008
	WAIT FOR 10 NS;
	A <= "00000000111000"; -- 0038
	WAIT FOR 10 NS;
	A <= "00000001100110"; -- 0066
	WAIT FOR 10 NS;
	A <= "00010011000110"; -- 04c6
	WAIT FOR 10 NS;
	A <= "00010101100010"; -- 0562
	WAIT FOR 10 NS;
	
	
--			
-- read 
-- RANDOM ACCESS  ----------------------------------------- ( 4 )
--			
--                                                           SUCCESS IS 
--                                                           CONMEM GOES OFF

	A <= "01111111111000"; -- 1FF8
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
	

-- ### WRITE CILCLE INTO THE RAM ADDRESS : ROMCS OFF 
--     
--
--
   WAIT FOR 100 NS;
	A <= "01111111111000"; -- 1FF8
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END WR CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
	




--
-- RANDOM ACCESS 
--			

	A <= "01010101010111"; 
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';


	
	
	A <= "01111111111111"; -- 1FFF
		
--
-- RANDOM ACCESS 
--			
--       12    7      0
--        |    |      |
	A <= "10000000000001";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';

		
--
-- RANDOM ACCESS 
--			
--       12    7      0
--        |    |      |
	A <= "00000000010101";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_RD <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_RD <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
		
		
		
	WAIT FOR 100 NS;
	
-- CONMEM IS OFF 	
		
--
-- RANDOM ACCESS  PAGE 1 ( SRAM CONMEM SET TO TRUE )
--	SRAM ACCESS => A(13) AND A(12) 
--       12    7      0
--        |    |      |
	A <= "11000000001111";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
		
		

    WAIT FOR 100 NS;

--
-- ACCESSING OUT OF PAGE 1,2  ( WRITE CYCLE )
-- SRAM OFF
-- EEPROM OFF 
--
--	SRAM ACCESS => A(13) AND A(12) 
--       12    7      0
--        |    |      |
	A <= "11000000001111";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';


   WAIT FOR 100 NS;
	
--
-- ACCESSING IN PAGE 2  ( WRITE CYCLE )
-- SRAM ON
-- EEPROM OFF 
--
--	SRAM PAGE 1 => ACCESS => NOT A(13) AND A(12) 
--       12    7      0
--        |    |      |
	A <= "01000000001111";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
	
	WAIT FOR 100 NS;
	
--
-- ACCESSING IN PAGE 1  ( WRITE CYCLE )
-- SRAM OFF
-- EEPROM ON 
--
--	EEPROM PAGE 1 => ACCESS => NOT A(13) AND NOT A(12) 
--       12    7      0
--        |    |      |
	A <= "00000000001111";   -- OUT OFROM ADDRESS SPACE
	N_M1 <= '0';             -- FETCH CYCLE
	WAIT FOR CLOCK_period/2; -- 1/2 CLOCK LATER
	N_MREQ <= '0';           -- N_MREQ IS ACTIVATED
	WAIT FOR 5 NS;           -- 
	N_WR <= '0';             -- AFTER N_MREQ GOES LOW N_RD
	WAIT FOR CLOCK_period;   -- 1 FULL CLOCK CYCLE
	WAIT FOR 5 NS;           -- GATES DELAY
	N_WR <= '1';             -- END RD CYCLE
	N_M1 <= '1';
	N_MREQ <= '1';
		
		
		
		
		
		
		
		
		
		
		
		
      wait for 10 ns;
   end process;

END;
