//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an data_memory
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class data_memory_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( data_memory_transaction )

  rand Data_dout_t Data_dout ;
  rand complete_data_t complete_data ;
  Data_din_t Data_din ;
  Data_addr_t Data_addr ;
  Data_addr_t Data_rd ;
  D_macc_t D_macc ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in data_memory_macros.svh

  //*******************************************************************
  // Monitor macro used by data_memory_monitor and data_memory_monitor_bfm
  // This struct is defined in data_memory_macros.svh
  `data_memory_MONITOR_STRUCT
    data_memory_monitor_s data_memory_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a data_memory_monitor_s
  // structure.  The function returns the handle to the data_memory_monitor_struct.
  // This function is defined in data_memory_macros.svh
  `data_memory_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in data_memory_macros.svh
  `data_memory_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by data_memory_driver and data_memory_driver_bfm
  // to communicate initiator driven data to data_memory_driver_bfm.
  // This struct is defined in data_memory_macros.svh
  `data_memory_INITIATOR_STRUCT
    data_memory_initiator_s data_memory_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a data_memory_initiator_s
  // structure.  The function returns the handle to the data_memory_initiator_struct.
  // This function is defined in data_memory_macros.svh
  `data_memory_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in data_memory_macros.svh
  `data_memory_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by data_memory_driver and data_memory_driver_bfm
  // to communicate Responder driven data to data_memory_driver_bfm.
  // This struct is defined in data_memory_macros.svh
  `data_memory_RESPONDER_STRUCT
    data_memory_responder_s data_memory_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a data_memory_responder_s
  // structure.  The function returns the handle to the data_memory_responder_struct.
  // This function is defined in data_memory_macros.svh
  `data_memory_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in data_memory_macros.svh
  `data_memory_FROM_RESPONDER_STRUCT_FUNCTION 
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
    return $sformatf("Data_dout:0x%x complete_data:0x%x Data_din:0x%x Data_addr:0x%x Data_rd:0x%x D_macc:0x%x ",Data_dout,complete_data,Data_din,Data_addr,Data_rd,D_macc);
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
    data_memory_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.Data_din == RHS.Data_din)
            &&(this.Data_addr == RHS.Data_addr)
            &&(this.Data_rd == RHS.Data_rd)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    data_memory_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.Data_dout = RHS.Data_dout;
    this.complete_data = RHS.complete_data;
    this.Data_din = RHS.Data_din;
    this.Data_addr = RHS.Data_addr;
    this.Data_rd = RHS.Data_rd;
    this.D_macc = RHS.D_macc;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"data_memory_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,Data_dout,"Data_dout");
    $add_attribute(transaction_view_h,complete_data,"complete_data");
    $add_attribute(transaction_view_h,Data_din,"Data_din");
    $add_attribute(transaction_view_h,Data_addr,"Data_addr");
    $add_attribute(transaction_view_h,Data_rd,"Data_rd");
    $add_attribute(transaction_view_h,D_macc,"D_macc");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

