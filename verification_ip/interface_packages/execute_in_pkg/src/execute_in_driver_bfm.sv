//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the execute_in signal driving.  It is
//     accessed by the uvm execute_in driver through a virtual interface
//     handle in the execute_in configuration.  It drives the singals passed
//     in through the port connection named bus of type execute_in_if.
//
//     Input signals from the execute_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within execute_in_if based on INITIATOR/RESPONDER and/or
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
import execute_in_pkg_hdl::*;
`include "src/execute_in_macros.svh"

interface execute_in_driver_bfm 
  (execute_in_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute execute_in_driver_bfm partition_interface_xif

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

  // INITIATOR mode output signals
  tri [5:0] E_control_i;
  reg [5:0] E_control_o = 'bz;
  tri [15:0] IR_i;
  reg [15:0] IR_o = 'bz;
  tri [15:0] npc_in_i;
  reg [15:0] npc_in_o = 'bz;
  tri  bypass_alu_1_i;
  reg  bypass_alu_1_o = 'bz;
  tri  bypass_alu_2_i;
  reg  bypass_alu_2_o = 'bz;
  tri  bypass_mem_1_i;
  reg  bypass_mem_1_o = 'bz;
  tri  bypass_mem_2_i;
  reg  bypass_mem_2_o = 'bz;
  tri [15:0] VSR1_i;
  reg [15:0] VSR1_o = 'bz;
  tri [15:0] VSR2_i;
  reg [15:0] VSR2_o = 'bz;
  tri [1:0] W_Control_in_i;
  reg [1:0] W_Control_in_o = 'bz;
  tri  Mem_Control_in_i;
  reg  Mem_Control_in_o = 'bz;
  tri  enable_execute_i;
  reg  enable_execute_o = 'bz;
  tri [15:0] Mem_Bypass_Val_i;
  reg [15:0] Mem_Bypass_Val_o = 'bz;

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.E_control = (initiator_responder == INITIATOR) ? E_control_o : 'bz;
  assign E_control_i = bus.E_control;
  assign bus.IR = (initiator_responder == INITIATOR) ? IR_o : 'bz;
  assign IR_i = bus.IR;
  assign bus.npc_in = (initiator_responder == INITIATOR) ? npc_in_o : 'bz;
  assign npc_in_i = bus.npc_in;
  assign bus.bypass_alu_1 = (initiator_responder == INITIATOR) ? bypass_alu_1_o : 'bz;
  assign bypass_alu_1_i = bus.bypass_alu_1;
  assign bus.bypass_alu_2 = (initiator_responder == INITIATOR) ? bypass_alu_2_o : 'bz;
  assign bypass_alu_2_i = bus.bypass_alu_2;
  assign bus.bypass_mem_1 = (initiator_responder == INITIATOR) ? bypass_mem_1_o : 'bz;
  assign bypass_mem_1_i = bus.bypass_mem_1;
  assign bus.bypass_mem_2 = (initiator_responder == INITIATOR) ? bypass_mem_2_o : 'bz;
  assign bypass_mem_2_i = bus.bypass_mem_2;
  assign bus.VSR1 = (initiator_responder == INITIATOR) ? VSR1_o : 'bz;
  assign VSR1_i = bus.VSR1;
  assign bus.VSR2 = (initiator_responder == INITIATOR) ? VSR2_o : 'bz;
  assign VSR2_i = bus.VSR2;
  assign bus.W_Control_in = (initiator_responder == INITIATOR) ? W_Control_in_o : 'bz;
  assign W_Control_in_i = bus.W_Control_in;
  assign bus.Mem_Control_in = (initiator_responder == INITIATOR) ? Mem_Control_in_o : 'bz;
  assign Mem_Control_in_i = bus.Mem_Control_in;
  assign bus.enable_execute = (initiator_responder == INITIATOR) ? enable_execute_o : 'bz;
  assign enable_execute_i = bus.enable_execute;
  assign bus.Mem_Bypass_Val = (initiator_responder == INITIATOR) ? Mem_Bypass_Val_o : 'bz;
  assign Mem_Bypass_Val_i = bus.Mem_Bypass_Val;

  // Proxy handle to UVM driver
  execute_in_pkg::execute_in_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in execute_in_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from execute_in_driver to this BFM
  // ****************************************************************************
  `execute_in_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by execute_in_driver and execute_in_driver_bfm
  // to communicate initiator driven data to execute_in_driver_bfm.           
  `execute_in_INITIATOR_STRUCT
    execute_in_initiator_s initiator_struct;
  // Responder macro used by execute_in_driver and execute_in_driver_bfm
  // to communicate Responder driven data to execute_in_driver_bfm.
  `execute_in_RESPONDER_STRUCT
    execute_in_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       // INITIATOR mode output signals
       E_control_o <= 'bz;
       IR_o <= 'bz;
       npc_in_o <= 'bz;
       bypass_alu_1_o <= 'bz;
       bypass_alu_2_o <= 'bz;
       bypass_mem_1_o <= 'bz;
       bypass_mem_2_o <= 'bz;
       VSR1_o <= 'bz;
       VSR2_o <= 'bz;
       W_Control_in_o <= 'bz;
       Mem_Control_in_o <= 'bz;
       enable_execute_o <= 'bz;
       Mem_Bypass_Val_o <= 'bz;
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

  function void configure(execute_in_configuration_s execute_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = execute_in_configuration_arg.initiator_responder;
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
       input execute_in_initiator_s execute_in_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output execute_in_responder_s execute_in_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the execute_in_initiator_struct:
       //   bit [5:0] E_control ;
       //   bit [15:0] IR ;
       //   bit [15:0] npc_in ;
       //   bit bypass_alu_1 ;
       //   bit bypass_alu_2 ;
       //   bit bypass_mem_1 ;
       //   bit bypass_mem_2 ;
       //   bit [15:0] VSR1 ;
       //   bit [15:0] VSR2 ;
       //   bit [1:0] W_Control_in ;
       //   bit Mem_Control_in ;
       //   bit enable_execute ;
       //   bit [15:0] Mem_Bypass_Val ;
       // Members within the execute_in_responder_struct:
       //   bit [5:0] E_control ;
       //   bit [15:0] IR ;
       //   bit [15:0] npc_in ;
       //   bit bypass_alu_1 ;
       //   bit bypass_alu_2 ;
       //   bit bypass_mem_1 ;
       //   bit bypass_mem_2 ;
       //   bit [15:0] VSR1 ;
       //   bit [15:0] VSR2 ;
       //   bit [1:0] W_Control_in ;
       //   bit Mem_Control_in ;
       //   bit enable_execute ;
       //   bit [15:0] Mem_Bypass_Val ;
       initiator_struct = execute_in_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //      E_control_o <= execute_in_initiator_struct.xyz;  //    [5:0] 
       //      IR_o <= execute_in_initiator_struct.xyz;  //    [15:0] 
       //      npc_in_o <= execute_in_initiator_struct.xyz;  //    [15:0] 
       //      bypass_alu_1_o <= execute_in_initiator_struct.xyz;  //     
       //      bypass_alu_2_o <= execute_in_initiator_struct.xyz;  //     
       //      bypass_mem_1_o <= execute_in_initiator_struct.xyz;  //     
       //      bypass_mem_2_o <= execute_in_initiator_struct.xyz;  //     
       //      VSR1_o <= execute_in_initiator_struct.xyz;  //    [15:0] 
       //      VSR2_o <= execute_in_initiator_struct.xyz;  //    [15:0] 
       //      W_Control_in_o <= execute_in_initiator_struct.xyz;  //    [1:0] 
       //      Mem_Control_in_o <= execute_in_initiator_struct.xyz;  //     
       //      enable_execute_o <= execute_in_initiator_struct.xyz;  //     
       //      Mem_Bypass_Val_o <= execute_in_initiator_struct.xyz;  //    [15:0] 
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clock_i);
    @(posedge clock_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // execute_in_responder_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    responder_struct = execute_in_responder_struct;
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
       output execute_in_initiator_s execute_in_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input execute_in_responder_s execute_in_responder_struct 
       );// pragma tbx xtf   
  // Variables within the execute_in_initiator_struct:
  //   bit [5:0] E_control ;
  //   bit [15:0] IR ;
  //   bit [15:0] npc_in ;
  //   bit bypass_alu_1 ;
  //   bit bypass_alu_2 ;
  //   bit bypass_mem_1 ;
  //   bit bypass_mem_2 ;
  //   bit [15:0] VSR1 ;
  //   bit [15:0] VSR2 ;
  //   bit [1:0] W_Control_in ;
  //   bit Mem_Control_in ;
  //   bit enable_execute ;
  //   bit [15:0] Mem_Bypass_Val ;
  // Variables within the execute_in_responder_struct:
  //   bit [5:0] E_control ;
  //   bit [15:0] IR ;
  //   bit [15:0] npc_in ;
  //   bit bypass_alu_1 ;
  //   bit bypass_alu_2 ;
  //   bit bypass_mem_1 ;
  //   bit bypass_mem_2 ;
  //   bit [15:0] VSR1 ;
  //   bit [15:0] VSR2 ;
  //   bit [1:0] W_Control_in ;
  //   bit Mem_Control_in ;
  //   bit enable_execute ;
  //   bit [15:0] Mem_Bypass_Val ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      execute_in_responder_struct.xyz = E_control_i;  //    [5:0] 
       //      execute_in_responder_struct.xyz = IR_i;  //    [15:0] 
       //      execute_in_responder_struct.xyz = npc_in_i;  //    [15:0] 
       //      execute_in_responder_struct.xyz = bypass_alu_1_i;  //     
       //      execute_in_responder_struct.xyz = bypass_alu_2_i;  //     
       //      execute_in_responder_struct.xyz = bypass_mem_1_i;  //     
       //      execute_in_responder_struct.xyz = bypass_mem_2_i;  //     
       //      execute_in_responder_struct.xyz = VSR1_i;  //    [15:0] 
       //      execute_in_responder_struct.xyz = VSR2_i;  //    [15:0] 
       //      execute_in_responder_struct.xyz = W_Control_in_i;  //    [1:0] 
       //      execute_in_responder_struct.xyz = Mem_Control_in_i;  //     
       //      execute_in_responder_struct.xyz = enable_execute_i;  //     
       //      execute_in_responder_struct.xyz = Mem_Bypass_Val_i;  //    [15:0] 
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an initiator struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the execute_in_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the execute_in_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

