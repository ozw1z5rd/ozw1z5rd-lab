-- Vhdl test bench created from schematic /host/Garage/Garage/home-computer-group/vhdl/testSch/sch1.sch - Fri Feb 10 17:56:02 2012
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY sch1_sch1_sch_tb IS
END sch1_sch1_sch_tb;
ARCHITECTURE behavioral OF sch1_sch1_sch_tb IS 

   COMPONENT sch1
   PORT( XLXN_3	:	IN	STD_LOGIC; 
          XLXN_4	:	IN	STD_LOGIC; 
          XLXN_5	:	IN	STD_LOGIC; 
          XLXN_6	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL XLXN_3	:	STD_LOGIC;
   SIGNAL XLXN_4	:	STD_LOGIC;
   SIGNAL XLXN_5	:	STD_LOGIC;
   SIGNAL XLXN_6	:	STD_LOGIC;

BEGIN

   UUT: sch1 PORT MAP(
		XLXN_3 => XLXN_3, 
		XLXN_4 => XLXN_4, 
		XLXN_5 => XLXN_5, 
		XLXN_6 => XLXN_6
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
	
	   XLXN_3 <= '0';
		XLXN_4 <= '0';
		XLXN_5 <= '0';
		wait for 10 ns;
		
	   XLXN_3 <= '0';
		XLXN_4 <= '0';
		XLXN_5 <= '1';
		wait for 15 ns;

	   XLXN_3 <= '0';
		XLXN_4 <= '1';
		XLXN_5 <= '0';
		wait for 17 ns;

	   XLXN_3 <= '0';
		XLXN_4 <= '1';
		XLXN_5 <= '1';
		wait for 19 ns;

	   XLXN_3 <= '1';
		XLXN_4 <= '0';
		XLXN_5 <= '0';
		wait for 22 ns;

	   XLXN_3 <= '1';
		XLXN_4 <= '0';
		XLXN_5 <= '1';
		wait for 25 ns;
		
		
		

	
	
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
