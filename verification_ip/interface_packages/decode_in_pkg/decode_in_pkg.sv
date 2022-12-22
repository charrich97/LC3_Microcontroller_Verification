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
//    - <decode_in_typedefs_hdl>
//    - <decode_in_typedefs.svh>
//    - <decode_in_transaction.svh>

//    - <decode_in_configuration.svh>
//    - <decode_in_driver.svh>
//    - <decode_in_monitor.svh>

//    - <decode_in_transaction_coverage.svh>
//    - <decode_in_sequence_base.svh>
//    - <decode_in_random_sequence.svh>

//    - <decode_in_responder_sequence.svh>
//    - <decode_in2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package decode_in_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import decode_in_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/decode_in_macros.svh"

   export decode_in_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/decode_in_typedefs.svh"
   `include "src/decode_in_transaction.svh"

   `include "src/decode_in_configuration.svh"
   `include "src/decode_in_driver.svh"
   `include "src/decode_in_monitor.svh"

   `include "src/decode_in_transaction_coverage.svh"
   `include "src/decode_in_sequence_base.svh"
   `include "src/decode_in_random_sequence.svh"

   `include "src/decode_in_responder_sequence.svh"
   `include "src/decode_in2reg_adapter.svh"

   `include "src/decode_in_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

