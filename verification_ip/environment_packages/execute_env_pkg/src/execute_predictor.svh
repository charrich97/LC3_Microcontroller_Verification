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
//   from_in_agent_ae receives transactions of type  execute_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  pred_to_scrbd_ap broadcasts transactions of type execute_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class execute_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( execute_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_from_in_agent_ae #(execute_in_transaction, execute_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) from_in_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(execute_out_transaction) pred_to_scrbd_ap;


  // Transaction variable for predicted values to be sent out pred_to_scrbd_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef execute_out_transaction pred_to_scrbd_ap_output_transaction_t;
  pred_to_scrbd_ap_output_transaction_t pred_to_scrbd_ap_output_transaction;
  // Code for sending output transaction out through pred_to_scrbd_ap
  // pred_to_scrbd_ap.write(pred_to_scrbd_ap_output_transaction);

  // Define transaction handles for debug visibility 
  execute_in_transaction from_in_agent_ae_debug;


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

    from_in_agent_ae = new("from_in_agent_ae", this);
    pred_to_scrbd_ap =new("pred_to_scrbd_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_from_in_agent_ae
  // Transactions received through from_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_from_in_agent_ae(execute_in_transaction t);
    // pragma uvmf custom from_in_agent_ae_predictor begin
    from_in_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through from_in_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    pred_to_scrbd_ap_output_transaction = pred_to_scrbd_ap_output_transaction_t::type_id::create("pred_to_scrbd_ap_output_transaction");
 
    // Code for sending output transaction out through pred_to_scrbd_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    execute_model(  t.E_control     , 
                    t.bypass_alu_1  , 
                    t.bypass_alu_2  , 
                    t.bypass_mem_1  , 
                    t.bypass_mem_2  , 
                    t.enable_execute, 
                    t.IR            , 
                    t.npc_in        , 
                    t.Mem_Control_in, 
                    t.W_Control_in  , 
                    t.Mem_Bypass_Val, 
                    t.VSR1          , 
                    t.VSR2          , 
                    pred_to_scrbd_ap_output_transaction.aluout          , 
                    pred_to_scrbd_ap_output_transaction.W_Control_out   , 
                    pred_to_scrbd_ap_output_transaction.Mem_Control_out , 
                    pred_to_scrbd_ap_output_transaction.M_Data          , 
                    pred_to_scrbd_ap_output_transaction.dr              , 
                    pred_to_scrbd_ap_output_transaction.sr1             , 
                    pred_to_scrbd_ap_output_transaction.sr2             , 
                    pred_to_scrbd_ap_output_transaction.IR_Exec         , 
                    pred_to_scrbd_ap_output_transaction.NZP             , 
                    pred_to_scrbd_ap_output_transaction.pcout);

    pred_to_scrbd_ap.write(pred_to_scrbd_ap_output_transaction);
    // pragma uvmf custom from_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

