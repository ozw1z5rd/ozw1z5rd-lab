--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:50:27 11/29/2011
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/simple2/testModule.vhd
-- Project Name:  simple2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: module
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
 
ENTITY testModule IS
END testModule;
  
ARCHITECTURE behavior OF testModule IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT module
    PORT(
         i1 : IN  std_logic;
         i2 : IN  std_logic;
         i3 : IN  std_logic;
         clock : IN  std_logic;
         rst : IN  std_logic;
         o1 : OUT  std_logic;
         o2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i1 : std_logic := '0';
   signal i2 : std_logic := '0';
   signal i3 : std_logic := '0';
   signal clock : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal o1 : std_logic;
   signal o2 : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: module PORT MAP (
          i1 => i1,
          i2 => i2,
          i3 => i3,
          clock => clock,
          rst => rst,
          o1 => o1,
          o2 => o2
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
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	

      wait for clock_period*10;

			i1 <= '1'; 
			i2 <= '0';
			i3 <= '0';
			
			wait for 2000 ns;
			
			
			i1 <= '0';
			i2 <= '1'; 
			i3 <= '1';
			
			wait for 1000 ns;
			
			
			i1 <= 'Z'; 
			i2 <= '0';
			i3 <= '1';
			
			wait for 1000 ns;
			
			i1 <= 'z';
			i2 <= '1';
			i3 <= '0';
	

      wait;
   end process;

END;
