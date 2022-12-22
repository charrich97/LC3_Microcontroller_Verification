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
//   writeback_in_ae receives transactions of type  writeback_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  writeback_out_ap broadcasts transactions of type writeback_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class writeback_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( writeback_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_writeback_in_ae #(writeback_in_transaction, writeback_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) writeback_in_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(writeback_out_transaction) writeback_out_ap;
  bit writeback_model_return_type;

  // Transaction variable for predicted values to be sent out writeback_out_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef writeback_out_transaction writeback_out_ap_output_transaction_t;
  writeback_out_ap_output_transaction_t writeback_out_ap_output_transaction;
  // Code for sending output transaction out through writeback_out_ap
  // writeback_out_ap.write(writeback_out_ap_output_transaction);

  // Define transaction handles for debug visibility 
  writeback_in_transaction writeback_in_ae_debug;


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

    writeback_in_ae = new("writeback_in_ae", this);
    writeback_out_ap =new("writeback_out_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_writeback_in_ae
  // Transactions received through writeback_in_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_writeback_in_ae(writeback_in_transaction t);
    // pragma uvmf custom writeback_in_ae_predictor begin
    writeback_in_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through writeback_in_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    writeback_out_ap_output_transaction = writeback_out_ap_output_transaction_t::type_id::create("writeback_out_ap_output_transaction");
 
    // Code for sending output transaction out through writeback_out_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.

    writeback_model
    ( 
    t.aluout                                  ,
    t.W_control                               ,
    t.npc                                     ,
    t.pcout                                   ,
    t.memout                                  ,
    t.enable_writeback                        ,
    t.sr1                                     ,
    t.sr2                                     ,
    t.dr                                      ,
    writeback_out_ap_output_transaction.VSR1  ,
    writeback_out_ap_output_transaction.VSR2  ,
    writeback_out_ap_output_transaction.psr   
    );

    writeback_out_ap.write(writeback_out_ap_output_transaction);
    // pragma uvmf custom writeback_in_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

