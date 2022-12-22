//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the fetch_in interface signals.
//      It is instantiated once per fetch_in bus.  Bus Functional Models, 
//      BFM's named fetch_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named fetch_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(fetch_in_bus.enable_updatePC), // Agent output 
// .dut_signal_port(fetch_in_bus.enable_fetch), // Agent output 
// .dut_signal_port(fetch_in_bus.taddr), // Agent output 
// .dut_signal_port(fetch_in_bus.brtaken), // Agent output 

import uvmf_base_pkg_hdl::*;
import fetch_in_pkg_hdl::*;

interface  fetch_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  enable_updatePC,
  inout tri  enable_fetch,
  inout tri [15:0] taddr,
  inout tri  brtaken
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input enable_updatePC,
  input enable_fetch,
  input taddr,
  input brtaken
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output enable_updatePC,
  output enable_fetch,
  output taddr,
  output brtaken
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input enable_updatePC,
  input enable_fetch,
  input taddr,
  input brtaken
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

