//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the decode_in transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a decode_in_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class fetch_in_exit_sequence extends fetch_in_sequence_base;

  `uvm_object_utils(fetch_in_exit_sequence)

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction : new

  // ****************************************************************************
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  task body();

    // Construct the transaction
    req = fetch_in_transaction::type_id::create("req");
    start_item(req);
    // Randomize the transaction
    req.enable_fetch = 1'b0;
    // Send the transaction to the decode_in_driver_bfm via the sequencer and decode_in_driver.
    finish_item(req);
    // `uvm_info("SEQ", {"Response:", req.convert2string()}, UVM_MEDIUM)

  endtask

endclass : fetch_in_exit_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

