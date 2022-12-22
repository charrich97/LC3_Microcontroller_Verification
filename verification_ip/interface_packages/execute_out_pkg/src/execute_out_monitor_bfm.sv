//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the execute_out signal monitoring.
//      It is accessed by the uvm execute_out monitor through a virtual
//      interface handle in the execute_out configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type execute_out_if.
//
//     Input signals from the execute_out_if are assigned to an internal input
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
//                   blocks until an operation on the execute_out bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import execute_out_pkg_hdl::*;
`include "src/execute_out_macros.svh"


interface execute_out_monitor_bfm 
  ( execute_out_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute execute_out_monitor_bfm partition_interface_xif                                  

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
`execute_out_MONITOR_STRUCT
  execute_out_monitor_s execute_out_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `execute_out_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [1:0] W_Control_out_i;
  tri  Mem_Control_out_i;
  tri [15:0] aluout_i;
  tri [15:0] pcout_i;
  tri [2:0] dr_i;
  tri [2:0] sr1_i;
  tri [2:0] sr2_i;
  tri [15:0] IR_Exec_i;
  tri [2:0] NZP_i;
  tri [15:0] M_Data_i;
  tri  enable_execute_status_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign W_Control_out_i = bus.W_Control_out;
  assign Mem_Control_out_i = bus.Mem_Control_out;
  assign aluout_i = bus.aluout;
  assign pcout_i = bus.pcout;
  assign dr_i = bus.dr;
  assign sr1_i = bus.sr1;
  assign sr2_i = bus.sr2;
  assign IR_Exec_i = bus.IR_Exec;
  assign NZP_i = bus.NZP;
  assign M_Data_i = bus.M_Data;
  assign enable_execute_status_i = bus.enable_execute_status;

  // Proxy handle to UVM monitor
  execute_out_pkg::execute_out_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  reg       enable_execute_status_reg   ;
	reg [2:0] async_sr1                   ;
	reg [2:0] async_sr2                   ;
  initial begin
    forever begin
    @(posedge clock_i); 
    enable_execute_status_reg         = enable_execute_status_i;
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
      do_monitor( execute_out_monitor_struct );
                                                                 
      if(enable_execute_status_reg == 1'b1) begin 
        proxy.notify_transaction( execute_out_monitor_struct );
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
    function void configure(execute_out_configuration_s execute_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = execute_out_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output execute_out_monitor_s execute_out_monitor_struct);
    //
    // Available struct members:
    //     //    execute_out_monitor_struct.W_Control_out
    //     //    execute_out_monitor_struct.Mem_Control_out
    //     //    execute_out_monitor_struct.aluout
    //     //    execute_out_monitor_struct.pcout
    //     //    execute_out_monitor_struct.dr
    //     //    execute_out_monitor_struct.sr1
    //     //    execute_out_monitor_struct.sr2
    //     //    execute_out_monitor_struct.IR_Exec
    //     //    execute_out_monitor_struct.NZP
    //     //    execute_out_monitor_struct.M_Data
    //     //    execute_out_monitor_struct.enable_execute_status
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      execute_out_monitor_struct.xyz = W_Control_out_i;  //    [1:0] 
    //      execute_out_monitor_struct.xyz = Mem_Control_out_i;  //     
    //      execute_out_monitor_struct.xyz = aluout_i;  //    [15:0] 
    //      execute_out_monitor_struct.xyz = pcout_i;  //    [15:0] 
    //      execute_out_monitor_struct.xyz = dr_i;  //    [2:0] 
    //      execute_out_monitor_struct.xyz = sr1_i;  //    [2:0] 
    //      execute_out_monitor_struct.xyz = sr2_i;  //    [2:0] 
    //      execute_out_monitor_struct.xyz = IR_Exec_i;  //    [15:0] 
    //      execute_out_monitor_struct.xyz = NZP_i;  //    [2:0] 
    //      execute_out_monitor_struct.xyz = M_Data_i;  //    [15:0] 
    //      execute_out_monitor_struct.xyz = enable_execute_status_i;  //     
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
		async_sr1                                   <= sr1_i;
		async_sr2                                   <= sr2_i;
    #1;
    execute_out_monitor_struct.aluout			      = aluout_i;  //    [15:0] 
    execute_out_monitor_struct.pcout			      = pcout_i;  //    [15:0] 
    execute_out_monitor_struct.W_Control_out	  = W_Control_out_i;  //    [1:0] 
    execute_out_monitor_struct.Mem_Control_out	= Mem_Control_out_i;  //     
    execute_out_monitor_struct.dr				        = dr_i;  //    [2:0] 
    execute_out_monitor_struct.sr1				      = async_sr1;  //    [2:0] 
    execute_out_monitor_struct.sr2				      = async_sr2;  //    [2:0] 
    execute_out_monitor_struct.IR_Exec			    = IR_Exec_i;  //    [15:0] 
    execute_out_monitor_struct.NZP				      = NZP_i;  //    [2:0] 
    execute_out_monitor_struct.M_Data			      = M_Data_i;  //    [15:0] 
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

