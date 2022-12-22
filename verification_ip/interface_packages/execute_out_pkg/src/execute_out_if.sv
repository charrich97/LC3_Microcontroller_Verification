//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the execute_out interface signals.
//      It is instantiated once per execute_out bus.  Bus Functional Models, 
//      BFM's named execute_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named execute_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(execute_out_bus.W_Control_out), // Agent input 
// .dut_signal_port(execute_out_bus.Mem_Control_out), // Agent input 
// .dut_signal_port(execute_out_bus.aluout), // Agent input 
// .dut_signal_port(execute_out_bus.pcout), // Agent input 
// .dut_signal_port(execute_out_bus.dr), // Agent input 
// .dut_signal_port(execute_out_bus.sr1), // Agent input 
// .dut_signal_port(execute_out_bus.sr2), // Agent input 
// .dut_signal_port(execute_out_bus.IR_Exec), // Agent input 
// .dut_signal_port(execute_out_bus.NZP), // Agent input 
// .dut_signal_port(execute_out_bus.M_Data), // Agent input 
// .dut_signal_port(execute_out_bus.enable_execute_status), // Agent input 

import uvmf_base_pkg_hdl::*;
import execute_out_pkg_hdl::*;

interface  execute_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [1:0] W_Control_out,
  inout tri  Mem_Control_out,
  inout tri [15:0] aluout,
  inout tri [15:0] pcout,
  inout tri [2:0] dr,
  inout tri [2:0] sr1,
  inout tri [2:0] sr2,
  inout tri [15:0] IR_Exec,
  inout tri [2:0] NZP,
  inout tri [15:0] M_Data,
  inout tri  enable_execute_status
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input W_Control_out,
  input Mem_Control_out,
  input aluout,
  input pcout,
  input dr,
  input sr1,
  input sr2,
  input IR_Exec,
  input NZP,
  input M_Data,
  input enable_execute_status
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input W_Control_out,
  input Mem_Control_out,
  input aluout,
  input pcout,
  input dr,
  input sr1,
  input sr2,
  input IR_Exec,
  input NZP,
  input M_Data,
  input enable_execute_status
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output W_Control_out,
  output Mem_Control_out,
  output aluout,
  output pcout,
  output dr,
  output sr1,
  output sr2,
  output IR_Exec,
  output NZP,
  output M_Data,
  output enable_execute_status
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

