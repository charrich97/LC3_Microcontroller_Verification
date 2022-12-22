//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the execute_in interface signals.
//      It is instantiated once per execute_in bus.  Bus Functional Models, 
//      BFM's named execute_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named execute_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(execute_in_bus.E_control), // Agent output 
// .dut_signal_port(execute_in_bus.IR), // Agent output 
// .dut_signal_port(execute_in_bus.npc_in), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_alu_1), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_alu_2), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_mem_1), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_mem_2), // Agent output 
// .dut_signal_port(execute_in_bus.VSR1), // Agent output 
// .dut_signal_port(execute_in_bus.VSR2), // Agent output 
// .dut_signal_port(execute_in_bus.W_Control_in), // Agent output 
// .dut_signal_port(execute_in_bus.Mem_Control_in), // Agent output 
// .dut_signal_port(execute_in_bus.enable_execute), // Agent output 
// .dut_signal_port(execute_in_bus.Mem_Bypass_Val), // Agent output 

import uvmf_base_pkg_hdl::*;
import execute_in_pkg_hdl::*;

interface  execute_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [5:0] E_control,
  inout tri [15:0] IR,
  inout tri [15:0] npc_in,
  inout tri  bypass_alu_1,
  inout tri  bypass_alu_2,
  inout tri  bypass_mem_1,
  inout tri  bypass_mem_2,
  inout tri [15:0] VSR1,
  inout tri [15:0] VSR2,
  inout tri [1:0] W_Control_in,
  inout tri  Mem_Control_in,
  inout tri  enable_execute,
  inout tri [15:0] Mem_Bypass_Val
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input E_control,
  input IR,
  input npc_in,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input VSR1,
  input VSR2,
  input W_Control_in,
  input Mem_Control_in,
  input enable_execute,
  input Mem_Bypass_Val
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output E_control,
  output IR,
  output npc_in,
  output bypass_alu_1,
  output bypass_alu_2,
  output bypass_mem_1,
  output bypass_mem_2,
  output VSR1,
  output VSR2,
  output W_Control_in,
  output Mem_Control_in,
  output enable_execute,
  output Mem_Bypass_Val
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input E_control,
  input IR,
  input npc_in,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input VSR1,
  input VSR2,
  input W_Control_in,
  input Mem_Control_in,
  input enable_execute,
  input Mem_Bypass_Val
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

