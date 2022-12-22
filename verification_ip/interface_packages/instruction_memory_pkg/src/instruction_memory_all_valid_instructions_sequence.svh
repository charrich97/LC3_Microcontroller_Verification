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
class instruction_memory_all_valid_instructions_sequence 
  extends instruction_memory_sequence_base ;

  `uvm_object_utils( instruction_memory_all_valid_instructions_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "instruction_memory_all_valid_instructions_sequence");
    super.new(name);
  endfunction
  
  bit [2:0]   preload_register  ;
  bit [15:0]  instruction       ;
  bit [15:6]  not_instruction   ;
  bit [8:6]   jmp_instruction   ;
  bit [2:0]   sr2;
  bit [5:0]   sr1_dr;
  bit [4:0]   imm5;
  task body();
  // pragma uvmf custom body begin
    req=instruction_memory_transaction::type_id::create("req");
      for (int loop_var=0;loop_var < 8 ; loop_var++) begin
        start_item(req);
        req.instruction = {LEA, preload_register , 9'b111111111};
        req.complete_instr = 1;
        preload_register = preload_register + 1;
        finish_item(req);
      end  

      for (int i = 0; i <=63; i++ ) begin
        for (int j = 0; j<=7; j++ ) begin
          start_item(req);
          req.instruction = {4'b0001, sr1_dr, 3'b000, sr2};
          req.complete_instr = 1;
          finish_item(req);
        sr2++;   
        end 
        sr2=0;
        sr1_dr ++;   
      end

      for (int i = 0; i <=63; i++ ) begin
        for (int j = 0; j<=31; j++ ) begin
          start_item(req);
          req.instruction = {4'b0001, sr1_dr, 1'b1, imm5};
          req.complete_instr = 1;
          finish_item(req);
          imm5++;   
        end 
        imm5 = 0;
        sr1_dr ++;   
      end

      for (int i = 0; i <=63; i++ ) begin
        for (int j = 0; j<=7; j++ ) begin
          start_item(req);
          req.instruction = {4'b0101, sr1_dr, 3'b000, sr2};
          req.complete_instr = 1;
          finish_item(req);
          sr2++;   
        end 
        sr2 = 0;
        sr1_dr ++;   
      end

      for (int i = 0; i <=63; i++ ) begin
        for (int j = 0; j<=31; j++ ) begin
          start_item(req);
          req.instruction = {4'b0101, sr1_dr, 1'b1, imm5};
          req.complete_instr = 1;
          finish_item(req);
          imm5++;   
        end 
        imm5 = 0;
        sr1_dr ++;   
      end
      sr1_dr =0;
      repeat (64) begin //NOT
        start_item(req);
        req.instruction = {4'b1001, sr1_dr, 6'b111111};
        req.complete_instr = 1;
        finish_item(req);
        sr1_dr ++;
      end

      instruction = 8192; 
      repeat (4096) begin //LD
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 24576; 
      repeat (4096) begin //LDR
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 40960; 
      repeat (4096) begin //LDI
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 57344; 
      repeat (4096) begin //LEA
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 12288; 
      repeat (4096) begin //ST
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 28672; 
      repeat (4096) begin //STR
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 45056; 
      repeat (4096) begin //STI
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      instruction = 512; 
      repeat (3584) begin //BR
        start_item(req);
        req.instruction = instruction;
        req.complete_instr = 1;
        finish_item(req);
        instruction = instruction + 1;
      end

      jmp_instruction = 3'b000; 
      repeat (8) begin //JMP
        start_item(req);
        req.instruction = {4'b1100, 3'b000, jmp_instruction, 6'b000000};
        req.complete_instr = 1;
        finish_item(req);
        jmp_instruction = jmp_instruction + 1;
      end
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

