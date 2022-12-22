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

class decode_environment  extends uvmf_environment_base #(
    .CONFIG_T( decode_env_configuration 
  ));
  `uvm_component_utils( decode_environment )





  typedef decode_in_agent  decode_in_agent_inst_t;
  decode_in_agent_inst_t decode_in_agent_inst;

  typedef decode_out_agent  decode_out_agent_inst_t;
  decode_out_agent_inst_t decode_out_agent_inst;




  typedef decode_predictor #(
                .CONFIG_T(CONFIG_T)
                ) decode_predictor_inst_t;
  decode_predictor_inst_t decode_predictor_inst;

  typedef uvmf_in_order_race_scoreboard #(.T(decode_out_transaction))  decode_scoreboard_inst_t;
  decode_scoreboard_inst_t decode_scoreboard_inst;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(decode_env_configuration)) decode_vsqr_t;
  decode_vsqr_t vsqr;

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
    decode_in_agent_inst = decode_in_agent_inst_t::type_id::create("decode_in_agent_inst",this);
    decode_in_agent_inst.set_config(configuration.decode_in_agent_inst_config);
    decode_out_agent_inst = decode_out_agent_inst_t::type_id::create("decode_out_agent_inst",this);
    decode_out_agent_inst.set_config(configuration.decode_out_agent_inst_config);
    decode_predictor_inst = decode_predictor_inst_t::type_id::create("decode_predictor_inst",this);
    decode_predictor_inst.configuration = configuration;
    decode_scoreboard_inst = decode_scoreboard_inst_t::type_id::create("decode_scoreboard_inst",this);

    vsqr = decode_vsqr_t::type_id::create("vsqr", this);
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
    decode_in_agent_inst.monitored_ap.connect(decode_predictor_inst.predictor_ae);
    decode_out_agent_inst.monitored_ap.connect(decode_scoreboard_inst.actual_analysis_export);
    decode_predictor_inst.predictor_ap.connect(decode_scoreboard_inst.expected_analysis_export);
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
     configuration.decode_configuration_cg.sample();
     decode_scoreboard_inst.disable_end_of_test_empty_check();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

