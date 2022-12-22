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
//   observed_memaccess_in receives transactions of type  memaccess_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  pred_memaccess_out broadcasts transactions of type memaccess_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class memaccess_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( memaccess_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_observed_memaccess_in #(memaccess_in_transaction, memaccess_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) observed_memaccess_in;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(memaccess_out_transaction) pred_memaccess_out;


  // Transaction variable for predicted values to be sent out pred_memaccess_out
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef memaccess_out_transaction pred_memaccess_out_output_transaction_t;
  pred_memaccess_out_output_transaction_t pred_memaccess_out_output_transaction;
  // Code for sending output transaction out through pred_memaccess_out
  // pred_memaccess_out.write(pred_memaccess_out_output_transaction);

  // Define transaction handles for debug visibility 
  memaccess_in_transaction observed_memaccess_in_debug;


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

    observed_memaccess_in = new("observed_memaccess_in", this);
    pred_memaccess_out =new("pred_memaccess_out", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_observed_memaccess_in
  // Transactions received through observed_memaccess_in initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_observed_memaccess_in(memaccess_in_transaction t);
    // pragma uvmf custom observed_memaccess_in_predictor begin
    observed_memaccess_in_debug = t;
    `uvm_info("PRED", "Transaction Received through observed_memaccess_in", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    pred_memaccess_out_output_transaction = pred_memaccess_out_output_transaction_t::type_id::create("pred_memaccess_out_output_transaction");
      
            mem_access_model(t.M_Data    ,
                             t.M_addr    ,
                             t.M_control , 
                             t.mem_state , 
                             t.DMem_dout , 
                             pred_memaccess_out_output_transaction.DMem_addr, 
                             pred_memaccess_out_output_transaction.DMem_din, 
                             pred_memaccess_out_output_transaction.memout, 
                             pred_memaccess_out_output_transaction.DMem_rd
                         );
 
    // Code for sending output transaction out through pred_memaccess_out
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    pred_memaccess_out.write(pred_memaccess_out_output_transaction);
    // pragma uvmf custom observed_memaccess_in_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

