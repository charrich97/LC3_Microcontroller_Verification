//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records execute_in transaction information using
//       a covergroup named execute_in_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class execute_in_transaction_coverage  extends uvm_subscriber #(.T(execute_in_transaction ));

  `uvm_component_utils( execute_in_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup execute_in_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    E_control: coverpoint coverage_trans.E_control;
    IR: coverpoint coverage_trans.IR;
    npc_in: coverpoint coverage_trans.npc_in;
    bypass_alu_1: coverpoint coverage_trans.bypass_alu_1;
    bypass_alu_2: coverpoint coverage_trans.bypass_alu_2;
    bypass_mem_1: coverpoint coverage_trans.bypass_mem_1;
    bypass_mem_2: coverpoint coverage_trans.bypass_mem_2;
    VSR1: coverpoint coverage_trans.VSR1;
    VSR2: coverpoint coverage_trans.VSR2;
    W_Control_in: coverpoint coverage_trans.W_Control_in;
    Mem_Control_in: coverpoint coverage_trans.Mem_Control_in;
    enable_execute: coverpoint coverage_trans.enable_execute;
    Mem_Bypass_Val: coverpoint coverage_trans.Mem_Bypass_Val;
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    execute_in_transaction_cg=new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    execute_in_transaction_cg.set_inst_name($sformatf("execute_in_transaction_cg_%s",get_full_name()));
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
    execute_in_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

