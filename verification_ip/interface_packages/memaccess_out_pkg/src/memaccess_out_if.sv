//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the memaccess_out interface signals.
//      It is instantiated once per memaccess_out bus.  Bus Functional Models, 
//      BFM's named memaccess_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named memaccess_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(memaccess_out_bus.DMem_addr), // Agent output 
// .dut_signal_port(memaccess_out_bus.DMem_din), // Agent output 
// .dut_signal_port(memaccess_out_bus.DMem_rd), // Agent output 
// .dut_signal_port(memaccess_out_bus.memout), // Agent output 

import uvmf_base_pkg_hdl::*;
import memaccess_out_pkg_hdl::*;

interface  memaccess_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] DMem_addr,
  inout tri [15:0] DMem_din,
  inout tri  DMem_rd,
  inout tri [15:0] memout
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input DMem_addr,
  input DMem_din,
  input DMem_rd,
  input memout
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output DMem_addr,
  output DMem_din,
  output DMem_rd,
  output memout
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input DMem_addr,
  input DMem_din,
  input DMem_rd,
  input memout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

