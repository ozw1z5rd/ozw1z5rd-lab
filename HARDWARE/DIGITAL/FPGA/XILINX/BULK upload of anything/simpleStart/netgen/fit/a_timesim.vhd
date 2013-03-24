--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: O.76xd
--  \   \         Application: netgen
--  /   /         Filename: a_timesim.vhd
-- /___/   /\     Timestamp: Thu Nov 24 17:22:26 2011
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -rpw 100 -ar Structure -tm a -w -dir netgen/fit -ofmt vhdl -sim a.nga a_timesim.vhd 
-- Device	: XC2C128-6-VQ100 (Speed File: Version 14.0 Advance Product Specification)
-- Input file	: a.nga
-- Output file	: /home/apalma/Garage/vhdl/simpleStart/netgen/fit/a_timesim.vhd
-- # of Entities	: 1
-- Design Name	: a.nga
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

entity a is
  port (
    F : out STD_LOGIC_VECTOR ( 3 downto 0 ) 
  );
end a;

architecture Structure of a is
  signal F_0_MC_Q_1 : STD_LOGIC; 
  signal F_1_MC_Q_3 : STD_LOGIC; 
  signal F_2_MC_Q_5 : STD_LOGIC; 
  signal F_3_MC_Q_7 : STD_LOGIC; 
  signal F_0_MC_Q_tsimrenamed_net_Q_8 : STD_LOGIC; 
  signal F_0_MC_D_9 : STD_LOGIC; 
  signal F_0_MC_D1_10 : STD_LOGIC; 
  signal F_0_MC_D2_11 : STD_LOGIC; 
  signal F_1_MC_Q_tsimrenamed_net_Q_12 : STD_LOGIC; 
  signal F_1_MC_D_13 : STD_LOGIC; 
  signal F_1_MC_D1_14 : STD_LOGIC; 
  signal F_1_MC_D2_15 : STD_LOGIC; 
  signal F_2_MC_Q_tsimrenamed_net_Q_16 : STD_LOGIC; 
  signal F_2_MC_D_17 : STD_LOGIC; 
  signal F_2_MC_D1_18 : STD_LOGIC; 
  signal F_2_MC_D2_19 : STD_LOGIC; 
  signal F_3_MC_Q_tsimrenamed_net_Q_20 : STD_LOGIC; 
  signal F_3_MC_D_21 : STD_LOGIC; 
  signal F_3_MC_D1_22 : STD_LOGIC; 
  signal F_3_MC_D2_23 : STD_LOGIC; 
  signal NlwBufferSignal_F_0_MC_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_F_0_MC_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_F_1_MC_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_F_1_MC_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_F_2_MC_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_F_2_MC_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_F_3_MC_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_F_3_MC_D_IN1 : STD_LOGIC; 
