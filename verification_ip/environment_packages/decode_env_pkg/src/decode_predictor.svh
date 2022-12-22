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
//   predictor_ae receives transactions of type  decode_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  predictor_ap broadcasts transactions of type decode_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class decode_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( decode_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_predictor_ae #(decode_in_transaction, decode_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) predictor_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(decode_out_transaction) predictor_ap;


  // Transaction variable for predicted values to be sent out predictor_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef decode_out_transaction predictor_ap_output_transaction_t;
  predictor_ap_output_transaction_t predictor_ap_output_transaction;
  // Code for sending output transaction out through predictor_ap
  // predictor_ap.write(predictor_ap_output_transaction);

  // Define transaction handles for debug visibility 
  decode_in_transaction predictor_ae_debug;


  // pragma uvmf custom class_item_additional begin
  bit       Mem_control ;
  bit [1:0] W_control   ;
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
  virtual function void write_predictor_ae(decode_in_transaction t);
    // pragma uvmf custom predictor_ae_predictor begin
    predictor_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through predictor_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    predictor_ap_output_transaction = predictor_ap_output_transaction_t::type_id::create("predictor_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    void'(decode_model( 
                        t.instruction                                 ,
                        t.npc_in                                      ,
                        predictor_ap_output_transaction.IR            ,
                        predictor_ap_output_transaction.npc_out       ,
                        predictor_ap_output_transaction.E_control     ,
                        W_control                                     ,
                        Mem_control
                      ));
    $cast(predictor_ap_output_transaction.opcode      , predictor_ap_output_transaction.IR[15:12])                            ;
    predictor_ap_output_transaction.sr1               = predictor_ap_output_transaction.IR[8:6]                               ; 
    predictor_ap_output_transaction.sr2               = predictor_ap_output_transaction.IR[2:0]                               ;
    predictor_ap_output_transaction.dr                = predictor_ap_output_transaction.IR[11:9]                              ;
    predictor_ap_output_transaction.baser             = predictor_ap_output_transaction.IR[8:6]                               ;
    predictor_ap_output_transaction.pcoffset9         = predictor_ap_output_transaction.IR[8:0]                               ;
    predictor_ap_output_transaction.pcoffset6         = predictor_ap_output_transaction.IR[5:0]                               ; 
    predictor_ap_output_transaction.imm5              = predictor_ap_output_transaction.IR[4:0]                               ;
    predictor_ap_output_transaction.n                 = predictor_ap_output_transaction.IR[11]                                ;
    predictor_ap_output_transaction.z                 = predictor_ap_output_transaction.IR[10]                                ;
    predictor_ap_output_transaction.p                 = predictor_ap_output_transaction.IR[9]                                 ;
    $cast(predictor_ap_output_transaction.W_control   , W_control)                                                            ;
    $cast(predictor_ap_output_transaction.Mem_control , Mem_control)                                                          ;
 
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

