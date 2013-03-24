--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: O.76xd
--  \   \         Application: netgen
--  /   /         Filename: testISIM_timesim.vhd
-- /___/   /\     Timestamp: Tue Nov 29 06:05:58 2011
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -rpw 100 -ar Structure -tm testISIM -w -dir netgen/fit -ofmt vhdl -sim testISIM.nga testISIM_timesim.vhd 
-- Device	: XC2C128-6-VQ100 (Speed File: Version 14.0 Advance Product Specification)
-- Input file	: testISIM.nga
-- Output file	: /home/apalma/Garage/vhdl/testISIM/netgen/fit/testISIM_timesim.vhd
-- # of Entities	: 1
-- Design Name	: testISIM.nga
-- Xilinx	: /host/Xilinx/13.3/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity testISIM is
  port (
    XLXN_1 : in STD_LOGIC := 'X'; 
    XLXN_2 : in STD_LOGIC := 'X'; 
    XLXN_3 : in STD_LOGIC := 'X'; 
    XLXN_4 : out STD_LOGIC 
  );
end testISIM;

architecture Structure of testISIM is
  signal XLXN_1_II_UIM_1 : STD_LOGIC; 
  signal XLXN_2_II_UIM_3 : STD_LOGIC; 
  signal XLXN_3_II_UIM_5 : STD_LOGIC; 
  signal XLXN_4_MC_Q_7 : STD_LOGIC; 
  signal XLXN_4_MC_Q_tsimrenamed_net_Q_8 : STD_LOGIC; 
  signal XLXN_4_MC_D_9 : STD_LOGIC; 
  signal XLXN_4_MC_D1_10 : STD_LOGIC; 
  signal XLXN_4_MC_D2_11 : STD_LOGIC; 
  signal NlwBufferSignal_XLXN_4_MC_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_XLXN_4_MC_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_XLXN_4_MC_D1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_XLXN_4_MC_D1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_XLXN_4_MC_D1_IN2 : STD_LOGIC; 
begin
  XLXN_1_II_UIM : X_BUF
    port map (
      I => XLXN_1,
      O => XLXN_1_II_UIM_1
    );
  XLXN_2_II_UIM : X_BUF
    port map (
      I => XLXN_2,
      O => XLXN_2_II_UIM_3
    );
  XLXN_3_II_UIM : X_BUF
    port map (
      I => XLXN_3,
      O => XLXN_3_II_UIM_5
    );
  XLXN_4_8 : X_BUF
    port map (
      I => XLXN_4_MC_Q_7,
      O => XLXN_4
    );
  XLXN_4_MC_Q : X_BUF
    port map (
      I => XLXN_4_MC_Q_tsimrenamed_net_Q_8,
      O => XLXN_4_MC_Q_7
    );
  XLXN_4_MC_Q_tsimrenamed_net_Q : X_BUF
    port map (
      I => XLXN_4_MC_D_9,
      O => XLXN_4_MC_Q_tsimrenamed_net_Q_8
    );
  XLXN_4_MC_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_XLXN_4_MC_D_IN0,
      I1 => NlwBufferSignal_XLXN_4_MC_D_IN1,
      O => XLXN_4_MC_D_9
    );
  XLXN_4_MC_D1 : X_AND3
    port map (
      I0 => NlwBufferSignal_XLXN_4_MC_D1_IN0,
      I1 => NlwBufferSignal_XLXN_4_MC_D1_IN1,
      I2 => NlwBufferSignal_XLXN_4_MC_D1_IN2,
      O => XLXN_4_MC_D1_10
    );
  XLXN_4_MC_D2 : X_ZERO
    port map (
      O => XLXN_4_MC_D2_11
    );
  NlwBufferBlock_XLXN_4_MC_D_IN0 : X_BUF
    port map (
      I => XLXN_4_MC_D1_10,
      O => NlwBufferSignal_XLXN_4_MC_D_IN0
    );
  NlwBufferBlock_XLXN_4_MC_D_IN1 : X_BUF
    port map (
      I => XLXN_4_MC_D2_11,
      O => NlwBufferSignal_XLXN_4_MC_D_IN1
    );
  NlwBufferBlock_XLXN_4_MC_D1_IN0 : X_BUF
    port map (
      I => XLXN_1_II_UIM_1,
      O => NlwBufferSignal_XLXN_4_MC_D1_IN0
    );
  NlwBufferBlock_XLXN_4_MC_D1_IN1 : X_BUF
    port map (
      I => XLXN_2_II_UIM_3,
      O => NlwBufferSignal_XLXN_4_MC_D1_IN1
    );
  NlwBufferBlock_XLXN_4_MC_D1_IN2 : X_BUF
    port map (
      I => XLXN_3_II_UIM_5,
      O => NlwBufferSignal_XLXN_4_MC_D1_IN2
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => PRLD);

end Structure;

