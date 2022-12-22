//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the data_memory interface signals.
//      It is instantiated once per data_memory bus.  Bus Functional Models, 
//      BFM's named data_memory_driver_bfm, are used to drive signals on the bus.
//      BFM's named data_memory_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(data_memory_bus.Data_dout), // Agent input 
// .dut_signal_port(data_memory_bus.complete_data), // Agent input 
// .dut_signal_port(data_memory_bus.Data_din), // Agent output 
// .dut_signal_port(data_memory_bus.Data_addr), // Agent output 
// .dut_signal_port(data_memory_bus.Data_rd), // Agent output 
// .dut_signal_port(data_memory_bus.D_macc), // Agent input 

import uvmf_base_pkg_hdl::*;
import data_memory_pkg_hdl::*;

interface  data_memory_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] Data_dout,
  inout tri  complete_data,
  inout tri [15:0] Data_din,
  inout tri [15:0] Data_addr,
  inout tri  Data_rd,
  inout tri  D_macc
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input Data_dout,
  input complete_data,
  input Data_din,
  input Data_addr,
  input Data_rd,
  input D_macc
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input Data_dout,
  input complete_data,
  output Data_din,
  output Data_addr,
  output Data_rd,
  input D_macc
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output Data_dout,
  output complete_data,
  input Data_din,
  input Data_addr,
  input Data_rd,
  output D_macc
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

