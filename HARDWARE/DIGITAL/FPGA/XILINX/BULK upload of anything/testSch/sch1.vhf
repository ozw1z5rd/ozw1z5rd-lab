--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.3
--  \   \         Application : sch2hdl
--  /   /         Filename : sch1.vhf
-- /___/   /\     Timestamp : 02/10/2012 17:54:18
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family xbr -flat -suppress -vhdl /host/Garage/Garage/home-computer-group/vhdl/testSch/sch1.vhf -w /host/Garage/Garage/home-computer-group/vhdl/testSch/sch1.sch
--Design Name: sch1
--Device: xbr
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity sch1 is
   port ( XLXN_3 : in    std_logic; 
          XLXN_4 : in    std_logic; 
          XLXN_5 : in    std_logic; 
          XLXN_6 : out   std_logic);
end sch1;

architecture BEHAVIORAL of sch1 is
   attribute BOX_TYPE   : string ;
   component AND3B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3B1 : component is "BLACK_BOX";
   
begin
   XLXI_2 : AND3B1
      port map (I0=>XLXN_5,
                I1=>XLXN_4,
                I2=>XLXN_3,
                O=>XLXN_6);
   
end BEHAVIORAL;


