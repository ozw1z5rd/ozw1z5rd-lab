--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:23 01/25/2012
-- Design Name:   
-- Module Name:   /host/Garage/Garage/vhdl/CPx/CPX2T.vhd
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
 
ENTITY CPX2T IS
END CPX2T;
 
ARCHITECTURE behavior OF CPX2T IS 
 
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
         N_ROMCS : buffer std_logic;
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
         MAPRAM : buffer  std_logic;
         CONMEM : buffer  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
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
   constant CLOCK_period : time := 140 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPx2 PORT MAP (
          A => A,
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
      -- hold reset state for 100 ns;
		A <= "0000000000000000";
		WAIT FOR 20 NS;
		
		A <= "0000000000001000";
		WAIT FOR 20 NS;

		A <= "0000000000111000";
		WAIT FOR 20 NS;		
		
		A <= "0000000000000000";
		WAIT FOR 20 NS;

-- RAM ACCESS 
--	
-- pg 34 
--
-- READ CICLE
--
   N_MREQ <= '1';
	N_WR <= '1';
	A <= X"0066"; -- ENTRY POINT 
	WAIT FOR 142 NS;
	N_RD <= '0';
	N_MREQ <= '0';
	WAIT FOR 568 NS;
	N_RD <= '1';
	N_MREQ <= '1';
	WAIT FOR 2000 NS;
--
-- WRITE CICLE
--	
   N_MREQ <= '1';
	N_WR <= '1';
	N_RD <= '1';
	A <= X"0066"; -- ENTRY POINT 
	WAIT FOR 248 NS;
	N_WR <= '0';
	N_MREQ <= '0';
	D <= X"FF";
	WAIT FOR 248 NS;
	N_WR <= '1';
	N_MREQ <= '1';	
	WAIT FOR 142 NS; 
	D <= "ZZZZZZZZ";	
	WAIT FOR 2000 NS;
--	
-- ROM ACCESS 
--	
			
		
		
		
      wait FOR 20000 ns;
   end process;

END;
