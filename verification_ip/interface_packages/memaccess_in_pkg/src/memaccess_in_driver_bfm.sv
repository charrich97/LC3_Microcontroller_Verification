//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the memaccess_in signal driving.  It is
//     accessed by the uvm memaccess_in driver through a virtual interface
//     handle in the memaccess_in configuration.  It drives the singals passed
//     in through the port connection named bus of type memaccess_in_if.
//
//     Input signals from the memaccess_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within memaccess_in_if based on INITIATOR/RESPONDER and/or
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
import memaccess_in_pkg_hdl::*;
`include "src/memaccess_in_macros.svh"

interface memaccess_in_driver_bfm 
  (memaccess_in_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute memaccess_in_driver_bfm partition_interface_xif

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
  tri [1:0] mem_state_i;
  reg [1:0] mem_state_o = 'bz;
  tri  M_control_i;
  reg  M_control_o = 'bz;
  tri [15:0] M_Data_i;
  reg [15:0] M_Data_o = 'bz;
  tri [15:0] M_addr_i;
  reg [15:0] M_addr_o = 'bz;
  tri [15:0] DMem_dout_i;
  reg [15:0] DMem_dout_o = 'bz;

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.mem_state = (initiator_responder == INITIATOR) ? mem_state_o : 'bz;
  assign mem_state_i = bus.mem_state;
  assign bus.M_control = (initiator_responder == INITIATOR) ? M_control_o : 'bz;
  assign M_control_i = bus.M_control;
  assign bus.M_Data = (initiator_responder == INITIATOR) ? M_Data_o : 'bz;
  assign M_Data_i = bus.M_Data;
  assign bus.M_addr = (initiator_responder == INITIATOR) ? M_addr_o : 'bz;
  assign M_addr_i = bus.M_addr;
  assign bus.DMem_dout = (initiator_responder == INITIATOR) ? DMem_dout_o : 'bz;
  assign DMem_dout_i = bus.DMem_dout;

  // Proxy handle to UVM driver
  memaccess_in_pkg::memaccess_in_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in memaccess_in_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from memaccess_in_driver to this BFM
  // ****************************************************************************
  `memaccess_in_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by memaccess_in_driver and memaccess_in_driver_bfm
  // to communicate initiator driven data to memaccess_in_driver_bfm.           
  `memaccess_in_INITIATOR_STRUCT
    memaccess_in_initiator_s initiator_struct;
  // Responder macro used by memaccess_in_driver and memaccess_in_driver_bfm
  // to communicate Responder driven data to memaccess_in_driver_bfm.
  `memaccess_in_RESPONDER_STRUCT
    memaccess_in_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       // INITIATOR mode output signals
       mem_state_o <= 'bz;
       M_control_o <= 'bz;
       M_Data_o <= 'bz;
       M_addr_o <= 'bz;
       DMem_dout_o <= 'bz;
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

  function void configure(memaccess_in_configuration_s memaccess_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = memaccess_in_configuration_arg.initiator_responder;
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
       input memaccess_in_initiator_s memaccess_in_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output memaccess_in_responder_s memaccess_in_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the memaccess_in_initiator_struct:
       //   mem_state_t mem_state ;
       //   M_control_t M_control ;
       //   M_Data_t M_Data ;
       //   M_addr_t M_addr ;
       //   DMem_dout_t DMem_dout ;
       // Members within the memaccess_in_responder_struct:
       //   mem_state_t mem_state ;
       //   M_control_t M_control ;
       //   M_Data_t M_Data ;
       //   M_addr_t M_addr ;
       //   DMem_dout_t DMem_dout ;
       initiator_struct = memaccess_in_initiator_struct;
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
       //      mem_state_o <= memaccess_in_initiator_struct.xyz;  //    [1:0] 
       //      M_control_o <= memaccess_in_initiator_struct.xyz;  //     
       //      M_Data_o <= memaccess_in_initiator_struct.xyz;  //    [15:0] 
       //      M_addr_o <= memaccess_in_initiator_struct.xyz;  //    [15:0] 
       //      DMem_dout_o <= memaccess_in_initiator_struct.xyz;  //    [15:0] 
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clock_i);
    mem_state_o <= memaccess_in_initiator_struct.mem_state;  //    [1:0] 
    M_control_o <= memaccess_in_initiator_struct.M_control;  //     
    M_Data_o <= memaccess_in_initiator_struct.M_Data;  //    [15:0] 
    M_addr_o <= memaccess_in_initiator_struct.M_addr;  //    [15:0] 
    DMem_dout_o <= memaccess_in_initiator_struct.DMem_dout;  //    [15:0] 

    // Wait for the responder to complete the transfer then place the responder data into 
    // memaccess_in_responder_struct.
    responder_struct = memaccess_in_responder_struct;
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
       output memaccess_in_initiator_s memaccess_in_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input memaccess_in_responder_s memaccess_in_responder_struct 
       );// pragma tbx xtf   
  // Variables within the memaccess_in_initiator_struct:
  //   mem_state_t mem_state ;
  //   M_control_t M_control ;
  //   M_Data_t M_Data ;
  //   M_addr_t M_addr ;
  //   DMem_dout_t DMem_dout ;
  // Variables within the memaccess_in_responder_struct:
  //   mem_state_t mem_state ;
  //   M_control_t M_control ;
  //   M_Data_t M_Data ;
  //   M_addr_t M_addr ;
  //   DMem_dout_t DMem_dout ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      memaccess_in_responder_struct.xyz = mem_state_i;  //    [1:0] 
       //      memaccess_in_responder_struct.xyz = M_control_i;  //     
       //      memaccess_in_responder_struct.xyz = M_Data_i;  //    [15:0] 
       //      memaccess_in_responder_struct.xyz = M_addr_i;  //    [15:0] 
       //      memaccess_in_responder_struct.xyz = DMem_dout_i;  //    [15:0] 
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an initiator struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the memaccess_in_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the memaccess_in_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

