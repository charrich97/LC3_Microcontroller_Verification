//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <instruction_memory_typedefs_hdl>
//    - <instruction_memory_typedefs.svh>
//    - <instruction_memory_transaction.svh>

//    - <instruction_memory_configuration.svh>
//    - <instruction_memory_driver.svh>
//    - <instruction_memory_monitor.svh>

//    - <instruction_memory_transaction_coverage.svh>
//    - <instruction_memory_sequence_base.svh>
//    - <instruction_memory_random_sequence.svh>

//    - <instruction_memory_responder_sequence.svh>
//    - <instruction_memory2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package instruction_memory_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import instruction_memory_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/instruction_memory_macros.svh"

   export instruction_memory_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/instruction_memory_typedefs.svh"
   `include "src/instruction_memory_transaction.svh"

   `include "src/instruction_memory_configuration.svh"
   `include "src/instruction_memory_driver.svh"
   `include "src/instruction_memory_monitor.svh"

   `include "src/instruction_memory_transaction_coverage.svh"
   `include "src/instruction_memory_sequence_base.svh"
   `include "src/instruction_memory_random_sequence.svh" 

   `include "src/instruction_memory_responder_sequence.svh"
   `include "src/instruction_memory_branch_sequence.svh" 
   `include "src/instruction_memory_additional_operands_sequence.svh"
   `include "src/instruction_memory_all_valid_instructions_sequence.svh"
   `include "src/instruction_memory_register_sequence.svh"
    `include "src/instruction_memory2reg_adapter.svh"

   `include "src/instruction_memory_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

