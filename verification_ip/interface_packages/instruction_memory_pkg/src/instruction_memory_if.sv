//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the instruction_memory interface signals.
//      It is instantiated once per instruction_memory bus.  Bus Functional Models, 
//      BFM's named instruction_memory_driver_bfm, are used to drive signals on the bus.
//      BFM's named instruction_memory_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(instruction_memory_bus.Instr_dout), // Agent input 
// .dut_signal_port(instruction_memory_bus.complete_instr), // Agent input 
// .dut_signal_port(instruction_memory_bus.instrmem_rd), // Agent output 
// .dut_signal_port(instruction_memory_bus.PC), // Agent output 
// .dut_signal_port(instruction_memory_bus.I_macc), // Agent output 

import uvmf_base_pkg_hdl::*;
import instruction_memory_pkg_hdl::*;

interface  instruction_memory_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] Instr_dout,
  inout tri  complete_instr,
  inout tri  instrmem_rd,
  inout tri [15:0] PC,
  inout tri  I_macc
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input Instr_dout,
  input complete_instr,
  input instrmem_rd,
  input PC,
  input I_macc
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input Instr_dout,
  input complete_instr,
  output instrmem_rd,
  output PC,
  output I_macc
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output Instr_dout,
  output complete_instr,
  input instrmem_rd,
  input PC,
  input I_macc
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

