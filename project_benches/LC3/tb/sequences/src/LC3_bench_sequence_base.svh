//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//


typedef LC3_env_configuration  LC3_env_configuration_t;

class LC3_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( LC3_bench_sequence_base );

  // pragma uvmf custom sequences begin

typedef LC3_env_sequence_base #(
        .CONFIG_T(LC3_env_configuration_t)
        )
        LC3_env_sequence_base_t;
rand LC3_env_sequence_base_t LC3_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef data_memory_responder_sequence  data_memory_agent_responder_seq_t;
  data_memory_agent_responder_seq_t data_memory_agent_responder_seq;
  typedef instruction_memory_responder_sequence  instruction_memory_agent_responder_seq_t;
  instruction_memory_agent_responder_seq_t instruction_memory_agent_responder_seq;

  // Branch Sequence
  typedef instruction_memory_branch_sequence instruction_memory_agent_branch_seq_t;
  instruction_memory_agent_branch_seq_t instruction_memory_agent_branch_seq;
  // pragma uvmf custom sequences end

  // Additional Operands Sequence(PCOFFSET9, PCOFFSET6, IMM5)
  typedef instruction_memory_additional_operands_sequence  instruction_memory_agent_additional_operands_seq_t;
  instruction_memory_agent_additional_operands_seq_t instruction_memory_agent_additional_operands_seq;

  // Random Sequence(Pseudo Random Instruction Sequence)
  typedef instruction_memory_random_sequence instruction_memory_agent_random_seq_t;
  instruction_memory_agent_random_seq_t instruction_memory_agent_random_seq;

  // All Valid Instructions Sequence Listed in LC3 Design Spec
  typedef instruction_memory_all_valid_instructions_sequence instruction_memory_agent_all_valid_instructions_seq_t;
  instruction_memory_agent_all_valid_instructions_seq_t instruction_memory_agent_all_valid_instructions_seq;

  // Testing All Registers to See if Functional
  typedef instruction_memory_register_sequence instruction_memory_agent_register_seq_t;
  instruction_memory_agent_register_seq_t instruction_memory_agent_register_seq;

  // Sequencer handles for each active interface in the environment
  typedef data_memory_transaction  data_memory_agent_transaction_t;
  uvm_sequencer #(data_memory_agent_transaction_t)  data_memory_agent_sequencer; 
  typedef instruction_memory_transaction  instruction_memory_agent_transaction_t;
  uvm_sequencer #(instruction_memory_agent_transaction_t)  instruction_memory_agent_sequencer; 


  // Top level environment configuration handle
  LC3_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  writeback_in_configuration  writeback_writeback_in_agent_h_config;
  writeback_out_configuration  writeback_writeback_out_agent_h_config;
  execute_in_configuration  execute_agent_in_config;
  execute_out_configuration  execute_agent_out_config;
  controller_in_configuration  controller_controller_in_agent_inst_config;
  controller_out_configuration  controller_controller_out_agent_inst_config;
  decode_in_configuration  decode_decode_in_agent_inst_config;
  decode_out_configuration  decode_decode_out_agent_inst_config;
  fetch_in_configuration  fetch_fetch_in_agent_h_config;
  fetch_out_configuration  fetch_fetch_out_agent_h_config;
  memaccess_in_configuration  memaccess_memaccess_in_agent_h_config;
  memaccess_out_configuration  memaccess_memaccess_out_agent_h_config;
  data_memory_configuration  data_memory_agent_config;
  instruction_memory_configuration  instruction_memory_agent_config;

  // pragma uvmf custom class_item_additional begin
  `define imem_start(sequence_name) instruction_memory_agent_``sequence_name``.start(instruction_memory_agent_sequencer);
  `define dmem_start(sequence_name) data_memory_agent_``sequence_name``.start(data_memory_agent_sequencer);
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  function new( string name = "" );
    super.new( name );
    // Retrieve the configuration handles from the uvm_config_db

    // Retrieve top level configuration handle
    if ( !uvm_config_db#(LC3_env_configuration_t)::get(null,UVMF_CONFIGURATIONS, "TOP_ENV_CONFIG",top_configuration) ) begin
      `uvm_info("CFG", "*** FATAL *** uvm_config_db::get can not find TOP_ENV_CONFIG.  Are you using an older UVMF release than what was used to generate this bench?",UVM_NONE);
      `uvm_fatal("CFG", "uvm_config_db#(LC3_env_configuration_t)::get cannot find resource TOP_ENV_CONFIG");
    end

    // Retrieve config handles for all agents
    if( !uvm_config_db #( writeback_in_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_writeback_in_agent_h_BFM , writeback_writeback_in_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_in_configuration )::get cannot find resource writeback_writeback_in_agent_h_BFM" )
    if( !uvm_config_db #( writeback_out_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_writeback_out_agent_h_BFM , writeback_writeback_out_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_out_configuration )::get cannot find resource writeback_writeback_out_agent_h_BFM" )
    if( !uvm_config_db #( execute_in_configuration )::get( null , UVMF_CONFIGURATIONS , execute_agent_in_BFM , execute_agent_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_in_configuration )::get cannot find resource execute_agent_in_BFM" )
    if( !uvm_config_db #( execute_out_configuration )::get( null , UVMF_CONFIGURATIONS , execute_agent_out_BFM , execute_agent_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_out_configuration )::get cannot find resource execute_agent_out_BFM" )
    if( !uvm_config_db #( controller_in_configuration )::get( null , UVMF_CONFIGURATIONS , controller_controller_in_agent_inst_BFM , controller_controller_in_agent_inst_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_in_configuration )::get cannot find resource controller_controller_in_agent_inst_BFM" )
    if( !uvm_config_db #( controller_out_configuration )::get( null , UVMF_CONFIGURATIONS , controller_controller_out_agent_inst_BFM , controller_controller_out_agent_inst_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_out_configuration )::get cannot find resource controller_controller_out_agent_inst_BFM" )
    if( !uvm_config_db #( decode_in_configuration )::get( null , UVMF_CONFIGURATIONS , decode_decode_in_agent_inst_BFM , decode_decode_in_agent_inst_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_in_configuration )::get cannot find resource decode_decode_in_agent_inst_BFM" )
    if( !uvm_config_db #( decode_out_configuration )::get( null , UVMF_CONFIGURATIONS , decode_decode_out_agent_inst_BFM , decode_decode_out_agent_inst_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_out_configuration )::get cannot find resource decode_decode_out_agent_inst_BFM" )
    if( !uvm_config_db #( fetch_in_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_fetch_in_agent_h_BFM , fetch_fetch_in_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_in_configuration )::get cannot find resource fetch_fetch_in_agent_h_BFM" )
    if( !uvm_config_db #( fetch_out_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_fetch_out_agent_h_BFM , fetch_fetch_out_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_out_configuration )::get cannot find resource fetch_fetch_out_agent_h_BFM" )
    if( !uvm_config_db #( memaccess_in_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_memaccess_in_agent_h_BFM , memaccess_memaccess_in_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_in_configuration )::get cannot find resource memaccess_memaccess_in_agent_h_BFM" )
    if( !uvm_config_db #( memaccess_out_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_memaccess_out_agent_h_BFM , memaccess_memaccess_out_agent_h_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_out_configuration )::get cannot find resource memaccess_memaccess_out_agent_h_BFM" )
    if( !uvm_config_db #( data_memory_configuration )::get( null , UVMF_CONFIGURATIONS , data_memory_agent_BFM , data_memory_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( data_memory_configuration )::get cannot find resource data_memory_agent_BFM" )
    if( !uvm_config_db #( instruction_memory_configuration )::get( null , UVMF_CONFIGURATIONS , instruction_memory_agent_BFM , instruction_memory_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( instruction_memory_configuration )::get cannot find resource instruction_memory_agent_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    data_memory_agent_sequencer = data_memory_agent_config.get_sequencer();
    instruction_memory_agent_sequencer = instruction_memory_agent_config.get_sequencer();
    // pragma uvmf custom new begin
    LC3_env_seq = LC3_env_sequence_base_t::type_id::create("LC3_env_seq");
    data_memory_agent_responder_seq         = data_memory_agent_responder_seq_t       ::type_id::create("data_memory_agent_responder_seq"       );
    instruction_memory_agent_responder_seq  = instruction_memory_agent_responder_seq_t::type_id::create("instruction_memory_agent_responder_seq");
    
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    
    fork
      writeback_writeback_in_agent_h_config.wait_for_reset();
      writeback_writeback_out_agent_h_config.wait_for_reset();
      execute_agent_in_config.wait_for_reset();
      execute_agent_out_config.wait_for_reset();
      controller_controller_in_agent_inst_config.wait_for_reset();
      controller_controller_out_agent_inst_config.wait_for_reset();
      decode_decode_in_agent_inst_config.wait_for_reset();
      decode_decode_out_agent_inst_config.wait_for_reset();
      fetch_fetch_in_agent_h_config.wait_for_reset();
      fetch_fetch_out_agent_h_config.wait_for_reset();
      memaccess_memaccess_in_agent_h_config.wait_for_reset();
      memaccess_memaccess_out_agent_h_config.wait_for_reset();
      data_memory_agent_config.wait_for_reset();
      instruction_memory_agent_config.wait_for_reset();
    join
    // Start RESPONDER sequences here

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    //fork
    //  writeback_writeback_in_agent_h_config.wait_for_num_clocks(1000);
    //  writeback_writeback_out_agent_h_config.wait_for_num_clocks(1000);
    //  execute_agent_in_config.wait_for_num_clocks(1000);
    //  execute_agent_out_config.wait_for_num_clocks(1000);
    //  controller_controller_in_agent_inst_config.wait_for_num_clocks(1000);
    //  controller_controller_out_agent_inst_config.wait_for_num_clocks(1000);
    //  decode_decode_in_agent_inst_config.wait_for_num_clocks(1000);
    //  decode_decode_out_agent_inst_config.wait_for_num_clocks(1000);
    //  fetch_fetch_in_agent_h_config.wait_for_num_clocks(1000);
    //  fetch_fetch_out_agent_h_config.wait_for_num_clocks(1000);
    //  memaccess_memaccess_in_agent_h_config.wait_for_num_clocks(1000);
    //  memaccess_memaccess_out_agent_h_config.wait_for_num_clocks(1000);
    //  data_memory_agent_config.wait_for_num_clocks(1000);
    //  instruction_memory_agent_config.wait_for_num_clocks(1000);
    //join
    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

