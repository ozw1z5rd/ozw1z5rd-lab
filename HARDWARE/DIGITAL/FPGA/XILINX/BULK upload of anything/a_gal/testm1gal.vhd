--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:18:36 12/06/2011
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/a_gal/testm1gal.vhd
-- Project Name:  a_gal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: m1_gal
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
 
ENTITY testm1gal IS
END testm1gal;
 
ARCHITECTURE behavior OF testm1gal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT m1_gal
    PORT(
         mgalclk : OUT  std_logic;
         rgalclk : OUT  std_logic;
         A15 : IN  std_logic;
         A14 : IN  std_logic;
         A13 : IN  std_logic;
         ideio0 : IN  std_logic;
         ideio1 : IN  std_logic;
         NOT_WR : IN  std_logic;
         NOT_RD : IN  std_logic;
         conmem : IN  std_logic;
         NOT_eprom : IN  std_logic;
         NOT_loe : OUT  std_logic;
         NOT_doe : OUT  std_logic;
         NOT_hdwr : OUT  std_logic;
         NOT_hdrd : OUT  std_logic;
         romacc : OUT  std_logic;
         lclk : OUT  std_logic;
         evenodd : OUT  std_logic;
         NOT_romwr : OUT  std_logic;
         CLOCK : IN  std_logic;
         NOT_IORQ : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A15 : std_logic := '0';
   signal A14 : std_logic := '0';
   signal A13 : std_logic := '0';
   signal ideio0 : std_logic := '0';
   signal ideio1 : std_logic := '0';
   signal NOT_WR : std_logic := '0';
   signal NOT_RD : std_logic := '0';
   signal conmem : std_logic := '0';
   signal NOT_eprom : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal NOT_IORQ : std_logic := '0';

 	--Outputs
   signal mgalclk : std_logic;
   signal rgalclk : std_logic;
   signal NOT_loe : std_logic;
   signal NOT_doe : std_logic;
   signal NOT_hdwr : std_logic;
   signal NOT_hdrd : std_logic;
   signal romacc : std_logic;
   signal lclk : std_logic;
   signal evenodd : std_logic;
   signal NOT_romwr : std_logic;

   -- Clock period definitions
   constant mgalclk_period : time := 10 ns;
   constant rgalclk_period : time := 10 ns;
   constant lclk_period : time := 10 ns;
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: m1_gal PORT MAP (
          mgalclk => mgalclk,
          rgalclk => rgalclk,
          A15 => A15,
          A14 => A14,
          A13 => A13,
          ideio0 => ideio0,
          ideio1 => ideio1,
          NOT_WR => NOT_WR,
          NOT_RD => NOT_RD,
          conmem => conmem,
          NOT_eprom => NOT_eprom,
          NOT_loe => NOT_loe,
          NOT_doe => NOT_doe,
          NOT_hdwr => NOT_hdwr,
          NOT_hdrd => NOT_hdrd,
          romacc => romacc,
          lclk => lclk,
          evenodd => evenodd,
          NOT_romwr => NOT_romwr,
          CLOCK => CLOCK,
          NOT_IORQ => NOT_IORQ
        );

   -- Clock process definitions
--   mgalclk_process :process
--   begin
--		mgalclk <= '0';
--		wait for mgalclk_period/2;
--		mgalclk <= '1';
--		wait for mgalclk_period/2;
--   end process;
 
--   rgalclk_process :process
--   begin
--		rgalclk <= '0';
--		wait for rgalclk_period/2;
--		rgalclk <= '1';
--		wait for rgalclk_period/2;
--   end process;
 
--   lclk_process :process
--   begin
--		lclk <= '0';
--		wait for lclk_period/2;
--		lclk <= '1';
--		wait for lclk_period/2;
--   end process;
 
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
		
		ideio0 <= '0';
		ideio1 <= '0';

		NOT_WR <='0';
      NOT_RD <='0';
      conmem <= '0';
      NOT_eprom <= '0';
		NOT_IORQ <= '0';
		NOT_hdwr <= '0';
		NOT_hdrd <= '0';
		
      wait for 100 ns;	

      --wait for mgalclk_period*10;

      -- insert stimulus here 

-- check ROMACC 

			A14 <= '0';
			A15 <= '0';

			wait for 100 ns;
			
--- check romwr 

			A13 <= '1';
			A14 <= '1';
			A15 <= '1';
			NOT_WR <= '1';
			NOT_eprom <='1'; -- check
			conmem <= '1';
				

   end process;

END;
