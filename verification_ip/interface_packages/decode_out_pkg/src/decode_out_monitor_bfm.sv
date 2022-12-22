//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the decode_out signal monitoring.
//      It is accessed by the uvm decode_out monitor through a virtual
//      interface handle in the decode_out configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type decode_out_if.
//
//     Input signals from the decode_out_if are assigned to an internal input
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
//                   blocks until an operation on the decode_out bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import decode_out_pkg_hdl::*;
`include "src/decode_out_macros.svh"


interface decode_out_monitor_bfm 
  ( decode_out_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute decode_out_monitor_bfm partition_interface_xif                                  

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
`decode_out_MONITOR_STRUCT
  decode_out_monitor_s decode_out_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `decode_out_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [15:0] IR_i;
  tri [15:0] npc_out_i;
  tri [5:0] E_control_i;
  tri [1:0] W_control_i;
  tri  Mem_control_i;
  tri  enable_decode_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign IR_i = bus.IR;
  assign npc_out_i = bus.npc_out;
  assign E_control_i = bus.E_control;
  assign W_control_i = bus.W_control;
  assign Mem_control_i = bus.Mem_control;
  assign enable_decode_i = bus.enable_decode;

  // Proxy handle to UVM monitor
  decode_out_pkg::decode_out_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  bit enable_decode_reg;
  initial begin
    forever begin
      @(posedge clock_i);
      enable_decode_reg = enable_decode_i;
    end
  end
  
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
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( decode_out_monitor_struct );
      if ((IR_i>0)  && (enable_decode_reg == 1))begin
        proxy.notify_transaction( decode_out_monitor_struct );
      end
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
    function void configure(decode_out_configuration_s decode_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = decode_out_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output decode_out_monitor_s decode_out_monitor_struct);
    //
    // Available struct members:
    //     //    decode_out_monitor_struct.IR
    //     //    decode_out_monitor_struct.W_control
    //     //    decode_out_monitor_struct.E_control
    //     //    decode_out_monitor_struct.Mem_control
    //     //    decode_out_monitor_struct.npc_out
    //     //    decode_out_monitor_struct.opcode
    //     //    decode_out_monitor_struct.sr1
    //     //    decode_out_monitor_struct.sr2
    //     //    decode_out_monitor_struct.dr
    //     //    decode_out_monitor_struct.im
    //     //    decode_out_monitor_struct.baser
    //     //    decode_out_monitor_struct.pcoffset9
    //     //    decode_out_monitor_struct.pcoffset6
    //     //    decode_out_monitor_struct.imm5
    //     //    decode_out_monitor_struct.n
    //     //    decode_out_monitor_struct.z
    //     //    decode_out_monitor_struct.p
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      decode_out_monitor_struct.xyz = IR_i;  //    [15:0] 
    //      decode_out_monitor_struct.xyz = npc_out_i;  //    [15:0] 
    //      decode_out_monitor_struct.xyz = E_control_i;  //    [5:0] 
    //      decode_out_monitor_struct.xyz = W_control_i;  //    [1:0] 
    //      decode_out_monitor_struct.xyz = Mem_control_i;  //     
    //      decode_out_monitor_struct.xyz = enable_decode_i;  //     
    // pragma uvmf custom do_monitor begin
            decode_out_monitor_struct.IR          = IR_i                                    ;  //    [15:0] 
      $cast(decode_out_monitor_struct.opcode      , op_t'(IR_i[15:12]))                     ;
            decode_out_monitor_struct.npc_out     = npc_out_i                               ;  //    [15:0] 
            decode_out_monitor_struct.E_control   = E_control_i                             ;  //    [5:0] 
      $cast(decode_out_monitor_struct.W_control   , w_control_t'(W_control_i))              ;  //    [1:0] 
      $cast(decode_out_monitor_struct.Mem_control , mem_control_t'(Mem_control_i))          ;  //     
            decode_out_monitor_struct.sr1         = IR_i[8:6]                               ; 
            decode_out_monitor_struct.sr2         = IR_i[2:0]                               ;
            decode_out_monitor_struct.dr          = IR_i[11:9]                              ;
            decode_out_monitor_struct.baser       = IR_i[8:6]                               ;
            decode_out_monitor_struct.pcoffset9   = IR_i[8:0]                               ;
            decode_out_monitor_struct.pcoffset6   = IR_i[5:0]                               ; 
            decode_out_monitor_struct.imm5        = IR_i[4:0]                               ;
            decode_out_monitor_struct.n           = IR_i[11]                                ;
            decode_out_monitor_struct.z           = IR_i[10]                                ;
            decode_out_monitor_struct.p           = IR_i[9]                                 ;
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

