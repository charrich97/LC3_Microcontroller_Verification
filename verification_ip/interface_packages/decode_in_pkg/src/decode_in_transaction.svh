//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an decode_in
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class decode_in_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( decode_in_transaction )

  enable_decode_t enable_decode ;
  rand op_t opcode ;
  rand reg_t sr1 ;
  rand reg_t sr2 ;
  rand reg_t dr ;
  rand im_t im ;
  rand baser_t baser ;
  rand pcoffset9_t pcoffset9 ;
  rand pcoffset6_t pcoffset6 ;
  rand imm5_t imm5 ;
  rand n_t n ;
  rand z_t z ;
  rand p_t p ;
  bit [15:0] instruction ;
  rand bit [15:0] npc_in ;
  bit [2:0] psr ;

  //Constraints for the transaction variables:
  constraint valid_opcode_c {opcode inside {ADD, AND, NOT, LD, LDR, LDI, LEA, ST, STR, STI, BR, JMP};}
  constraint valid_Instr_dout_dr_c {dr inside {[0:7]};}
  constraint valid_Instr_dout_sr1_c {sr1 inside {[0:7]};}
  constraint valid_Instr_dout_sr2_c {sr2 inside {[0:7]};}

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
       instruction = {opcode, n,z,p, pcoffset9};
    end
    else if (opcode == JMP )                            begin
      instruction = {opcode, 3'b000, baser, 6'b00_0000};
    end
    psr = {n,z,p}; 
  endfunction
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in decode_in_macros.svh

  //*******************************************************************
  // Monitor macro used by decode_in_monitor and decode_in_monitor_bfm
  // This struct is defined in decode_in_macros.svh
  `decode_in_MONITOR_STRUCT
    decode_in_monitor_s decode_in_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a decode_in_monitor_s
  // structure.  The function returns the handle to the decode_in_monitor_struct.
  // This function is defined in decode_in_macros.svh
  `decode_in_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_in_macros.svh
  `decode_in_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by decode_in_driver and decode_in_driver_bfm
  // to communicate initiator driven data to decode_in_driver_bfm.
  // This struct is defined in decode_in_macros.svh
  `decode_in_INITIATOR_STRUCT
    decode_in_initiator_s decode_in_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a decode_in_initiator_s
  // structure.  The function returns the handle to the decode_in_initiator_struct.
  // This function is defined in decode_in_macros.svh
  `decode_in_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_in_macros.svh
  `decode_in_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by decode_in_driver and decode_in_driver_bfm
  // to communicate Responder driven data to decode_in_driver_bfm.
  // This struct is defined in decode_in_macros.svh
  `decode_in_RESPONDER_STRUCT
    decode_in_responder_s decode_in_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a decode_in_responder_s
  // structure.  The function returns the handle to the decode_in_responder_struct.
  // This function is defined in decode_in_macros.svh
  `decode_in_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_in_macros.svh
  `decode_in_FROM_RESPONDER_STRUCT_FUNCTION 
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
    string str = "";
      str = {str, $sformatf("\n************Decode In Transaction************\n"         )}; 
    if ((opcode == ADD || opcode == AND) && im == 0) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT DR        : %b  \n", dr                         )};
      str = {str, $sformatf("INSTR_DOUT SR1       : %b  \n", sr1                        )};
      str = {str, $sformatf("INSTR_DOUT IM        : %b  \n", im                         )};
      str = {str, $sformatf("INSTR_DOUT SR2       : %b  \n", sr2                        )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if ((opcode == ADD || opcode == AND) && im == 1) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT DR        : %b  \n", dr                         )};
      str = {str, $sformatf("INSTR_DOUT SR1       : %b  \n", sr1                        )};
      str = {str, $sformatf("INSTR_DOUT IM        : %b  \n", im                         )};
      str = {str, $sformatf("INSTR_DOUT IMM5      : %b  \n", imm5                       )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if (opcode == NOT) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT DR        : %b  \n", dr                         )};
      str = {str, $sformatf("INSTR_DOUT SR1       : %b  \n", sr1                        )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if (opcode == LD || opcode == LDI || opcode == LEA || opcode == ST || opcode == STI) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT DR        : %b  \n", dr                         )};
      str = {str, $sformatf("INSTR_DOUT PCOFFSET9 : %b  \n", pcoffset9                  )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if (opcode == LDR || opcode == STR) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT DR        : %b  \n", dr                         )};
      str = {str, $sformatf("INSTR_DOUT BaseR     : %b  \n", baser                      )};
      str = {str, $sformatf("INSTR_DOUT PCOFFSET6 : %b  \n", pcoffset6                  )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if (opcode == BR) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT NZP       : %b  \n", {n,z,p}                    )};
      str = {str, $sformatf("INSTR_DOUT PCOFFSET9 : %b  \n", pcoffset9                  )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
    if (opcode == JMP) begin
      str = {str, $sformatf("ENABLE DECODE        : %b  \n", enable_decode              )}; 
      str = {str, $sformatf("INSTR_DOUT OPCODE    : %0s \n", opcode.name()              )};
      str = {str, $sformatf("INSTR_DOUT BaseR     : %b  \n", baser                      )};
      str = {str, $sformatf("PSR                  : %b  \n", psr                        )};
      str = {str, $sformatf("NPC_IN               : %d  \n", npc_in                     )};
    end
      str = {str, $sformatf("******************************************\n"              )};
      str = {str, $sformatf("Time: %t \n", $time)};

    return str;
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
    decode_in_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.instruction == RHS.instruction)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    decode_in_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.enable_decode = RHS.enable_decode;
    this.opcode = RHS.opcode;
    this.sr1 = RHS.sr1;
    this.sr2 = RHS.sr2;
    this.dr = RHS.dr;
    this.baser = RHS.baser;
    this.pcoffset9 = RHS.pcoffset9;
    this.pcoffset6 = RHS.pcoffset6;
    this.imm5 = RHS.imm5;
    this.n = RHS.n;
    this.z = RHS.z;
    this.p = RHS.p;
    this.instruction = RHS.instruction;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_in_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,enable_decode,"enable_decode");
    $add_attribute(transaction_view_h,opcode,"opcode");
    $add_attribute(transaction_view_h,sr1,"sr1");
    $add_attribute(transaction_view_h,sr2,"sr2");
    $add_attribute(transaction_view_h,dr,"dr");
    $add_attribute(transaction_view_h,baser,"baser");
    $add_attribute(transaction_view_h,pcoffset9,"pcoffset9");
    $add_attribute(transaction_view_h,pcoffset6,"pcoffset6");
    $add_attribute(transaction_view_h,imm5,"imm5");
    $add_attribute(transaction_view_h,n,"n");
    $add_attribute(transaction_view_h,z,"z");
    $add_attribute(transaction_view_h,p,"p");
    $add_attribute(transaction_view_h,instruction,"instruction");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

