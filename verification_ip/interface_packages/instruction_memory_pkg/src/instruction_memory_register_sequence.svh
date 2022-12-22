//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class instruction_memory_register_sequence 
  extends instruction_memory_sequence_base ;

  `uvm_object_utils( instruction_memory_register_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "instruction_memory_register_sequence");
    super.new(name);
  endfunction
  
  bit [2:0] preload_register;
  task body();
    req=instruction_memory_transaction::type_id::create("req");
      for (int loop_var=0;loop_var <= 7; loop_var++) begin
        start_item(req);
        req.instruction = {LEA, preload_register , 9'b111111111};
        req.complete_instr = 1;
        preload_register = preload_register + 1;
        finish_item(req);
      end  

      forever begin
      start_item(req);
      if (!(req.randomize() with {req.opcode inside {
        ADD ,
        AND ,
        NOT ,
        LD  ,
        LDR ,
        LDI ,
        LEA ,
        ST  ,
        STR ,
        STI ,
        JMP}
        ;})) begin
        `uvm_error(get_full_name(),$sformatf("Failed to Randomize Instruction Memory Sequence Item"));
      end
      req.complete_instr = 1;
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

