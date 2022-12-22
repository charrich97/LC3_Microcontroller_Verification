//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the execute_out signal driving.  It is
//     accessed by the uvm execute_out driver through a virtual interface
//     handle in the execute_out configuration.  It drives the singals passed
//     in through the port connection named bus of type execute_out_if.
//
//     Input signals from the execute_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within execute_out_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:
//
//             configure:
//                   This function gets configuration attributes from the
//                   UVM driver to set any required BFM configuration
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             initiate_and_get_response:
//                   This task is used to perform signaling activity for initiating
//                   a protocol transfer.  The task initiates the transfer, using
//                   input data from the initiator struct.  Then the task captures
//                   response data, placing the data into the response struct.
//                   The response struct is returned to the driver class.
//
//             respond_and_wait_for_next_transfer:
//                   This task is used to complete a current transfer as a responder
//                   and then wait for the initiator to start the next transfer.
//                   The task uses data in the responder struct to drive protocol
//                   signals to complete the transfer.  The task then waits for 
//                   the next transfer.  Once the next transfer begins, data from
//                   the initiator is placed into the initiator struct and sent
//                   to the responder sequence for processing to determine 
//                   what data to respond with.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import execute_out_pkg_hdl::*;
`include "src/execute_out_macros.svh"

interface execute_out_driver_bfm 
  (execute_out_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute execute_out_driver_bfm partition_interface_xif

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

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals
  tri [1:0] W_Control_out_i;
  reg [1:0] W_Control_out_o = 'bz;
  tri  Mem_Control_out_i;
  reg  Mem_Control_out_o = 'bz;
  tri [15:0] aluout_i;
  reg [15:0] aluout_o = 'bz;
  tri [15:0] pcout_i;
  reg [15:0] pcout_o = 'bz;
  tri [2:0] dr_i;
  reg [2:0] dr_o = 'bz;
  tri [2:0] sr1_i;
  reg [2:0] sr1_o = 'bz;
  tri [2:0] sr2_i;
  reg [2:0] sr2_o = 'bz;
  tri [15:0] IR_Exec_i;
  reg [15:0] IR_Exec_o = 'bz;
  tri [2:0] NZP_i;
  reg [2:0] NZP_o = 'bz;
  tri [15:0] M_Data_i;
  reg [15:0] M_Data_o = 'bz;
  tri  enable_execute_status_i;
  reg  enable_execute_status_o = 'bz;

  // INITIATOR mode output signals

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)
  assign W_Control_out_i = bus.W_Control_out;
  assign bus.W_Control_out = (initiator_responder == RESPONDER) ? W_Control_out_o : 'bz;
  assign Mem_Control_out_i = bus.Mem_Control_out;
  assign bus.Mem_Control_out = (initiator_responder == RESPONDER) ? Mem_Control_out_o : 'bz;
  assign aluout_i = bus.aluout;
  assign bus.aluout = (initiator_responder == RESPONDER) ? aluout_o : 'bz;
  assign pcout_i = bus.pcout;
  assign bus.pcout = (initiator_responder == RESPONDER) ? pcout_o : 'bz;
  assign dr_i = bus.dr;
  assign bus.dr = (initiator_responder == RESPONDER) ? dr_o : 'bz;
  assign sr1_i = bus.sr1;
  assign bus.sr1 = (initiator_responder == RESPONDER) ? sr1_o : 'bz;
  assign sr2_i = bus.sr2;
  assign bus.sr2 = (initiator_responder == RESPONDER) ? sr2_o : 'bz;
  assign IR_Exec_i = bus.IR_Exec;
  assign bus.IR_Exec = (initiator_responder == RESPONDER) ? IR_Exec_o : 'bz;
  assign NZP_i = bus.NZP;
  assign bus.NZP = (initiator_responder == RESPONDER) ? NZP_o : 'bz;
  assign M_Data_i = bus.M_Data;
  assign bus.M_Data = (initiator_responder == RESPONDER) ? M_Data_o : 'bz;
  assign enable_execute_status_i = bus.enable_execute_status;
  assign bus.enable_execute_status = (initiator_responder == RESPONDER) ? enable_execute_status_o : 'bz;


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.

  // Proxy handle to UVM driver
  execute_out_pkg::execute_out_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in execute_out_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from execute_out_driver to this BFM
  // ****************************************************************************
  `execute_out_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by execute_out_driver and execute_out_driver_bfm
  // to communicate initiator driven data to execute_out_driver_bfm.           
  `execute_out_INITIATOR_STRUCT
    execute_out_initiator_s initiator_struct;
  // Responder macro used by execute_out_driver and execute_out_driver_bfm
  // to communicate Responder driven data to execute_out_driver_bfm.
  `execute_out_RESPONDER_STRUCT
    execute_out_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       W_Control_out_o <= 'bz;
       Mem_Control_out_o <= 'bz;
       aluout_o <= 'bz;
       pcout_o <= 'bz;
       dr_o <= 'bz;
       sr1_o <= 'bz;
       sr2_o <= 'bz;
       IR_Exec_o <= 'bz;
       NZP_o <= 'bz;
       M_Data_o <= 'bz;
       enable_execute_status_o <= 'bz;
       // INITIATOR mode output signals
       // Bi-directional signals
 
     end    
