--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:12:48 01/24/2012
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/CPx/CPx2uu.vhd
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
 
ENTITY CPx2uu IS
END CPx2uu;
 
ARCHITECTURE behavior OF CPx2uu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPx2
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         D : INOUT  std_logic_vector(7 downto 0);
         JUMPER_COMP_MODE : IN  std_logic;
         JUMPER_EEPROM : IN  std_logic;
         RESET : IN  std_logic;
         CLOCK : IN  std_logic;
         N_IOREQ : IN  std_logic;
         N_MREQ : IN  std_logic;
         N_RD : IN  std_logic;
         N_WR : IN  std_logic;
         N_M1 : IN  std_logic;
         N_ROMCS : OUT  std_logic;
         N_IORQEGDE : OUT  std_logic;
         N_NMI : IN  std_logic;
         NMI : OUT  std_logic;
         N_INT : IN  std_logic;
         INT : OUT  std_logic;
         N_SRAMEN : OUT  std_logic;
         N_SRAMOE : OUT  std_logic;
         N_SRAMWR : OUT  std_logic;
         N_SRAMCS : OUT  std_logic;
         BANK : OUT  std_logic_vector(5 downto 0);
         N_EEPROMWR : OUT  std_logic;
         N_EEPROMOE : OUT  std_logic;
         N_EEPROMEN : OUT  std_logic;
         N_EEPROMCS : OUT  std_logic;
         MAPRAM : OUT  std_logic;
         CONMEM : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal AU : std_logic_vector(15 downto 0) := (others => '0');
   signal JUMPER_COMP_MODE : std_logic := '0';
   signal JUMPER_EEPROM : std_logic := '0';
   signal RESET : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal N_IOREQ : std_logic := '0';
   signal N_MREQ : std_logic := '0';
   signal N_RD : std_logic := '0';
   signal N_WR : std_logic := '0';
   signal N_M1 : std_logic := '0';
   signal N_NMI : std_logic := '0';
   signal N_INT : std_logic := '0';

	--BiDirs
   signal D : std_logic_vector(7 downto 0);

 	--Outputs
   signal N_ROMCS : std_logic;
   signal N_IORQEGDE : std_logic;
   signal NMI : std_logic;
   signal INT : std_logic;
   signal N_SRAMEN : std_logic;
   signal N_SRAMOE : std_logic;
   signal N_SRAMWR : std_logic;
   signal N_SRAMCS : std_logic;
   signal BANK : std_logic_vector(5 downto 0);
   signal N_EEPROMWR : std_logic;
   signal N_EEPROMOE : std_logic;
   signal N_EEPROMEN : std_logic;
   signal N_EEPROMCS : std_logic;
   signal MAPRAM : std_logic;
   signal CONMEM : std_logic;


   -- Clock period definitions
   constant CLOCK_period : time := 140 ns; -- ABOUT 3.5 MHZ 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPx2 PORT MAP (
          AU => A,
          D => D,
          JUMPER_COMP_MODE => JUMPER_COMP_MODE,
          JUMPER_EEPROM => JUMPER_EEPROM,
          RESET => RESET,
          CLOCK => CLOCK,
          N_IOREQ => N_IOREQ,
          N_MREQ => N_MREQ,
          N_RD => N_RD,
          N_WR => N_WR,
          N_M1 => N_M1,
          N_ROMCS => N_ROMCS,
          N_IORQEGDE => N_IORQEGDE,
          N_NMI => N_NMI,
          NMI => NMI,
          N_INT => N_INT,
          INT => INT,
          N_SRAMEN => N_SRAMEN,
          N_SRAMOE => N_SRAMOE,
          N_SRAMWR => N_SRAMWR,
          N_SRAMCS => N_SRAMCS,
          BANK => BANK,
          N_EEPROMWR => N_EEPROMWR,
          N_EEPROMOE => N_EEPROMOE,
          N_EEPROMEN => N_EEPROMEN,
          N_EEPROMCS => N_EEPROMCS,
          MAPRAM => MAPRAM,
          CONMEM => CONMEM
        );


	JUMPER_COMP_MODE <= '0';
	JUMPER_EEPROM <= '0';

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
	
	   RESET <= '1';
      -- hold reset state for 100 ns.
      wait for 200 ns;	
      RESET <= '0';
		
      wait for CLOCK_period*10;

      AU(0) <= '0';
      AU(1) <= '0';
      AU(2) <= '0';
      AU(3) <= '0';
      AU(4) <= '0';
      AU(5) <= '0';
      AU(6) <= '0';
      AU(7) <= '0';
      AU(8) <= '0';
      AU(9) <= '0';
      AU(10) <= '0';
      
-- INIT	
	
	
	
	-- insert stimulus here 

  
   WAIT FOR 20000 US;
  
  
   end process;
	
	

END;
