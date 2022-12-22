//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains the top level sequence used in register_test.
// It uses the UVM built in register test.  Specific UVM built-in tests can be
// selected in the body task.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class register_test_sequence extends LC3_bench_sequence_base;
  `uvm_object_utils( register_test_sequence );


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "" );
    super.new(name);
    LC3_env_seq                                       = LC3_env_sequence_base_t                 ::type_id::create("LC3_env_seq"                             );
    data_memory_agent_responder_seq                   = data_memory_agent_responder_seq_t       ::type_id::create("data_memory_agent_responder_seq"         );
    instruction_memory_agent_register_seq             = instruction_memory_agent_register_seq_t ::type_id::create("instruction_memory_agent_register_seq"   );
  endfunction

  // ****************************************************************************
  virtual task body();
    // Reset the DUT
    fork
      // pragma uvmf custom register_test_reset begin
      // UVMF_CHANGE_ME 
      // Select the desired wait_for_reset or provide custom mechanism.
      // fork-join for this code block may be unnecessary based on your situation.
      writeback_writeback_in_agent_h_config.wait_for_reset();
      writeback_writeback_out_agent_h_config.wait_for_reset();
      execute_agent_in_config.wait_for_reset();
      execute_agent_out_config.wait_for_reset();
      controller_controller_in_agent_inst_config.wait_for_reset();
      controller_controller_out_agent_inst_config.wait_for_reset();
      decode_decode_in_agent_inst_config.wait_for_reset();
      decode_decode_out_agent_inst_config.wait_for_reset();
      fetch_fetch_in_agent_h_config.wait_for_reset();
      fetch_fetch_out_agent_h_config.wait_for_reset();
      memaccess_memaccess_in_agent_h_config.wait_for_reset();
      memaccess_memaccess_out_agent_h_config.wait_for_reset();
      data_memory_agent_config.wait_for_reset();
      instruction_memory_agent_config.wait_for_reset();
      // pragma uvmf custom register_test_reset end
    join
     fork
     //`imem_start(branch_seq)
     //`dmem_start(responder_seq) 
     instruction_memory_agent_register_seq.start(instruction_memory_agent_sequencer);
     data_memory_agent_responder_seq.start(data_memory_agent_sequencer);
     join_none
     fork
     writeback_writeback_in_agent_h_config.wait_for_num_clocks(10000);
     writeback_writeback_out_agent_h_config.wait_for_num_clocks(10000);
     execute_agent_in_config.wait_for_num_clocks(10000);
     execute_agent_out_config.wait_for_num_clocks(10000);
     controller_controller_in_agent_inst_config.wait_for_num_clocks(10000);
     controller_controller_out_agent_inst_config.wait_for_num_clocks(10000);
     decode_decode_in_agent_inst_config.wait_for_num_clocks(10000);
     decode_decode_out_agent_inst_config.wait_for_num_clocks(10000);
     fetch_fetch_in_agent_h_config.wait_for_num_clocks(10000);
     fetch_fetch_out_agent_h_config.wait_for_num_clocks(10000);
     memaccess_memaccess_in_agent_h_config.wait_for_num_clocks(10000);
     memaccess_memaccess_out_agent_h_config.wait_for_num_clocks(10000);
     data_memory_agent_config.wait_for_num_clocks(10000);
     instruction_memory_agent_config.wait_for_num_clocks(10000);
     join

      // pragma uvmf custom register_test_setup begin
      // UVMF_CHANGE_ME perform potentially necessary operations before running the sequence.
      // pragma uvmf custom register_test_setup end

    // pragma uvmf custom register_test_operation begin
    // UVMF_CHANGE_ME Perform your custom register test
    // pragma uvmf custom register_test_operation end

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

