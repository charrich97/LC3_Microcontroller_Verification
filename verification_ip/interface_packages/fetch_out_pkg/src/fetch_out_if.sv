//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the fetch_out interface signals.
//      It is instantiated once per fetch_out bus.  Bus Functional Models, 
//      BFM's named fetch_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named fetch_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(fetch_out_bus.npc), // Agent input 
// .dut_signal_port(fetch_out_bus.pc), // Agent input 
// .dut_signal_port(fetch_out_bus.imem_rd), // Agent input 
// .dut_signal_port(fetch_out_bus.enable_fetch), // Agent input 

import uvmf_base_pkg_hdl::*;
import fetch_out_pkg_hdl::*;

interface  fetch_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] npc,
  inout tri [15:0] pc,
  inout tri  imem_rd,
  inout tri  enable_fetch
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input npc,
  input pc,
  input imem_rd,
  input enable_fetch
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input npc,
  input pc,
  input imem_rd,
  input enable_fetch
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output npc,
  output pc,
  output imem_rd,
  output enable_fetch
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

