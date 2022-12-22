//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records instruction_memory transaction information using
//       a covergroup named instruction_memory_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class instruction_memory_transaction_coverage  extends uvm_subscriber #(.T(instruction_memory_transaction ));

  `uvm_component_utils( instruction_memory_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  covergroup instruction_memory_transaction_opcode_cg;
    option.auto_bin_max=1024;
    option.per_instance=1;
    ALU_OPS_cp                                        : coverpoint coverage_trans.instruction[15:12] 
    {
      bins ADD_bin          = {4'b0001};
      bins AND_bin          = {4'b0101};
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
  endgroup : instruction_memory_transaction_opcode_cg
    
  covergroup instruction_memory_transaction_register_cg;
    option.per_instance=1;
    DR_cp                                             : coverpoint coverage_trans.instruction[11:9] iff ( (coverage_trans.instruction[15:12] == 0001) ||
                                                                                                          (coverage_trans.instruction[15:12] == 0101) ||
                                                                                                          (coverage_trans.instruction[15:12] == 1001) ||
                                                                                                          (coverage_trans.instruction[15:12] == 0010) ||
                                                                                                          (coverage_trans.instruction[15:12] == 0110) ||
                                                                                                          (coverage_trans.instruction[15:12] == 1010) ||
                                                                                                          (coverage_trans.instruction[15:12] == 1110))
    {
      bins DR0_bin          = {3'b000};
      bins DR1_bin          = {3'b001};
      bins DR2_bin          = {3'b010};
      bins DR3_bin          = {3'b011};
      bins DR4_bin          = {3'b100};
      bins DR5_bin          = {3'b101};
      bins DR6_bin          = {3'b110};
      bins DR7_bin          = {3'b111};
    }
    
    SR1_cp                                          : coverpoint coverage_trans.instruction[8:6] iff (( coverage_trans.instruction[15:12] == 0001) ||
                                                                                                      ( coverage_trans.instruction[15:12] == 0101) ||
                                                                                                      ( coverage_trans.instruction[15:12] == 1001)) 
    {
      bins SR1_0_bin        = {3'b000};
      bins SR1_1_bin        = {3'b001};
      bins SR1_2_bin        = {3'b010};
      bins SR1_3_bin        = {3'b011};
      bins SR1_4_bin        = {3'b100};
      bins SR1_5_bin        = {3'b101};
      bins SR1_6_bin        = {3'b110};
      bins SR1_7_bin        = {3'b111};
    }
  
    SR2_cp                                          : coverpoint coverage_trans.instruction[2:0] iff (( ( coverage_trans.instruction[15:12] == 0001)  ||
                                                                                                        ( coverage_trans.instruction[15:12] == 0101)) &&
                                                                                                        ( coverage_trans.instruction[5]     == 0))
    {
      bins SR2_0_bin    = {3'b000};
      bins SR2_1_bin    = {3'b001};
      bins SR2_2_bin    = {3'b010};
      bins SR2_3_bin    = {3'b011};
      bins SR2_4_bin    = {3'b100};
      bins SR2_5_bin    = {3'b101};
      bins SR2_6_bin    = {3'b110};
      bins SR2_7_bin    = {3'b111};
    }

   SR_cp                                            : coverpoint coverage_trans.instruction[11:9] iff ((  coverage_trans.instruction[15:12] == 0011) ||
                                                                                                       (  coverage_trans.instruction[15:12] == 0111) ||
                                                                                                       (  coverage_trans.instruction[15:12] == 1011))
    {
      bins SR_0_bin     = {3'b000};
      bins SR_1_bin     = {3'b001};
      bins SR_2_bin     = {3'b010};
      bins SR_3_bin     = {3'b011};
      bins SR_4_bin     = {3'b100};
      bins SR_5_bin     = {3'b101};
      bins SR_6_bin     = {3'b110};
      bins SR_7_bin     = {3'b111};
    }
    BaseR_cp                                        : coverpoint coverage_trans.instruction[8:6] iff  ((coverage_trans.instruction[15:12] == 4'b0110  ) || 
                                                                                                       (coverage_trans.instruction[15:12] == 4'b1100  ) || 
                                                                                                       (coverage_trans.instruction[15:12] == 4'b0111  ))
    {
    bins BaseR0 = {3'b000};
    bins BaseR1 = {3'b001};
    bins BaseR2 = {3'b010};
    bins BaseR3 = {3'b011};
    bins BaseR4 = {3'b100};
    bins BaseR5 = {3'b101};
    bins BaseR6 = {3'b110};
    bins BaseR7 = {3'b111}; 
    }  
  endgroup : instruction_memory_transaction_register_cg
    
  covergroup instruction_memory_transaction_additional_operands_cg;
    option.per_instance=1;
    IMM5_cp                                         : coverpoint coverage_trans.instruction[4:0]  iff ((( coverage_trans.instruction[15:12] == 0001)  ||
                                                                                                      (   coverage_trans.instruction[15:12] == 0101)) &&
                                                                                                      (   coverage_trans.instruction[5]     == 1))
    {
      bins IMM5_bin[16] = {[0:15]};
    }
    

  
    PCOFFSET6_cp                                    : coverpoint coverage_trans.instruction[5:0]  iff ((coverage_trans.instruction[15:12] == 0000)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 0010)  || 
                                                                                                       (coverage_trans.instruction[15:12] == 0110)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 0111))  
    {
     bins PCOFFSET6_bin[32]   = {[0:31]};
    } 

    PCOFFSET9_cp                                    : coverpoint coverage_trans.instruction[8:0]  iff ((coverage_trans.instruction[15:12] == 0010)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 1010)  || 
                                                                                                       (coverage_trans.instruction[15:12] == 1110)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 0011)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 0011)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 1011)  ||
                                                                                                       (coverage_trans.instruction[15:12] == 0000))
    {
     bins PCOFFSET9_bin[512]  = {[0:511]};
    } 
  endgroup : instruction_memory_transaction_additional_operands_cg
                                                                                                       
  covergroup instruction_memory_transaction_branch_conditions_cg;
    BR_NZP_cp                                       : coverpoint coverage_trans.instruction[11:9]  iff (coverage_trans.instruction[15:12] == 0000)
    {
      bins BRNP           = {3'b101};
      bins BRZ            = {3'b010};
      bins BRP            = {3'b001};
      bins BRNZ           = {3'b110};
      bins BRZP           = {3'b011};
      bins BRN            = {3'b100};
      bins BRNZP          = {3'b111};
    }
  endgroup : instruction_memory_transaction_branch_conditions_cg 
  
  covergroup instruction_memory_transaction_all_valid_instructions_cg;
  option.per_instance = 1;
  Valid_ADD_SR1_Instructions_cp                     : coverpoint coverage_trans.instruction[2:0]  iff((coverage_trans.instruction[15:12] == 'b0001) && (coverage_trans.instruction[5] == 0))
  {
    bins ADD_bin      [8]        = {[0  :7   ]};
  }  

  Valid_ADD_SR2_DR_Instructions_cp                  : coverpoint coverage_trans.instruction[11:6] iff((coverage_trans.instruction[15:12] == 'b0001) && (coverage_trans.instruction[5] == 0)) 
  {
    bins ADD_bin      [64]       = {[0  :63   ]};
  }  

  Valid_ADD_IMM5_imm5_Instructions_cp               : coverpoint coverage_trans.instruction[4:0]  iff((coverage_trans.instruction[15:12] == 'b0001) && (coverage_trans.instruction[5] == 1)) 
  {
    bins ADD_IMM5_bin [32]       = {[0  :31   ]};
  }
    
  Valid_ADD_IMM5_SR2_DR_Instructions_cp             : coverpoint coverage_trans.instruction[11:6] iff((coverage_trans.instruction[15:12] == 'b0001) && (coverage_trans.instruction[5] == 1)) 
  {
    bins ADD_bin      [64]       = {[0  :63   ]};
  }  
  
  Valid_ADD_cross       : cross Valid_ADD_SR1_Instructions_cp         , Valid_ADD_SR2_DR_Instructions_cp       ;
  Valid_ADD_IMM5_cross  : cross Valid_ADD_IMM5_imm5_Instructions_cp   , Valid_ADD_IMM5_SR2_DR_Instructions_cp  ;

  Valid_AND_SR1_Instructions_cp                     : coverpoint coverage_trans.instruction[2:0]  iff((coverage_trans.instruction[15:12] == 'b0101) && (coverage_trans.instruction[5] == 0))
  {
    bins AND_bin      [8]        = {[0  :7   ]};
  }  

  Valid_AND_SR2_DR_Instructions_cp                  : coverpoint coverage_trans.instruction[11:6] iff((coverage_trans.instruction[15:12] == 'b0101) && (coverage_trans.instruction[5] == 0)) 
  {
    bins AND_bin      [64]       = {[0  :63   ]};
  }  

  Valid_AND_IMM5_imm5_Instructions_cp               : coverpoint coverage_trans.instruction[4:0]  iff((coverage_trans.instruction[15:12] == 'b0101) && (coverage_trans.instruction[5] == 1)) 
  {
    bins AND_IMM5_bin [32]       = {[0  :31   ]};
  }
  Valid_AND_IMM5_SR2_DR_Instructions_cp             : coverpoint coverage_trans.instruction[11:6] iff((coverage_trans.instruction[15:12] == 'b0101) && (coverage_trans.instruction[5] == 1)) 
  {
    bins AND_bin      [64]       = {[0  :63   ]};
  }  
  Valid_AND_cross       : cross Valid_AND_SR1_Instructions_cp         , Valid_AND_SR2_DR_Instructions_cp       ;
  Valid_AND_IMM5_cross  : cross Valid_AND_IMM5_imm5_Instructions_cp   , Valid_AND_IMM5_SR2_DR_Instructions_cp  ;

  Valid_NOT_Instructions_cp                         : coverpoint coverage_trans.instruction[15:6] iff((coverage_trans.instruction[15:12] == 'b1001) && (coverage_trans.instruction[5:0] == 'b111111)) 
  {
    bins NOT_bin      [64]      = {[576    :639  ]};
  }

  Valid_LD_Instructions_cp                          : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b0010)
  {
    bins LD_bin       [4096]     = {[8192  :12287  ]};
  }
  
  Valid_LDR_Instructions_cp                         : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b0110)
  {
    bins LDR_bin      [4096]     = {[24576 :28671  ]};
  }
  Valid_LDI_Instructions_cp                         : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b1010) 
  {
    bins LDI_bin      [4096]     = {[40960 :45055  ]};
  }

  Valid_LEA_Instructions_cp                         : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b1110)
  {
    bins LEA_bin      [4096]     = {[57344 :61439  ]};
  }
  Valid_ST_Instructions_cp                          : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b0011) 
  {
    bins ST_bin       [4096]     = {[12288 :16383  ]};
  }
   
  Valid_STR_Instructions_cp                         : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b0111) 
  {
    bins STR_bin      [4096]     = {[28672 :32767  ]};
  }
  
  Valid_STI_Instructions_cp                         : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b1011)
  {
    bins STI_bin      [4096]     = {[45056 :49151  ]};
  }

  Valid_BR_Instructions_cp                          : coverpoint coverage_trans.instruction       iff(coverage_trans.instruction[15:12] == 'b0000) 
  {
    bins BR_bin       [3584]     = {[512   :4095   ]};
  }
  
  Valid_JMP_Instructions_cp                         : coverpoint coverage_trans.instruction[8:6]  iff(coverage_trans.instruction[15:12] == 'b1100)
  {
    bins JMP_bin      [8]       = {[0:7]};
  } 
  endgroup : instruction_memory_transaction_all_valid_instructions_cg
    // pragma uvmf custom covergroup end

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    instruction_memory_transaction_opcode_cg                          =new;
    instruction_memory_transaction_register_cg                        =new;
    instruction_memory_transaction_additional_operands_cg             =new;
    instruction_memory_transaction_branch_conditions_cg               =new;
    instruction_memory_transaction_all_valid_instructions_cg          =new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    instruction_memory_transaction_opcode_cg.set_inst_name($sformatf("instruction_memory_transaction_opcode_cg_%s"                                    ,get_full_name()));
    instruction_memory_transaction_register_cg.set_inst_name($sformatf("instruction_memory_transaction_register_cg_%s"                                ,get_full_name()));
    instruction_memory_transaction_additional_operands_cg.set_inst_name($sformatf("instruction_memory_transaction_additional_operands_cg_%s"          ,get_full_name()));
    instruction_memory_transaction_branch_conditions_cg.set_inst_name($sformatf("instruction_memory_transaction_branch_conditions_cg_%s"              ,get_full_name()));
    instruction_memory_transaction_all_valid_instructions_cg.set_inst_name($sformatf("instruction_memory_transaction_all_valid_instructions_cg_%s"    ,get_full_name()));
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
    instruction_memory_transaction_opcode_cg.sample();
    instruction_memory_transaction_register_cg.sample();
    instruction_memory_transaction_additional_operands_cg.sample();
    instruction_memory_transaction_branch_conditions_cg.sample();
    instruction_memory_transaction_all_valid_instructions_cg.sample();
  
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

