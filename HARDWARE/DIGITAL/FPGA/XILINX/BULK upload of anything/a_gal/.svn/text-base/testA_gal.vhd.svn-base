--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:24:35 12/01/2011
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/a_gal/testA_gal.vhd
-- Project Name:  a_gal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: a_gal
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
-- USE ieee.numeric_std.ALL;
 
ENTITY testA_gal IS
END testA_gal;
 
ARCHITECTURE behavior OF testA_gal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT a_gal
    PORT(
         A : IN  std_logic_vector(13 downto 0);
         CLOCK : IN  std_logic;
         M1 : IN  std_logic;
         mapcond : OUT  std_logic;
         mapterm : OUT  std_logic;
         ideio0 : OUT  std_logic;
         ideio1 : OUT  std_logic;
         romacc : IN  std_logic;
         automap : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(13 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal M1 : std_logic := '0';
   signal romacc : std_logic := '0';

 	--Outputs
   signal mapcond : std_logic;
   signal mapterm : std_logic;
   signal ideio0 : std_logic;
   signal ideio1 : std_logic;
   signal automap : std_logic;

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: a_gal PORT MAP (
          A => A,
          CLOCK => CLOCK,
          M1 => M1,
          mapcond => mapcond,
          mapterm => mapterm,
          ideio0 => ideio0,
          ideio1 => ideio1,
          romacc => romacc,
          automap => automap
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
	
      -- hold reset state for 100 ns.

      wait for CLOCK_period*10;

		-- stimulus 

		A <= "01000000000000";
		M1 <= '1'; 
		wait for 50 ns;

-- ideio0  = A0*A1*/A2*/A3*/A4*A5*A7
		A <= "00100011100011";
		M1 <= '0';
		wait for 50 ns;

		A <= "00000000000000";
		M1 <= '1';
		wait for 50 ns;
		
-- ideio1 = A0*A1*A5*/A6*A7
		A <= "00000010111111";
		M1 <= '0';
		wait for 50 ns;

-- mapterm on and off
      romacc <= '1';
		A <= "00000000000000";
		M1 <= '1';
		wait for 50 ns; 

      romacc <= '0';
		A <= "00000000000000";
		M1 <= '1';
		wait for 50 ns; 

		A <= "00000010100011";
		M1 <= '0';
		wait for 50 ns;
		
		A <= "11000101000000";
		M1 <= '1';
		wait for 50 ns;

   end process;
	

END;








