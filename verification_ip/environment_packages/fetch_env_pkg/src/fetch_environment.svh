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

class fetch_environment  extends uvmf_environment_base #(
    .CONFIG_T( fetch_env_configuration 
  ));
  `uvm_component_utils( fetch_environment )





  typedef fetch_in_agent  fetch_in_agent_h_t;
  fetch_in_agent_h_t fetch_in_agent_h;

  typedef fetch_out_agent  fetch_out_agent_h_t;
  fetch_out_agent_h_t fetch_out_agent_h;




  typedef fetch_predictor #(
                .CONFIG_T(CONFIG_T)
                ) fetch_predictor_h_t;
  fetch_predictor_h_t fetch_predictor_h;

  typedef uvmf_in_order_race_scoreboard #(.T(fetch_out_transaction))  fetch_scoreboard_h_t;
  fetch_scoreboard_h_t fetch_scoreboard_h;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(fetch_env_configuration)) fetch_vsqr_t;
  fetch_vsqr_t vsqr;

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
    fetch_in_agent_h = fetch_in_agent_h_t::type_id::create("fetch_in_agent_h",this);
    fetch_in_agent_h.set_config(configuration.fetch_in_agent_h_config);
    fetch_out_agent_h = fetch_out_agent_h_t::type_id::create("fetch_out_agent_h",this);
    fetch_out_agent_h.set_config(configuration.fetch_out_agent_h_config);
    fetch_predictor_h = fetch_predictor_h_t::type_id::create("fetch_predictor_h",this);
    fetch_predictor_h.configuration = configuration;
    fetch_scoreboard_h = fetch_scoreboard_h_t::type_id::create("fetch_scoreboard_h",this);

    vsqr = fetch_vsqr_t::type_id::create("vsqr", this);
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
    fetch_in_agent_h.monitored_ap.connect(fetch_predictor_h.fetch_in_ae);
    fetch_out_agent_h.monitored_ap.connect(fetch_scoreboard_h.actual_analysis_export);
    fetch_predictor_h.fetch_predictor_ap.connect(fetch_scoreboard_h.expected_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    fetch_scoreboard_h.transaction_count = fetch_scoreboard_h.transaction_count - 1;
    fetch_scoreboard_h.disable_end_of_test_empty_check();
  endfunction : extract_phase
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
     configuration.fetch_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

