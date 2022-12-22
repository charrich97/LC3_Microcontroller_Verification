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
//    - <execute_out_typedefs_hdl>
//    - <execute_out_typedefs.svh>
//    - <execute_out_transaction.svh>

//    - <execute_out_configuration.svh>
//    - <execute_out_driver.svh>
//    - <execute_out_monitor.svh>

//    - <execute_out_transaction_coverage.svh>
//    - <execute_out_sequence_base.svh>
//    - <execute_out_random_sequence.svh>

//    - <execute_out_responder_sequence.svh>
//    - <execute_out2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package execute_out_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import execute_out_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/execute_out_macros.svh"

   export execute_out_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/execute_out_typedefs.svh"
   `include "src/execute_out_transaction.svh"

   `include "src/execute_out_configuration.svh"
   `include "src/execute_out_driver.svh"
   `include "src/execute_out_monitor.svh"

   `include "src/execute_out_transaction_coverage.svh"
   `include "src/execute_out_sequence_base.svh"
   `include "src/execute_out_random_sequence.svh"

   `include "src/execute_out_responder_sequence.svh"
   `include "src/execute_out2reg_adapter.svh"

   `include "src/execute_out_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