// pragma uvmf custom reset_condition_and_response end

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //

  function void configure(execute_out_configuration_s execute_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = execute_out_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction                                                                             

// pragma uvmf custom initiate_and_get_response begin
// ****************************************************************************
// UVMF_CHANGE_ME
// This task is used by an initator.  The task first initiates a transfer then
// waits for the responder to complete the transfer.
    task initiate_and_get_response( 
       // This argument passes transaction variables used by an initiator
       // to perform the initial part of a protocol transfer.  The values
       // come from a sequence item created in a sequence.
       input execute_out_initiator_s execute_out_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output execute_out_responder_s execute_out_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the execute_out_initiator_struct:
       //   bit [1:0] W_Control_out ;
       //   bit Mem_Control_out ;
       //   bit [15:0] aluout ;
       //   bit [15:0] pcout ;
       //   bit [2:0] dr ;
       //   bit [2:0] sr1 ;
       //   bit [2:0] sr2 ;
       //   bit [15:0] IR_Exec ;
       //   bit [2:0] NZP ;
       //   bit [15:0] M_Data ;
       //   bit enable_execute_status ;
       // Members within the execute_out_responder_struct:
       //   bit [1:0] W_Control_out ;
       //   bit Mem_Control_out ;
       //   bit [15:0] aluout ;
       //   bit [15:0] pcout ;
       //   bit [2:0] dr ;
       //   bit [2:0] sr1 ;
       //   bit [2:0] sr2 ;
       //   bit [15:0] IR_Exec ;
       //   bit [2:0] NZP ;
       //   bit [15:0] M_Data ;
       //   bit enable_execute_status ;
       initiator_struct = execute_out_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //      execute_out_responder_struct.xyz = W_Control_out_i;  //    [1:0] 
       //      execute_out_responder_struct.xyz = Mem_Control_out_i;  //     
       //      execute_out_responder_struct.xyz = aluout_i;  //    [15:0] 
       //      execute_out_responder_struct.xyz = pcout_i;  //    [15:0] 
       //      execute_out_responder_struct.xyz = dr_i;  //    [2:0] 
       //      execute_out_responder_struct.xyz = sr1_i;  //    [2:0] 
       //      execute_out_responder_struct.xyz = sr2_i;  //    [2:0] 
       //      execute_out_responder_struct.xyz = IR_Exec_i;  //    [15:0] 
       //      execute_out_responder_struct.xyz = NZP_i;  //    [2:0] 
       //      execute_out_responder_struct.xyz = M_Data_i;  //    [15:0] 
       //      execute_out_responder_struct.xyz = enable_execute_status_i;  //     
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clock_i);
    @(posedge clock_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // execute_out_responder_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    responder_struct = execute_out_responder_struct;
  endtask        
// pragma uvmf custom initiate_and_get_response end

// pragma uvmf custom respond_and_wait_for_next_transfer begin
// ****************************************************************************
// The first_transfer variable is used to prevent completing a transfer in the 
// first call to this task.  For the first call to this task, there is not
// current transfer to complete.
bit first_transfer=1;

// UVMF_CHANGE_ME
// This task is used by a responder.  The task first completes the current 
// transfer in progress then waits for the initiator to start the next transfer.
  task respond_and_wait_for_next_transfer( 
       // This argument is used to send data received from the initiator
       // back to the sequence item.  The sequence determines how to respond.
       output execute_out_initiator_s execute_out_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input execute_out_responder_s execute_out_responder_struct 
       );// pragma tbx xtf   
  // Variables within the execute_out_initiator_struct:
  //   bit [1:0] W_Control_out ;
  //   bit Mem_Control_out ;
  //   bit [15:0] aluout ;
  //   bit [15:0] pcout ;
  //   bit [2:0] dr ;
  //   bit [2:0] sr1 ;
  //   bit [2:0] sr2 ;
  //   bit [15:0] IR_Exec ;
  //   bit [2:0] NZP ;
  //   bit [15:0] M_Data ;
  //   bit enable_execute_status ;
  // Variables within the execute_out_responder_struct:
  //   bit [1:0] W_Control_out ;
  //   bit Mem_Control_out ;
  //   bit [15:0] aluout ;
  //   bit [15:0] pcout ;
  //   bit [2:0] dr ;
  //   bit [2:0] sr1 ;
  //   bit [2:0] sr2 ;
  //   bit [15:0] IR_Exec ;
  //   bit [2:0] NZP ;
  //   bit [15:0] M_Data ;
  //   bit enable_execute_status ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an initiator struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //      W_Control_out_o <= execute_out_initiator_struct.xyz;  //    [1:0] 
       //      Mem_Control_out_o <= execute_out_initiator_struct.xyz;  //     
       //      aluout_o <= execute_out_initiator_struct.xyz;  //    [15:0] 
       //      pcout_o <= execute_out_initiator_struct.xyz;  //    [15:0] 
       //      dr_o <= execute_out_initiator_struct.xyz;  //    [2:0] 
       //      sr1_o <= execute_out_initiator_struct.xyz;  //    [2:0] 
       //      sr2_o <= execute_out_initiator_struct.xyz;  //    [2:0] 
       //      IR_Exec_o <= execute_out_initiator_struct.xyz;  //    [15:0] 
       //      NZP_o <= execute_out_initiator_struct.xyz;  //    [2:0] 
       //      M_Data_o <= execute_out_initiator_struct.xyz;  //    [15:0] 
       //      enable_execute_status_o <= execute_out_initiator_struct.xyz;  //     
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the execute_out_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the execute_out_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

