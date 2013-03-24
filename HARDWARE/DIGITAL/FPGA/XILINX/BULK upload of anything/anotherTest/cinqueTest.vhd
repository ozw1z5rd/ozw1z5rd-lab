--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:06:21 11/29/2011
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/anotherTest/cinqueTest.vhd
-- Project Name:  anotherTest
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cinque
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
 
--
--  il simulatore ha un fattore di zoom eccessivo per ptoer vedere le forme 
--  d'onda. zoom out fino alla visualizzazione.
--
 
 
ENTITY cinqueTest IS
END cinqueTest;
 
ARCHITECTURE behavior OF cinqueTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cinque
    PORT(
         i1 : IN  std_logic;
         i2 : IN  std_logic;
         i3 : IN  std_logic;
         clock: IN  std_logic;
         o1 : OUT  std_logic;
         o2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i1 : std_logic := '0';
   signal i2 : std_logic := '0';
   signal i3 : std_logic := '0';
   signal tclock : std_logic := '1';

 	--Outputs
   signal o1 : std_logic;
	signal o2 : STD_LOGIC;
   -- No clocks detected in port list. Replace clock below with 
   -- appropriate port name 
 
   constant tclock_period : time := 30 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cinque PORT MAP (
          i1 => i1,
          i2 => i2,
			 i3 => i3,
          o1 => o1,
			 o2 => o2,
			 clock => tclock
        );

   -- Clock process definitions
   tclock_process :process
   begin
		tclock <= '0';
		wait for 10ns;
		tclock <= '1';
		wait for 10ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

		i1 <= '0'; 
		i2 <= '0'; 
		i3 <= '1'; 
		wait for 20ns; 
		
		i1 <= '1'; 
		i2 <= '0'; 
		i3 <= '0';
		wait for 20 ns; 
		
		i1 <= '0'; 
		i2 <= '1'; 
		i3 <= '0';
		wait for 20 ns; 
		
		i1 <= '1'; 
		i2 <= '1'; 
		i3 <= '1';
		wait for 20 ns; 

   end process;

END;
