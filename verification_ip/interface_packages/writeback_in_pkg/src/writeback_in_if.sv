//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the writeback_in interface signals.
//      It is instantiated once per writeback_in bus.  Bus Functional Models, 
//      BFM's named writeback_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named writeback_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(writeback_in_bus.enable_writeback), // Agent output 
// .dut_signal_port(writeback_in_bus.aluout), // Agent output 
// .dut_signal_port(writeback_in_bus.memout), // Agent output 
// .dut_signal_port(writeback_in_bus.sr1), // Agent output 
// .dut_signal_port(writeback_in_bus.sr2), // Agent output 
// .dut_signal_port(writeback_in_bus.dr), // Agent output 
// .dut_signal_port(writeback_in_bus.npc), // Agent output 
// .dut_signal_port(writeback_in_bus.pcout), // Agent output 
// .dut_signal_port(writeback_in_bus.W_control), // Agent output 

import uvmf_base_pkg_hdl::*;
import writeback_in_pkg_hdl::*;

interface  writeback_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  enable_writeback,
  inout tri [15:0] aluout,
  inout tri [15:0] memout,
  inout tri [2:0] sr1,
  inout tri [2:0] sr2,
  inout tri [2:0] dr,
  inout tri [15:0] npc,
  inout tri [15:0] pcout,
  inout tri [1:0] W_control
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input enable_writeback,
  input aluout,
  input memout,
  input sr1,
  input sr2,
  input dr,
  input npc,
  input pcout,
  input W_control
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output enable_writeback,
  output aluout,
  output memout,
  output sr1,
  output sr2,
  output dr,
  output npc,
  output pcout,
  output W_control
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input enable_writeback,
  input aluout,
  input memout,
  input sr1,
  input sr2,
  input dr,
  input npc,
  input pcout,
  input W_control
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

