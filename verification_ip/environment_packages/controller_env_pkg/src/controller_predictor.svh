//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   predictor_ae receives transactions of type  controller_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  predictor_ap broadcasts transactions of type controller_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class controller_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( controller_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_predictor_ae #(controller_in_transaction, controller_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) predictor_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(controller_out_transaction) predictor_ap;


  // Transaction variable for predicted values to be sent out predictor_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef controller_out_transaction predictor_ap_output_transaction_t;
  predictor_ap_output_transaction_t predictor_ap_output_transaction;
  // Code for sending output transaction out through predictor_ap
  // predictor_ap.write(predictor_ap_output_transaction);

  // Define transaction handles for debug visibility 
  controller_in_transaction predictor_ae_debug;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    predictor_ae = new("predictor_ae", this);
    predictor_ap =new("predictor_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_predictor_ae
  // Transactions received through predictor_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_predictor_ae(controller_in_transaction t);
    // pragma uvmf custom predictor_ae_predictor begin
    predictor_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through predictor_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    predictor_ap_output_transaction = predictor_ap_output_transaction_t::type_id::create("predictor_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    void'(controller_model(
                            t.complete_data_trans_var                                   ,
                            t.complete_instr_trans_var                                  ,
                            t.IR_trans_var                                              ,
                            t.psr_trans_var                                             ,
                            t.IR_Exec_trans_var                                         ,
                            t.IMem_dout_trans_var                                       ,
                            t.NZP_trans_var                                             ,
                            predictor_ap_output_transaction.enable_updatePC_trans_var   ,    
                            predictor_ap_output_transaction.enable_fetch_trans_var      ,    
                            predictor_ap_output_transaction.enable_decode_trans_var     ,    
                            predictor_ap_output_transaction.enable_execute_trans_var    ,    
                            predictor_ap_output_transaction.enable_writeback_trans_var  ,
                            predictor_ap_output_transaction.bypass_alu_1_trans_var      ,    
                            predictor_ap_output_transaction.bypass_alu_2_trans_var      ,    
                            predictor_ap_output_transaction.bypass_mem_1_trans_var      ,    
                            predictor_ap_output_transaction.bypass_mem_2_trans_var      ,    
                            predictor_ap_output_transaction.mem_state_trans_var         ,
                            predictor_ap_output_transaction.br_taken_trans_var              
    ));       
 
    // Code for sending output transaction out through predictor_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    predictor_ap.write(predictor_ap_output_transaction);
    // pragma uvmf custom predictor_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

