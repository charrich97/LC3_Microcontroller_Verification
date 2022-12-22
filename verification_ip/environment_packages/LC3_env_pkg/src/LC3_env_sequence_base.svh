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
class LC3_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( LC3_env_sequence_base #(
                           CONFIG_T
                           ) );

  
// This LC3_env_sequence_base contains a handle to a LC3_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in LC3_environment:

  // Responder agent sequencers in LC3_environment:
    // configuration.data_memory_agent_config.sequencer
    // configuration.instruction_memory_agent_config.sequencer

  // Virtual sequencers in sub-environments located in sub-environment configuration
    // configuration.writeback_config.vsqr
    // configuration.execute_config.vsqr
    // configuration.controller_config.vsqr
    // configuration.decode_config.vsqr
    // configuration.fetch_config.vsqr
    // configuration.memaccess_config.vsqr




typedef writeback_env_sequence_base #(
        .CONFIG_T(writeback_env_configuration)
        ) 
        writeback_sequence_base_t;
rand writeback_sequence_base_t writeback_seq;

typedef execute_env_sequence_base #(
        .CONFIG_T(execute_env_configuration)
        ) 
        execute_sequence_base_t;
rand execute_sequence_base_t execute_seq;

typedef controller_env_sequence_base #(
        .CONFIG_T(controller_env_configuration)
        ) 
        controller_sequence_base_t;
rand controller_sequence_base_t controller_seq;

typedef decode_env_sequence_base #(
        .CONFIG_T(decode_env_configuration)
        ) 
        decode_sequence_base_t;
rand decode_sequence_base_t decode_seq;

typedef fetch_env_sequence_base #(
        .CONFIG_T(fetch_env_configuration)
        ) 
        fetch_sequence_base_t;
rand fetch_sequence_base_t fetch_seq;

typedef memaccess_env_sequence_base #(
        .CONFIG_T(memaccess_env_configuration)
        ) 
        memaccess_sequence_base_t;
rand memaccess_sequence_base_t memaccess_seq;



  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);

    writeback_seq = writeback_sequence_base_t::type_id::create("writeback_seq");
    execute_seq = execute_sequence_base_t::type_id::create("execute_seq");
    controller_seq = controller_sequence_base_t::type_id::create("controller_seq");
    decode_seq = decode_sequence_base_t::type_id::create("decode_seq");
    fetch_seq = fetch_sequence_base_t::type_id::create("fetch_seq");
    memaccess_seq = memaccess_sequence_base_t::type_id::create("memaccess_seq");

  endfunction

  virtual task body();


    writeback_seq.start(configuration.writeback_config.vsqr);
    execute_seq.start(configuration.execute_config.vsqr);
    controller_seq.start(configuration.controller_config.vsqr);
    decode_seq.start(configuration.decode_config.vsqr);
    fetch_seq.start(configuration.fetch_config.vsqr);
    memaccess_seq.start(configuration.memaccess_config.vsqr);

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

