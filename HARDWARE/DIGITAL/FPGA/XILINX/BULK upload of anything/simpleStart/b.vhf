--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.3
--  \   \         Application : sch2hdl
--  /   /         Filename : b.vhf
-- /___/   /\     Timestamp : 11/25/2011 05:59:49
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family xbr -flat -suppress -vhdl /home/apalma/Garage/vhdl/simpleStart/b.vhf -w /home/apalma/Garage/vhdl/simpleStart/b.sch
--Design Name: b
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

entity b is
   port ( XLXN_4 : in    std_logic; 
          XLXN_5 : in    std_logic; 
          XLXN_6 : in    std_logic; 
          XLXN_8 : in    std_logic; 
          XLXN_9 : out   std_logic);
end b;

architecture BEHAVIORAL of b is
   attribute BOX_TYPE   : string ;
   signal XLXN_2 : std_logic;
   signal XLXN_7 : std_logic;
   component AND2B1
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2B1 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2B1
      port map (I0=>XLXN_8,
                I1=>XLXN_4,
                O=>XLXN_7);
   
   XLXI_2 : AND2B1
      port map (I0=>XLXN_5,
                I1=>XLXN_7,
                O=>XLXN_2);
   
   XLXI_3 : AND2B1
      port map (I0=>XLXN_6,
                I1=>XLXN_2,
                O=>XLXN_9);
   
end BEHAVIORAL;


