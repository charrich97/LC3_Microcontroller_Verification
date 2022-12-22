//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the instruction_memory signal monitoring.
//      It is accessed by the uvm instruction_memory monitor through a virtual
//      interface handle in the instruction_memory configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type instruction_memory_if.
//
//     Input signals from the instruction_memory_if are assigned to an internal input
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
//                   blocks until an operation on the instruction_memory bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import instruction_memory_pkg_hdl::*;
`include "src/instruction_memory_macros.svh"


interface instruction_memory_monitor_bfm 
  ( instruction_memory_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute instruction_memory_monitor_bfm partition_interface_xif                                  

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
`instruction_memory_MONITOR_STRUCT
  instruction_memory_monitor_s instruction_memory_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `instruction_memory_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [15:0] Instr_dout_i;
  tri  complete_instr_i;
  tri  instrmem_rd_i;
  tri [15:0] PC_i;
  tri  I_macc_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign Instr_dout_i = bus.Instr_dout;
  assign complete_instr_i = bus.complete_instr;
  assign instrmem_rd_i = bus.instrmem_rd;
  assign PC_i = bus.PC;
  assign I_macc_i = bus.I_macc;

  // Proxy handle to UVM monitor
  instruction_memory_pkg::instruction_memory_monitor  proxy;
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
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( instruction_memory_monitor_struct );
                                                                 
 
      proxy.notify_transaction( instruction_memory_monitor_struct );
 
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
    function void configure(instruction_memory_configuration_s instruction_memory_configuration_arg); // pragma tbx xtf  
    initiator_responder = instruction_memory_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output instruction_memory_monitor_s instruction_memory_monitor_struct);
    //
    // Available struct members:
    //     //    instruction_memory_monitor_struct.opcode
    //     //    instruction_memory_monitor_struct.sr1
    //     //    instruction_memory_monitor_struct.sr2
    //     //    instruction_memory_monitor_struct.dr
    //     //    instruction_memory_monitor_struct.im
    //     //    instruction_memory_monitor_struct.baser
    //     //    instruction_memory_monitor_struct.pcoffset9
    //     //    instruction_memory_monitor_struct.pcoffset6
    //     //    instruction_memory_monitor_struct.imm5
    //     //    instruction_memory_monitor_struct.nzp
    //     //    instruction_memory_monitor_struct.instruction
    //     //    instruction_memory_monitor_struct.complete_instr
    //     //    instruction_memory_monitor_struct.instrmem_rd
    //     //    instruction_memory_monitor_struct.PC
    //     //    instruction_memory_monitor_struct.I_macc
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      instruction_memory_monitor_struct.xyz = Instr_dout_i;  //    [15:0] 
    //      instruction_memory_monitor_struct.xyz = complete_instr_i;  //     
    //      instruction_memory_monitor_struct.xyz = instrmem_rd_i;  //     
    //      instruction_memory_monitor_struct.xyz = PC_i;  //    [15:0] 
    //      instruction_memory_monitor_struct.xyz = I_macc_i;  //     
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
            instruction_memory_monitor_struct.instruction  = Instr_dout_i                        ;  //    [15:0] 
      $cast(instruction_memory_monitor_struct.opcode       , op_t'(Instr_dout_i[15:12]))         ;  //    [15:0] 
            instruction_memory_monitor_struct.sr1          = Instr_dout_i[8:6]                   ; 
            instruction_memory_monitor_struct.sr2          = Instr_dout_i[2:0]                   ;
            instruction_memory_monitor_struct.dr           = Instr_dout_i[11:9]                  ;
            instruction_memory_monitor_struct.baser        = Instr_dout_i[8:6]                   ;
            instruction_memory_monitor_struct.pcoffset9    = Instr_dout_i[8:0]                   ;
            instruction_memory_monitor_struct.pcoffset6    = Instr_dout_i[5:0]                   ;   
            instruction_memory_monitor_struct.im           = Instr_dout_i[5]                     ;  
            instruction_memory_monitor_struct.imm5         = Instr_dout_i[4:0]                   ;
            instruction_memory_monitor_struct.nzp          = Instr_dout_i[11:9]                  ;
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

