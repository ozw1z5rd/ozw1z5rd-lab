--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:55 12/07/2011
-- Design Name:   
-- Module Name:   /home/apalma/Garage/vhdl/a_gal/testrgal.vhd
-- Project Name:  a_gal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: r_gal2
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
 
ENTITY testrgal IS
END testrgal;
 
ARCHITECTURE behavior OF testrgal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT r_gal2
    PORT(
         D : IN  std_logic_vector(7 downto 0);
         NOT_WR : IN  std_logic;
         romacc : IN  std_logic;
         NOT_RD : IN  std_logic;
         automap : IN  std_logic;
         RESET : IN  std_logic;
         A13 : IN  std_logic;
         NOT_eprom : IN  std_logic;
         romoff : OUT  std_logic;
         NOT_romoe : OUT  std_logic;
         conmem : OUT  std_logic;
         bank0 : OUT  std_logic;
         bank1 : OUT  std_logic;
         NOT_ramoe : OUT  std_logic;
         addr1 : OUT  std_logic;
         addr0 : OUT  std_logic;
         NOT_ramwr : OUT  std_logic;
         CLOCK : IN  std_logic;
         mapram : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(7 downto 0) := (others => '0');
   signal NOT_WR : std_logic := '0';
   signal romacc : std_logic := '0';
   signal NOT_RD : std_logic := '0';
   signal automap : std_logic := '1';
   signal RESET : std_logic := '0';
   signal A13 : std_logic := '0';
   signal NOT_eprom : std_logic := '1';
   signal CLOCK : std_logic := '0';

 	--Outputs
   signal romoff : std_logic;
   signal NOT_romoe : std_logic;
   signal conmem : std_logic;
   signal bank0 : std_logic;
   signal bank1 : std_logic;
   signal NOT_ramoe : std_logic;
   signal addr1 : std_logic;
   signal addr0 : std_logic;
   signal NOT_ramwr : std_logic;
   signal mapram : std_logic;

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: r_gal2 PORT MAP (
          D => D,
          NOT_WR => NOT_WR,
          romacc => romacc,
          NOT_RD => NOT_RD,
          automap => automap,
          RESET => RESET,
          A13 => A13,
          NOT_eprom => NOT_eprom,
          romoff => romoff,
          NOT_romoe => NOT_romoe,
          conmem => conmem,
          bank0 => bank0,
          bank1 => bank1,
          NOT_ramoe => NOT_ramoe,
          addr1 => addr1,
          addr0 => addr0,
          NOT_ramwr => NOT_ramwr,
          CLOCK => CLOCK,
          mapram => mapram
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

-- init signs.

   NOT_WR <= '0';
   romacc <= '0';
    NOT_RD <= '0';
    automap <= '1';
    RESET <= '0';
    A13 <= '1';
	 D(0) <= '0';
	 D(1) <= '1';
    NOT_eprom <= '1';
    CLOCK <= '0';
	 sig_mapram <= '1';
	 sig_conmem <= '1';
	sig_addr0 <= '1';
	sig_addr1 <= '1';

	wait for 100 ns; 


		D(0) <= '1';
		d(1) <= '1';
      wait for 20 ns;
		
		D(0) <= '0';
		d(1) <= '1';
      wait for 20 ns;

		D(0) <= '1';
		d(1) <= '0';
      wait for 20 ns;

		D(0) <= '0';
		d(1) <= '0';
      wait for 20 ns;
   end process;

END;
