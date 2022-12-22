//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records controller_out transaction information using
//       a covergroup named controller_out_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class controller_out_transaction_coverage  extends uvm_subscriber #(.T(controller_out_transaction ));

  `uvm_component_utils( controller_out_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup controller_out_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    enable_updatePC_trans_var: coverpoint coverage_trans.enable_updatePC_trans_var;
    enable_fetch_trans_var: coverpoint coverage_trans.enable_fetch_trans_var;
    enable_decode_trans_var: coverpoint coverage_trans.enable_decode_trans_var;
    enable_execute_trans_var: coverpoint coverage_trans.enable_execute_trans_var;
    enable_writeback_trans_var: coverpoint coverage_trans.enable_writeback_trans_var;
    bypass_alu_1_trans_var: coverpoint coverage_trans.bypass_alu_1_trans_var;
    bypass_alu_2_trans_var: coverpoint coverage_trans.bypass_alu_2_trans_var;
    bypass_mem_1_trans_var: coverpoint coverage_trans.bypass_mem_1_trans_var;
    bypass_mem_2_trans_var: coverpoint coverage_trans.bypass_mem_2_trans_var;
    mem_state_trans_var: coverpoint coverage_trans.mem_state_trans_var;
    br_taken_trans_var: coverpoint coverage_trans.br_taken_trans_var;
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    controller_out_transaction_cg=new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    controller_out_transaction_cg.set_inst_name($sformatf("controller_out_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    controller_out_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

