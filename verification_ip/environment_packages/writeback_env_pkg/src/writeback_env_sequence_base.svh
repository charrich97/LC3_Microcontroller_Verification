//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class writeback_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( writeback_env_sequence_base #(
                           CONFIG_T
                           ) );

  
// This writeback_env_sequence_base contains a handle to a writeback_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in writeback_environment:
    // configuration.writeback_in_agent_h_config.sequencer
    // configuration.writeback_out_agent_h_config.sequencer

  // Responder agent sequencers in writeback_environment:


    typedef writeback_in_random_sequence writeback_in_agent_h_random_sequence_t;
    writeback_in_agent_h_random_sequence_t writeback_in_agent_h_rand_seq;

    typedef writeback_out_random_sequence writeback_out_agent_h_random_sequence_t;
    writeback_out_agent_h_random_sequence_t writeback_out_agent_h_rand_seq;




  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);
    writeback_in_agent_h_rand_seq = writeback_in_agent_h_random_sequence_t::type_id::create("writeback_in_agent_h_rand_seq");
    writeback_out_agent_h_rand_seq = writeback_out_agent_h_random_sequence_t::type_id::create("writeback_out_agent_h_rand_seq");


  endfunction

  virtual task body();

    if ( configuration.writeback_in_agent_h_config.sequencer != null )
       repeat (25) writeback_in_agent_h_rand_seq.start(configuration.writeback_in_agent_h_config.sequencer);
    if ( configuration.writeback_out_agent_h_config.sequencer != null )
       repeat (25) writeback_out_agent_h_rand_seq.start(configuration.writeback_out_agent_h_config.sequencer);


  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

