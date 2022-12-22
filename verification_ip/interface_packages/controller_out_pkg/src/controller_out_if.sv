//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the controller_out interface signals.
//      It is instantiated once per controller_out bus.  Bus Functional Models, 
//      BFM's named controller_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named controller_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(controller_out_bus.enable_updatePC), // Agent input 
// .dut_signal_port(controller_out_bus.enable_fetch), // Agent input 
// .dut_signal_port(controller_out_bus.enable_decode), // Agent input 
// .dut_signal_port(controller_out_bus.enable_execute), // Agent input 
// .dut_signal_port(controller_out_bus.enable_writeback), // Agent input 
// .dut_signal_port(controller_out_bus.bypass_alu_1), // Agent input 
// .dut_signal_port(controller_out_bus.bypass_alu_2), // Agent input 
// .dut_signal_port(controller_out_bus.bypass_mem_1), // Agent input 
// .dut_signal_port(controller_out_bus.bypass_mem_2), // Agent input 
// .dut_signal_port(controller_out_bus.mem_state), // Agent input 
// .dut_signal_port(controller_out_bus.br_taken), // Agent input 

import uvmf_base_pkg_hdl::*;
import controller_out_pkg_hdl::*;

interface  controller_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  enable_updatePC,
  inout tri  enable_fetch,
  inout tri  enable_decode,
  inout tri  enable_execute,
  inout tri  enable_writeback,
  inout tri  bypass_alu_1,
  inout tri  bypass_alu_2,
  inout tri  bypass_mem_1,
  inout tri  bypass_mem_2,
  inout tri [1:0] mem_state,
  inout tri  br_taken
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input enable_updatePC,
  input enable_fetch,
  input enable_decode,
  input enable_execute,
  input enable_writeback,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input mem_state,
  input br_taken
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input enable_updatePC,
  input enable_fetch,
  input enable_decode,
  input enable_execute,
  input enable_writeback,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input mem_state,
  input br_taken
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output enable_updatePC,
  output enable_fetch,
  output enable_decode,
  output enable_execute,
  output enable_writeback,
  output bypass_alu_1,
  output bypass_alu_2,
  output bypass_mem_1,
  output bypass_mem_2,
  output mem_state,
  output br_taken
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

