//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class LC3_environment  extends uvmf_environment_base #(
    .CONFIG_T( LC3_env_configuration 
  ));
  `uvm_component_utils( LC3_environment )

  typedef writeback_environment writeback_t;
  writeback_t writeback;
   
  typedef execute_environment execute_t;
  execute_t execute;
   
  typedef controller_environment controller_t;
  controller_t controller;
   
  typedef decode_environment decode_t;
  decode_t decode;
   
  typedef fetch_environment fetch_t;
  fetch_t fetch;
   
  typedef memaccess_environment memaccess_t;
  memaccess_t memaccess;
   




  typedef data_memory_agent  data_memory_agent_t;
  data_memory_agent_t data_memory_agent;

  typedef instruction_memory_agent  instruction_memory_agent_t;
  instruction_memory_agent_t instruction_memory_agent;








  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(LC3_env_configuration)) LC3_vsqr_t;
  LC3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    writeback = writeback_t::type_id::create("writeback",this);
    writeback.set_config(configuration.writeback_config);
    execute = execute_t::type_id::create("execute",this);
    execute.set_config(configuration.execute_config);
    controller = controller_t::type_id::create("controller",this);
    controller.set_config(configuration.controller_config);
    decode = decode_t::type_id::create("decode",this);
    decode.set_config(configuration.decode_config);
    fetch = fetch_t::type_id::create("fetch",this);
    fetch.set_config(configuration.fetch_config);
    memaccess = memaccess_t::type_id::create("memaccess",this);
    memaccess.set_config(configuration.memaccess_config);
    data_memory_agent = data_memory_agent_t::type_id::create("data_memory_agent",this);
    data_memory_agent.set_config(configuration.data_memory_agent_config);
    instruction_memory_agent = instruction_memory_agent_t::type_id::create("instruction_memory_agent",this);
    instruction_memory_agent.set_config(configuration.instruction_memory_agent_config);

    vsqr = LC3_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.LC3_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

