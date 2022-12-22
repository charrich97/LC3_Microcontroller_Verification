//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an instruction_memory
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class instruction_memory_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( instruction_memory_transaction )

  rand op_t opcode ;
  randc reg_t sr1 ;
  randc reg_t sr2 ;
  randc reg_t dr ;
  rand im_t im ;
  randc baser_t baser ;
  randc pcoffset9_t pcoffset9 ;
  randc pcoffset6_t pcoffset6 ;
  randc imm5_t imm5 ;
  randc nzp_t nzp ;
  bit [15:0] instruction ;
  rand bit complete_instr ;
  instrmem_rd_t instrmem_rd ;
  bit [16:0] PC ;
  bit I_macc ;

  //Constraints for the transaction variables:
  constraint valid_nzp_c {nzp inside {[1:7]};}

  // pragma uvmf custom class_item_additional begin
   function void post_randomize();
    if (opcode == ADD && im == 0) begin  
      instruction = {opcode, dr, sr1, im, 2'b0, sr2};
    end
    else if (opcode == ADD && im == 1)                  begin
      instruction = {opcode, dr, sr1, im, imm5};               
    end
    else if (opcode == AND && im == 0)                  begin
      instruction = {opcode, dr, sr1, im, 2'b0, sr2};
    end
    else if (opcode == AND && im == 1)                  begin
      instruction = {opcode, dr, sr1, im, imm5};
    end
    else if (opcode == NOT)                             begin
       instruction = {opcode, dr, sr1, 6'b11_1111};
    end
    else if (opcode == LD)                              begin
       instruction = {opcode, dr, pcoffset9};
    end
    else if (opcode == LDR)                             begin
       instruction = {opcode, dr, baser, pcoffset6};
    end
    else if (opcode == LDI)                             begin
       instruction = {opcode, dr, pcoffset9};
    end
    else if (opcode == LEA)                             begin
       instruction = {opcode, dr, pcoffset9};
    end
    else if (opcode == ST)                              begin
       instruction = {opcode, dr, pcoffset9};
    end
    else if (opcode == STR )                            begin
       instruction = {opcode, dr, baser, pcoffset6};
    end
    else if (opcode == STI )                            begin  
       instruction = {opcode, dr, pcoffset9};
    end
    else if (opcode == BR  )                            begin
       instruction = {opcode, nzp, pcoffset9};
    end
    else if (opcode == JMP )                            begin
      instruction = {opcode, 3'b000, baser, 6'b00_0000};
    end
  endfunction
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in instruction_memory_macros.svh

  //*******************************************************************
  // Monitor macro used by instruction_memory_monitor and instruction_memory_monitor_bfm
  // This struct is defined in instruction_memory_macros.svh
  `instruction_memory_MONITOR_STRUCT
    instruction_memory_monitor_s instruction_memory_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a instruction_memory_monitor_s
  // structure.  The function returns the handle to the instruction_memory_monitor_struct.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by instruction_memory_driver and instruction_memory_driver_bfm
  // to communicate initiator driven data to instruction_memory_driver_bfm.
  // This struct is defined in instruction_memory_macros.svh
  `instruction_memory_INITIATOR_STRUCT
    instruction_memory_initiator_s instruction_memory_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a instruction_memory_initiator_s
  // structure.  The function returns the handle to the instruction_memory_initiator_struct.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by instruction_memory_driver and instruction_memory_driver_bfm
  // to communicate Responder driven data to instruction_memory_driver_bfm.
  // This struct is defined in instruction_memory_macros.svh
  `instruction_memory_RESPONDER_STRUCT
    instruction_memory_responder_s instruction_memory_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a instruction_memory_responder_s
  // structure.  The function returns the handle to the instruction_memory_responder_struct.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in instruction_memory_macros.svh
  `instruction_memory_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("opcode:0x%x sr1:0x%x sr2:0x%x dr:0x%x im:0x%x baser:0x%x pcoffset9:0x%x pcoffset6:0x%x imm5:0x%x nzp:0x%x instruction:0x%x complete_instr:0x%x instrmem_rd:0x%x PC:0x%x I_macc:0x%x ",opcode,sr1,sr2,dr,im,baser,pcoffset9,pcoffset6,imm5,nzp,instruction,complete_instr,instrmem_rd,PC,I_macc);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    instruction_memory_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.nzp == RHS.nzp)
            &&(this.instruction == RHS.instruction)
            &&(this.complete_instr == RHS.complete_instr)
            &&(this.instrmem_rd == RHS.instrmem_rd)
            &&(this.PC == RHS.PC)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    instruction_memory_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.opcode = RHS.opcode;
    this.sr1 = RHS.sr1;
    this.sr2 = RHS.sr2;
    this.dr = RHS.dr;
    this.im = RHS.im;
    this.baser = RHS.baser;
    this.pcoffset9 = RHS.pcoffset9;
    this.pcoffset6 = RHS.pcoffset6;
    this.imm5 = RHS.imm5;
    this.nzp = RHS.nzp;
    this.instruction = RHS.instruction;
    this.complete_instr = RHS.complete_instr;
    this.instrmem_rd = RHS.instrmem_rd;
    this.PC = RHS.PC;
    this.I_macc = RHS.I_macc;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"instruction_memory_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,opcode,"opcode");
    $add_attribute(transaction_view_h,sr1,"sr1");
    $add_attribute(transaction_view_h,sr2,"sr2");
    $add_attribute(transaction_view_h,dr,"dr");
    $add_attribute(transaction_view_h,im,"im");
    $add_attribute(transaction_view_h,baser,"baser");
    $add_attribute(transaction_view_h,pcoffset9,"pcoffset9");
    $add_attribute(transaction_view_h,pcoffset6,"pcoffset6");
    $add_attribute(transaction_view_h,imm5,"imm5");
    $add_attribute(transaction_view_h,nzp,"nzp");
    $add_attribute(transaction_view_h,instruction,"instruction");
    $add_attribute(transaction_view_h,complete_instr,"complete_instr");
    $add_attribute(transaction_view_h,instrmem_rd,"instrmem_rd");
    $add_attribute(transaction_view_h,PC,"PC");
    $add_attribute(transaction_view_h,I_macc,"I_macc");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

