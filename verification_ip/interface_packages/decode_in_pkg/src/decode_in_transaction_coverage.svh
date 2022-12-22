//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records decode_in transaction information using
//       a covergroup named decode_in_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class decode_in_transaction_coverage  extends uvm_subscriber #(.T(decode_in_transaction ));

  `uvm_component_utils( decode_in_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup decode_in_transaction_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    option.per_instance=1;
    ALU_OPS_cp                                        : coverpoint coverage_trans.instruction[15:12] 
    {
      bins ADD_bin          = {4'b0001};
      bins ADD_imm5_bin     = {4'b0001};
      bins AND_bin          = {4'b0101};
      bins AND_imm5_bin     = {4'b0101};
      bins NOT_bin          = {4'b1001};
    }  

    MEM_OPS_cp                                        : coverpoint coverage_trans.instruction[15:12]
    {
      bins LD_bin           = {4'b0010};
      bins LDR_bin          = {4'b0110};
      bins LDI_bin          = {4'b1010};
      bins LEA_bin          = {4'b1110};
      bins ST_bin           = {4'b0011};
      bins STR_bin          = {4'b0111};
      bins STI_bin          = {4'b1011};
    }
    
    CTRL_OPS_cp                                       : coverpoint coverage_trans.instruction[15:12]
    {
      bins BR_bin           = {4'b0000};
      bins JMP_bin          = {4'b1100};
    }
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    decode_in_transaction_cg=new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    decode_in_transaction_cg.set_inst_name($sformatf("decode_in_transaction_cg_%s",get_full_name()));
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
    decode_in_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

