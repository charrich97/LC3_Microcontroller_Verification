//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains the top level sequence used in  example_derived_test.
// It is an example of a sequence that is extended from %(benchName)_bench_sequence_base
// and can override %(benchName)_bench_sequence_base.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class branch_test_sequence extends LC3_bench_sequence_base;

  `uvm_object_utils( branch_test_sequence );

  function new(string name = "" );
    super.new(name);
  endfunction
    
  virtual task body();
  instruction_memory_agent_branch_seq     = instruction_memory_agent_branch_seq_t   ::type_id::create("instruction_memory_agent_branch_seq"   );
    fork
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
    join
  fork
  //`imem_start(branch_seq)
  //`dmem_start(responder_seq) 
  instruction_memory_agent_branch_seq.start(instruction_memory_agent_sequencer);
  data_memory_agent_responder_seq.start(data_memory_agent_sequencer);
  join_none
  fork
  writeback_writeback_in_agent_h_config.wait_for_num_clocks(1000);
  writeback_writeback_out_agent_h_config.wait_for_num_clocks(1000);
  execute_agent_in_config.wait_for_num_clocks(1000);
  execute_agent_out_config.wait_for_num_clocks(1000);
  controller_controller_in_agent_inst_config.wait_for_num_clocks(1000);
  controller_controller_out_agent_inst_config.wait_for_num_clocks(1000);
  decode_decode_in_agent_inst_config.wait_for_num_clocks(1000);
  decode_decode_out_agent_inst_config.wait_for_num_clocks(1000);
  fetch_fetch_in_agent_h_config.wait_for_num_clocks(1000);
  fetch_fetch_out_agent_h_config.wait_for_num_clocks(1000);
  memaccess_memaccess_in_agent_h_config.wait_for_num_clocks(1000);
  memaccess_memaccess_out_agent_h_config.wait_for_num_clocks(1000);
  data_memory_agent_config.wait_for_num_clocks(1000);
  instruction_memory_agent_config.wait_for_num_clocks(1000);
  join
  endtask
endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

