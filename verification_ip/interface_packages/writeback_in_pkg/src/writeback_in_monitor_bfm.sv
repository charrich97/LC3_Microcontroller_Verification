//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the writeback_in signal monitoring.
//      It is accessed by the uvm writeback_in monitor through a virtual
//      interface handle in the writeback_in configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type writeback_in_if.
//
//     Input signals from the writeback_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the writeback_in bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import writeback_in_pkg_hdl::*;
`include "src/writeback_in_macros.svh"


interface writeback_in_monitor_bfm 
  ( writeback_in_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute writeback_in_monitor_bfm partition_interface_xif                                  

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`writeback_in_MONITOR_STRUCT
  writeback_in_monitor_s writeback_in_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `writeback_in_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri  enable_writeback_i;
  tri [15:0] aluout_i;
  tri [15:0] memout_i;
  tri [2:0] sr1_i;
  tri [2:0] sr2_i;
  tri [2:0] dr_i;
  tri [15:0] npc_i;
  tri [15:0] pcout_i;
  tri [1:0] W_control_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign enable_writeback_i = bus.enable_writeback;
  assign aluout_i = bus.aluout;
  assign memout_i = bus.memout;
  assign sr1_i = bus.sr1;
  assign sr2_i = bus.sr2;
  assign dr_i = bus.dr;
  assign npc_i = bus.npc;
  assign pcout_i = bus.pcout;
  assign W_control_i = bus.W_control;

  // Proxy handle to UVM monitor
  writeback_in_pkg::writeback_in_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( reset_i === 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    wait (reset_i === 0);
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( writeback_in_monitor_struct );
                                                                 
        proxy.notify_transaction( writeback_in_monitor_struct );
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(writeback_in_configuration_s writeback_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = writeback_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output writeback_in_monitor_s writeback_in_monitor_struct);
    //
    // Available struct members:
    //     //    writeback_in_monitor_struct.npc
    //     //    writeback_in_monitor_struct.W_control
    //     //    writeback_in_monitor_struct.aluout
    //     //    writeback_in_monitor_struct.pcout
    //     //    writeback_in_monitor_struct.memout
    //     //    writeback_in_monitor_struct.enable_writeback
    //     //    writeback_in_monitor_struct.dr
    //     //    writeback_in_monitor_struct.sr1
    //     //    writeback_in_monitor_struct.sr2
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      writeback_in_monitor_struct.xyz = enable_writeback_i;  //     
    //      writeback_in_monitor_struct.xyz = aluout_i;  //    [15:0] 
    //      writeback_in_monitor_struct.xyz = memout_i;  //    [15:0] 
    //      writeback_in_monitor_struct.xyz = sr1_i;  //    [2:0] 
    //      writeback_in_monitor_struct.xyz = sr2_i;  //    [2:0] 
    //      writeback_in_monitor_struct.xyz = dr_i;  //    [2:0] 
    //      writeback_in_monitor_struct.xyz = npc_i;  //    [15:0] 
    //      writeback_in_monitor_struct.xyz = pcout_i;  //    [15:0] 
    //      writeback_in_monitor_struct.xyz = W_control_i;  //    [1:0] 
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    // pragma uvmf custom do_monitor end
 
     writeback_in_monitor_struct.enable_writeback=enable_writeback_i;
     writeback_in_monitor_struct.aluout = aluout_i;
     writeback_in_monitor_struct.W_control=W_control_i;
     writeback_in_monitor_struct.pcout=pcout_i;
     writeback_in_monitor_struct.memout=memout_i;
     writeback_in_monitor_struct.dr=dr_i;
     writeback_in_monitor_struct.sr1= sr1_i;
     writeback_in_monitor_struct.sr2=sr2_i; 
 
  endtask     
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

