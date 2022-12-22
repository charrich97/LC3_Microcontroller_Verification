//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Description: This top level UVM test is the base class for all
//     future tests created for this project.
//
//     This test class contains:
//          Configuration:  The top level configuration for the project.
//          Environment:    The top level environment for the project.
//          Top_level_sequence:  The top level sequence for the project.
//                                        
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

typedef LC3_env_configuration LC3_env_configuration_t;
typedef LC3_environment LC3_environment_t;

class test_top extends uvmf_test_base #(.CONFIG_T(LC3_env_configuration_t), 
                                        .ENV_T(LC3_environment_t), 
                                        .TOP_LEVEL_SEQ_T(LC3_bench_sequence_base));

  `uvm_component_utils( test_top );



  string interface_names[] = {
    writeback_writeback_in_agent_h_BFM /* writeback_writeback_in_agent_h     [0] */ , 
    writeback_writeback_out_agent_h_BFM /* writeback_writeback_out_agent_h     [1] */ , 
    execute_agent_in_BFM /* execute_agent_in     [2] */ , 
    execute_agent_out_BFM /* execute_agent_out     [3] */ , 
    controller_controller_in_agent_inst_BFM /* controller_controller_in_agent_inst     [4] */ , 
    controller_controller_out_agent_inst_BFM /* controller_controller_out_agent_inst     [5] */ , 
    decode_decode_in_agent_inst_BFM /* decode_decode_in_agent_inst     [6] */ , 
    decode_decode_out_agent_inst_BFM /* decode_decode_out_agent_inst     [7] */ , 
    fetch_fetch_in_agent_h_BFM /* fetch_fetch_in_agent_h     [8] */ , 
    fetch_fetch_out_agent_h_BFM /* fetch_fetch_out_agent_h     [9] */ , 
    memaccess_memaccess_in_agent_h_BFM /* memaccess_memaccess_in_agent_h     [10] */ , 
    memaccess_memaccess_out_agent_h_BFM /* memaccess_memaccess_out_agent_h     [11] */ , 
    data_memory_agent_BFM /* data_memory_agent     [12] */ , 
    instruction_memory_agent_BFM /* instruction_memory_agent     [13] */ 
};

uvmf_active_passive_t interface_activities[] = { 
    PASSIVE /* writeback_writeback_in_agent_h     [0] */ , 
    PASSIVE /* writeback_writeback_out_agent_h     [1] */ , 
    PASSIVE /* execute_agent_in     [2] */ , 
    PASSIVE /* execute_agent_out     [3] */ , 
    PASSIVE /* controller_controller_in_agent_inst     [4] */ , 
    PASSIVE /* controller_controller_out_agent_inst     [5] */ , 
    PASSIVE /* decode_decode_in_agent_inst     [6] */ , 
    PASSIVE /* decode_decode_out_agent_inst     [7] */ , 
    PASSIVE /* fetch_fetch_in_agent_h     [8] */ , 
    PASSIVE /* fetch_fetch_out_agent_h     [9] */ , 
    PASSIVE /* memaccess_memaccess_in_agent_h     [10] */ , 
    PASSIVE /* memaccess_memaccess_out_agent_h     [11] */ , 
    ACTIVE /* data_memory_agent     [12] */ , 
    ACTIVE /* instruction_memory_agent     [13] */   };

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  // FUNCTION: new()
  // This is the standard systemVerilog constructor.  All components are 
  // constructed in the build_phase to allow factory overriding.
  //
  function new( string name = "", uvm_component parent = null );
     super.new( name ,parent );
  endfunction



  // ****************************************************************************
  // FUNCTION: build_phase()
  // The construction of the configuration and environment classes is done in
  // the build_phase of uvmf_test_base.  Once the configuraton and environment
  // classes are built then the initialize call is made to perform the
  // following: 
  //     Monitor and driver BFM virtual interface handle passing into agents
  //     Set the active/passive state for each agent
  // Once this build_phase completes, the build_phase of the environment is
  // executed which builds the agents.
  //
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // pragma uvmf custom configuration_settings_post_randomize end
    configuration.initialize(NA, "uvm_test_top.environment", interface_names, null, interface_activities);
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

