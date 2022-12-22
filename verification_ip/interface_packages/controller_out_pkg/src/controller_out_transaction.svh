//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an controller_out
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class controller_out_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( controller_out_transaction )

  bit enable_updatePC_trans_var ;
  bit enable_fetch_trans_var ;
  bit enable_decode_trans_var ;
  bit enable_execute_trans_var ;
  bit enable_writeback_trans_var ;
  bit bypass_alu_1_trans_var ;
  bit bypass_alu_2_trans_var ;
  bit bypass_mem_1_trans_var ;
  bit bypass_mem_2_trans_var ;
  bit [1:0] mem_state_trans_var ;
  bit br_taken_trans_var ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  function void post_randomize();
  endfunction
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in controller_out_macros.svh

  //*******************************************************************
  // Monitor macro used by controller_out_monitor and controller_out_monitor_bfm
  // This struct is defined in controller_out_macros.svh
  `controller_out_MONITOR_STRUCT
    controller_out_monitor_s controller_out_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a controller_out_monitor_s
  // structure.  The function returns the handle to the controller_out_monitor_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate initiator driven data to controller_out_driver_bfm.
  // This struct is defined in controller_out_macros.svh
  `controller_out_INITIATOR_STRUCT
    controller_out_initiator_s controller_out_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a controller_out_initiator_s
  // structure.  The function returns the handle to the controller_out_initiator_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate Responder driven data to controller_out_driver_bfm.
  // This struct is defined in controller_out_macros.svh
  `controller_out_RESPONDER_STRUCT
    controller_out_responder_s controller_out_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a controller_out_responder_s
  // structure.  The function returns the handle to the controller_out_responder_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_RESPONDER_STRUCT_FUNCTION 
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
      str = {str, $sformatf("\n************Controller Out Transaction************\n"    )}; 
      str = {str, $sformatf("ENABLE_UPDATEPC      : %b  \n", enable_updatePC_trans_var  )}; 
      str = {str, $sformatf("ENABLE_FETCH         : %b  \n", enable_fetch_trans_var     )}; 
      str = {str, $sformatf("ENABLE_DECODE        : %b  \n", enable_decode_trans_var    )}; 
      str = {str, $sformatf("ENABLE_EXECUTE       : %b  \n", enable_execute_trans_var   )}; 
      str = {str, $sformatf("ENABLE_WRITEBACK     : %b  \n", enable_writeback_trans_var )}; 
      str = {str, $sformatf("BYPASS_ALU_1         : %b  \n", bypass_alu_1_trans_var     )}; 
      str = {str, $sformatf("BYPASS_ALU_2         : %b  \n", bypass_alu_2_trans_var     )}; 
      str = {str, $sformatf("BYPASS_MEM_1         : %b  \n", bypass_mem_1_trans_var     )}; 
      str = {str, $sformatf("BYPASS_MEM_2         : %b  \n", bypass_mem_2_trans_var     )}; 
      str = {str, $sformatf("MEM_STATE            : %d  \n", mem_state_trans_var        )}; 
      str = {str, $sformatf("BR_TAKEN             : %d  \n", br_taken_trans_var         )}; 
      str = {str, $sformatf("Time                 : %t  \n", $time                      )};
      str = {str, $sformatf("****************************************************\n"    )};
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
    controller_out_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.enable_updatePC_trans_var   == RHS.enable_updatePC_trans_var  )
            &&(this.enable_fetch_trans_var      == RHS.enable_fetch_trans_var     )
            &&(this.enable_decode_trans_var     == RHS.enable_decode_trans_var    )
            &&(this.enable_execute_trans_var    == RHS.enable_execute_trans_var   )
            &&(this.enable_writeback_trans_var  == RHS.enable_writeback_trans_var )
            &&(this.bypass_alu_1_trans_var      == RHS.bypass_alu_1_trans_var     )
            &&(this.bypass_alu_2_trans_var      == RHS.bypass_alu_2_trans_var     )
            &&(this.bypass_mem_1_trans_var      == RHS.bypass_mem_1_trans_var     )
            &&(this.bypass_mem_2_trans_var      == RHS.bypass_mem_2_trans_var     )
            &&(this.mem_state_trans_var         == RHS.mem_state_trans_var        )
            &&(this.br_taken_trans_var          == RHS.br_taken_trans_var         )
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    controller_out_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.enable_updatePC_trans_var = RHS.enable_updatePC_trans_var;
    this.enable_fetch_trans_var = RHS.enable_fetch_trans_var;
    this.enable_decode_trans_var = RHS.enable_decode_trans_var;
    this.enable_execute_trans_var = RHS.enable_execute_trans_var;
    this.enable_writeback_trans_var = RHS.enable_writeback_trans_var;
    this.bypass_alu_1_trans_var = RHS.bypass_alu_1_trans_var;
    this.bypass_alu_2_trans_var = RHS.bypass_alu_2_trans_var;
    this.bypass_mem_1_trans_var = RHS.bypass_mem_1_trans_var;
    this.bypass_mem_2_trans_var = RHS.bypass_mem_2_trans_var;
    this.mem_state_trans_var = RHS.mem_state_trans_var;
    this.br_taken_trans_var = RHS.br_taken_trans_var;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"controller_out_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,enable_updatePC_trans_var,"enable_updatePC_trans_var");
    $add_attribute(transaction_view_h,enable_fetch_trans_var,"enable_fetch_trans_var");
    $add_attribute(transaction_view_h,enable_decode_trans_var,"enable_decode_trans_var");
    $add_attribute(transaction_view_h,enable_execute_trans_var,"enable_execute_trans_var");
    $add_attribute(transaction_view_h,enable_writeback_trans_var,"enable_writeback_trans_var");
    $add_attribute(transaction_view_h,bypass_alu_1_trans_var,"bypass_alu_1_trans_var");
    $add_attribute(transaction_view_h,bypass_alu_2_trans_var,"bypass_alu_2_trans_var");
    $add_attribute(transaction_view_h,bypass_mem_1_trans_var,"bypass_mem_1_trans_var");
    $add_attribute(transaction_view_h,bypass_mem_2_trans_var,"bypass_mem_2_trans_var");
    $add_attribute(transaction_view_h,mem_state_trans_var,"mem_state_trans_var");
    $add_attribute(transaction_view_h,br_taken_trans_var,"br_taken_trans_var");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

