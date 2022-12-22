//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the LC3 environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class LC3_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( LC3_env_configuration )


//Constraints for the configuration variables:


  covergroup LC3_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup

typedef writeback_env_configuration writeback_config_t;
rand writeback_config_t writeback_config;

typedef execute_env_configuration execute_config_t;
rand execute_config_t execute_config;

typedef controller_env_configuration controller_config_t;
rand controller_config_t controller_config;

typedef decode_env_configuration decode_config_t;
rand decode_config_t decode_config;

typedef fetch_env_configuration fetch_config_t;
rand fetch_config_t fetch_config;

typedef memaccess_env_configuration memaccess_config_t;
rand memaccess_config_t memaccess_config;


    typedef data_memory_configuration data_memory_agent_config_t;
    rand data_memory_agent_config_t data_memory_agent_config;

    typedef instruction_memory_configuration instruction_memory_agent_config_t;
    rand instruction_memory_agent_config_t instruction_memory_agent_config;


    string                writeback_interface_names[];
    uvmf_active_passive_t writeback_interface_activity[];
    string                execute_interface_names[];
    uvmf_active_passive_t execute_interface_activity[];
    string                controller_interface_names[];
    uvmf_active_passive_t controller_interface_activity[];
    string                decode_interface_names[];
    uvmf_active_passive_t decode_interface_activity[];
    string                fetch_interface_names[];
    uvmf_active_passive_t fetch_interface_activity[];
    string                memaccess_interface_names[];
    uvmf_active_passive_t memaccess_interface_activity[];


  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(LC3_env_configuration)) LC3_vsqr_t;
  LC3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );

   writeback_config = writeback_config_t::type_id::create("writeback_config");
   execute_config = execute_config_t::type_id::create("execute_config");
   controller_config = controller_config_t::type_id::create("controller_config");
   decode_config = decode_config_t::type_id::create("decode_config");
   fetch_config = fetch_config_t::type_id::create("fetch_config");
   memaccess_config = memaccess_config_t::type_id::create("memaccess_config");

    data_memory_agent_config = data_memory_agent_config_t::type_id::create("data_memory_agent_config");
    instruction_memory_agent_config = instruction_memory_agent_config_t::type_id::create("instruction_memory_agent_config");


    LC3_configuration_cg=new;
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( LC3_vsqr_t vsqr);
     this.vsqr = vsqr;
  endfunction : set_vsqr

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();
    // pragma uvmf custom post_randomize begin
    // pragma uvmf custom post_randomize end
  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    return {
     
     "\n", data_memory_agent_config.convert2string,
     "\n", instruction_memory_agent_config.convert2string,
     "\n", writeback_config.convert2string,
     "\n", execute_config.convert2string,
     "\n", controller_config.convert2string,
     "\n", decode_config.convert2string,
     "\n", fetch_config.convert2string,
     "\n", memaccess_config.convert2string

       };
    // pragma uvmf custom convert2string end
  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = {}
                                     );

    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);

  // Interface initialization for sub-environments
    writeback_interface_names    = new[2];
    writeback_interface_activity = new[2];

    writeback_interface_names     = interface_names[0:1];
    writeback_interface_activity  = interface_activity[0:1];
    execute_interface_names    = new[2];
    execute_interface_activity = new[2];

    execute_interface_names     = interface_names[2:3];
    execute_interface_activity  = interface_activity[2:3];
    controller_interface_names    = new[2];
    controller_interface_activity = new[2];

    controller_interface_names     = interface_names[4:5];
    controller_interface_activity  = interface_activity[4:5];
    decode_interface_names    = new[2];
    decode_interface_activity = new[2];

    decode_interface_names     = interface_names[6:7];
    decode_interface_activity  = interface_activity[6:7];
    fetch_interface_names    = new[2];
    fetch_interface_activity = new[2];

    fetch_interface_names     = interface_names[8:9];
    fetch_interface_activity  = interface_activity[8:9];
    memaccess_interface_names    = new[2];
    memaccess_interface_activity = new[2];

    memaccess_interface_names     = interface_names[10:11];
    memaccess_interface_activity  = interface_activity[10:11];


  // Interface initialization for local agents
     data_memory_agent_config.initialize( interface_activity[12], {environment_path,".data_memory_agent"}, interface_names[12]);
     data_memory_agent_config.initiator_responder = RESPONDER;
     data_memory_agent_config.has_coverage = 1;
     instruction_memory_agent_config.initialize( interface_activity[13], {environment_path,".instruction_memory_agent"}, interface_names[13]);
     instruction_memory_agent_config.initiator_responder = RESPONDER;
     instruction_memory_agent_config.has_coverage = 1;


     writeback_config.initialize( sim_level, {environment_path,".writeback"}, writeback_interface_names, null,   writeback_interface_activity);
     execute_config.initialize( sim_level, {environment_path,".execute"}, execute_interface_names, null,   execute_interface_activity);
     controller_config.initialize( sim_level, {environment_path,".controller"}, controller_interface_names, null,   controller_interface_activity);
     decode_config.initialize( sim_level, {environment_path,".decode"}, decode_interface_names, null,   decode_interface_activity);
     fetch_config.initialize( sim_level, {environment_path,".fetch"}, fetch_interface_names, null,   fetch_interface_activity);
     memaccess_config.initialize( sim_level, {environment_path,".memaccess"}, memaccess_interface_names, null,   memaccess_interface_activity);



  // pragma uvmf custom initialize begin
  // pragma uvmf custom initialize end

  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

