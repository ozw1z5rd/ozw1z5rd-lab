--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.3
--  \   \         Application : sch2hdl
--  /   /         Filename : testISIM.vhf
-- /___/   /\     Timestamp : 11/29/2011 06:04:40
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family xbr -flat -suppress -vhdl /home/apalma/Garage/vhdl/testISIM/testISIM.vhf -w /home/apalma/Garage/vhdl/testISIM/testISIM.sch
--Design Name: testISIM
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

entity testISIM is
   port ( XLXN_1 : in    std_logic; 
          XLXN_2 : in    std_logic; 
          XLXN_3 : in    std_logic; 
          XLXN_4 : out   std_logic);
end testISIM;

architecture BEHAVIORAL of testISIM is
   attribute BOX_TYPE   : string ;
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND3
      port map (I0=>XLXN_3,
                I1=>XLXN_2,
                I2=>XLXN_1,
                O=>XLXN_4);
   
end BEHAVIORAL;