begin
  F_0_Q : X_BUF
    port map (
      I => F_0_MC_Q_1,
      O => F(0)
    );
  F_1_Q : X_BUF
    port map (
      I => F_1_MC_Q_3,
      O => F(1)
    );
  F_2_Q : X_BUF
    port map (
      I => F_2_MC_Q_5,
      O => F(2)
    );
  F_3_Q : X_BUF
    port map (
      I => F_3_MC_Q_7,
      O => F(3)
    );
  F_0_MC_Q : X_BUF
    port map (
      I => F_0_MC_Q_tsimrenamed_net_Q_8,
      O => F_0_MC_Q_1
    );
  F_0_MC_Q_tsimrenamed_net_Q : X_BUF
    port map (
      I => F_0_MC_D_9,
      O => F_0_MC_Q_tsimrenamed_net_Q_8
    );
  F_0_MC_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_F_0_MC_D_IN0,
      I1 => NlwBufferSignal_F_0_MC_D_IN1,
      O => F_0_MC_D_9
    );
  F_0_MC_D1 : X_ZERO
    port map (
      O => F_0_MC_D1_10
    );
  F_0_MC_D2 : X_ZERO
    port map (
      O => F_0_MC_D2_11
    );
  F_1_MC_Q : X_BUF
    port map (
      I => F_1_MC_Q_tsimrenamed_net_Q_12,
      O => F_1_MC_Q_3
    );
  F_1_MC_Q_tsimrenamed_net_Q : X_BUF
    port map (
      I => F_1_MC_D_13,
      O => F_1_MC_Q_tsimrenamed_net_Q_12
    );
  F_1_MC_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_F_1_MC_D_IN0,
      I1 => NlwBufferSignal_F_1_MC_D_IN1,
      O => F_1_MC_D_13
    );
  F_1_MC_D1 : X_ZERO
    port map (
      O => F_1_MC_D1_14
    );
  F_1_MC_D2 : X_ZERO
    port map (
      O => F_1_MC_D2_15
    );
  F_2_MC_Q : X_BUF
    port map (
      I => F_2_MC_Q_tsimrenamed_net_Q_16,
      O => F_2_MC_Q_5
    );
  F_2_MC_Q_tsimrenamed_net_Q : X_BUF
    port map (
      I => F_2_MC_D_17,
      O => F_2_MC_Q_tsimrenamed_net_Q_16
    );
  F_2_MC_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_F_2_MC_D_IN0,
      I1 => NlwBufferSignal_F_2_MC_D_IN1,
      O => F_2_MC_D_17
    );
  F_2_MC_D1 : X_ZERO
    port map (
      O => F_2_MC_D1_18
    );
  F_2_MC_D2 : X_ZERO
    port map (
      O => F_2_MC_D2_19
    );
  F_3_MC_Q : X_BUF
    port map (
      I => F_3_MC_Q_tsimrenamed_net_Q_20,
      O => F_3_MC_Q_7
    );
  F_3_MC_Q_tsimrenamed_net_Q : X_BUF
    port map (
      I => F_3_MC_D_21,
      O => F_3_MC_Q_tsimrenamed_net_Q_20
    );
  F_3_MC_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_F_3_MC_D_IN0,
      I1 => NlwBufferSignal_F_3_MC_D_IN1,
      O => F_3_MC_D_21
    );
  F_3_MC_D1 : X_ZERO
    port map (
      O => F_3_MC_D1_22
    );
  F_3_MC_D2 : X_ZERO
    port map (
      O => F_3_MC_D2_23
    );
  NlwBufferBlock_F_0_MC_D_IN0 : X_BUF
    port map (
      I => F_0_MC_D1_10,
      O => NlwBufferSignal_F_0_MC_D_IN0
    );
  NlwBufferBlock_F_0_MC_D_IN1 : X_BUF
    port map (
      I => F_0_MC_D2_11,
      O => NlwBufferSignal_F_0_MC_D_IN1
    );
  NlwBufferBlock_F_1_MC_D_IN0 : X_BUF
    port map (
      I => F_1_MC_D1_14,
      O => NlwBufferSignal_F_1_MC_D_IN0
    );
  NlwBufferBlock_F_1_MC_D_IN1 : X_BUF
    port map (
      I => F_1_MC_D2_15,
      O => NlwBufferSignal_F_1_MC_D_IN1
    );
  NlwBufferBlock_F_2_MC_D_IN0 : X_BUF
    port map (
      I => F_2_MC_D1_18,
      O => NlwBufferSignal_F_2_MC_D_IN0
    );
  NlwBufferBlock_F_2_MC_D_IN1 : X_BUF
    port map (
      I => F_2_MC_D2_19,
      O => NlwBufferSignal_F_2_MC_D_IN1
    );
  NlwBufferBlock_F_3_MC_D_IN0 : X_BUF
    port map (
      I => F_3_MC_D1_22,
      O => NlwBufferSignal_F_3_MC_D_IN0
    );
  NlwBufferBlock_F_3_MC_D_IN1 : X_BUF
    port map (
      I => F_3_MC_D2_23,
      O => NlwBufferSignal_F_3_MC_D_IN1
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => PRLD);

end Structure;

