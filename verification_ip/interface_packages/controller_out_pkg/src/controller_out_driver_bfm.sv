//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the controller_out signal driving.  It is
//     accessed by the uvm controller_out driver through a virtual interface
//     handle in the controller_out configuration.  It drives the singals passed
//     in through the port connection named bus of type controller_out_if.
//
//     Input signals from the controller_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within controller_out_if based on INITIATOR/RESPONDER and/or
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
import controller_out_pkg_hdl::*;
`include "src/controller_out_macros.svh"

interface controller_out_driver_bfm 
  (controller_out_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute controller_out_driver_bfm partition_interface_xif

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
  tri  enable_updatePC_i;
  reg  enable_updatePC_o = 'bz;
  tri  enable_fetch_i;
  reg  enable_fetch_o = 'bz;
  tri  enable_decode_i;
  reg  enable_decode_o = 'bz;
  tri  enable_execute_i;
  reg  enable_execute_o = 'bz;
  tri  enable_writeback_i;
  reg  enable_writeback_o = 'bz;
  tri  bypass_alu_1_i;
  reg  bypass_alu_1_o = 'bz;
  tri  bypass_alu_2_i;
  reg  bypass_alu_2_o = 'bz;
  tri  bypass_mem_1_i;
  reg  bypass_mem_1_o = 'bz;
  tri  bypass_mem_2_i;
  reg  bypass_mem_2_o = 'bz;
  tri [1:0] mem_state_i;
  reg [1:0] mem_state_o = 'bz;
  tri  br_taken_i;
  reg  br_taken_o = 'bz;

  // INITIATOR mode output signals

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)
  assign enable_updatePC_i = bus.enable_updatePC;
  assign bus.enable_updatePC = (initiator_responder == RESPONDER) ? enable_updatePC_o : 'bz;
  assign enable_fetch_i = bus.enable_fetch;
  assign bus.enable_fetch = (initiator_responder == RESPONDER) ? enable_fetch_o : 'bz;
  assign enable_decode_i = bus.enable_decode;
  assign bus.enable_decode = (initiator_responder == RESPONDER) ? enable_decode_o : 'bz;
  assign enable_execute_i = bus.enable_execute;
  assign bus.enable_execute = (initiator_responder == RESPONDER) ? enable_execute_o : 'bz;
  assign enable_writeback_i = bus.enable_writeback;
  assign bus.enable_writeback = (initiator_responder == RESPONDER) ? enable_writeback_o : 'bz;
  assign bypass_alu_1_i = bus.bypass_alu_1;
  assign bus.bypass_alu_1 = (initiator_responder == RESPONDER) ? bypass_alu_1_o : 'bz;
  assign bypass_alu_2_i = bus.bypass_alu_2;
  assign bus.bypass_alu_2 = (initiator_responder == RESPONDER) ? bypass_alu_2_o : 'bz;
  assign bypass_mem_1_i = bus.bypass_mem_1;
  assign bus.bypass_mem_1 = (initiator_responder == RESPONDER) ? bypass_mem_1_o : 'bz;
  assign bypass_mem_2_i = bus.bypass_mem_2;
  assign bus.bypass_mem_2 = (initiator_responder == RESPONDER) ? bypass_mem_2_o : 'bz;
  assign mem_state_i = bus.mem_state;
  assign bus.mem_state = (initiator_responder == RESPONDER) ? mem_state_o : 'bz;
  assign br_taken_i = bus.br_taken;
  assign bus.br_taken = (initiator_responder == RESPONDER) ? br_taken_o : 'bz;


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.

  // Proxy handle to UVM driver
  controller_out_pkg::controller_out_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in controller_out_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from controller_out_driver to this BFM
  // ****************************************************************************
  `controller_out_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate initiator driven data to controller_out_driver_bfm.           
  `controller_out_INITIATOR_STRUCT
    controller_out_initiator_s initiator_struct;
  // Responder macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate Responder driven data to controller_out_driver_bfm.
  `controller_out_RESPONDER_STRUCT
    controller_out_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       enable_updatePC_o <= 'bz;
       enable_fetch_o <= 'bz;
       enable_decode_o <= 'bz;
       enable_execute_o <= 'bz;
       enable_writeback_o <= 'bz;
       bypass_alu_1_o <= 'bz;
       bypass_alu_2_o <= 'bz;
       bypass_mem_1_o <= 'bz;
       bypass_mem_2_o <= 'bz;
       mem_state_o <= 'bz;
       br_taken_o <= 'bz;
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

  function void configure(controller_out_configuration_s controller_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = controller_out_configuration_arg.initiator_responder;
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
       input controller_out_initiator_s controller_out_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output controller_out_responder_s controller_out_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the controller_out_initiator_struct:
       //   bit enable_updatePC_trans_var ;
       //   bit enable_fetch_trans_var ;
       //   bit enable_decode_trans_var ;
       //   bit enable_execute_trans_var ;
       //   bit enable_writeback_trans_var ;
       //   bit bypass_alu_1_trans_var ;
       //   bit bypass_alu_2_trans_var ;
       //   bit bypass_mem_1_trans_var ;
       //   bit bypass_mem_2_trans_var ;
       //   bit mem_state ;
       //   bit br_taken ;
       // Members within the controller_out_responder_struct:
       //   bit enable_updatePC_trans_var ;
       //   bit enable_fetch_trans_var ;
       //   bit enable_decode_trans_var ;
       //   bit enable_execute_trans_var ;
       //   bit enable_writeback_trans_var ;
       //   bit bypass_alu_1_trans_var ;
       //   bit bypass_alu_2_trans_var ;
       //   bit bypass_mem_1_trans_var ;
       //   bit bypass_mem_2_trans_var ;
       //   bit mem_state ;
       //   bit br_taken ;
       initiator_struct = controller_out_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //      controller_out_responder_struct.xyz = enable_updatePC_i;  //     
       //      controller_out_responder_struct.xyz = enable_fetch_i;  //     
       //      controller_out_responder_struct.xyz = enable_decode_i;  //     
       //      controller_out_responder_struct.xyz = enable_execute_i;  //     
       //      controller_out_responder_struct.xyz = enable_writeback_i;  //     
       //      controller_out_responder_struct.xyz = bypass_alu_1_i;  //     
       //      controller_out_responder_struct.xyz = bypass_alu_2_i;  //     
       //      controller_out_responder_struct.xyz = bypass_mem_1_i;  //     
       //      controller_out_responder_struct.xyz = bypass_mem_2_i;  //     
       //      controller_out_responder_struct.xyz = mem_state_i;  //    [1:0] 
       //      controller_out_responder_struct.xyz = br_taken_i;  //     
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
    // controller_out_responder_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    responder_struct = controller_out_responder_struct;
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
       output controller_out_initiator_s controller_out_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input controller_out_responder_s controller_out_responder_struct 
       );// pragma tbx xtf   
  // Variables within the controller_out_initiator_struct:
  //   bit enable_updatePC_trans_var ;
  //   bit enable_fetch_trans_var ;
  //   bit enable_decode_trans_var ;
  //   bit enable_execute_trans_var ;
  //   bit enable_writeback_trans_var ;
  //   bit bypass_alu_1_trans_var ;
  //   bit bypass_alu_2_trans_var ;
  //   bit bypass_mem_1_trans_var ;
  //   bit bypass_mem_2_trans_var ;
  //   bit mem_state ;
  //   bit br_taken ;
  // Variables within the controller_out_responder_struct:
  //   bit enable_updatePC_trans_var ;
  //   bit enable_fetch_trans_var ;
  //   bit enable_decode_trans_var ;
  //   bit enable_execute_trans_var ;
  //   bit enable_writeback_trans_var ;
  //   bit bypass_alu_1_trans_var ;
  //   bit bypass_alu_2_trans_var ;
  //   bit bypass_mem_1_trans_var ;
  //   bit bypass_mem_2_trans_var ;
  //   bit mem_state ;
  //   bit br_taken ;
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
       //      enable_updatePC_o <= controller_out_initiator_struct.xyz;  //     
       //      enable_fetch_o <= controller_out_initiator_struct.xyz;  //     
       //      enable_decode_o <= controller_out_initiator_struct.xyz;  //     
       //      enable_execute_o <= controller_out_initiator_struct.xyz;  //     
       //      enable_writeback_o <= controller_out_initiator_struct.xyz;  //     
       //      bypass_alu_1_o <= controller_out_initiator_struct.xyz;  //     
       //      bypass_alu_2_o <= controller_out_initiator_struct.xyz;  //     
       //      bypass_mem_1_o <= controller_out_initiator_struct.xyz;  //     
       //      bypass_mem_2_o <= controller_out_initiator_struct.xyz;  //     
       //      mem_state_o <= controller_out_initiator_struct.xyz;  //    [1:0] 
       //      br_taken_o <= controller_out_initiator_struct.xyz;  //     
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the controller_out_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the controller_out_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

