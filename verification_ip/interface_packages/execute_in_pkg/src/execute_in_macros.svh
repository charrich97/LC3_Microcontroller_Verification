//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the execute_in package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the execute_in_configuration class.
//
  `define execute_in_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } execute_in_configuration_s;

  `define execute_in_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function execute_in_configuration_s to_struct();\
    execute_in_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( execute_in_configuration_struct );\
  endfunction

  `define execute_in_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(execute_in_configuration_s execute_in_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = execute_in_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the execute_in_transaction class.
//
  `define execute_in_MONITOR_STRUCT typedef struct packed  { \
  bit [5:0] E_control ; \
  bit [15:0] IR ; \
  bit [15:0] npc_in ; \
  bit bypass_alu_1 ; \
  bit bypass_alu_2 ; \
  bit bypass_mem_1 ; \
  bit bypass_mem_2 ; \
  bit [15:0] VSR1 ; \
  bit [15:0] VSR2 ; \
  bit [1:0] W_Control_in ; \
  bit Mem_Control_in ; \
  bit enable_execute ; \
  bit [15:0] Mem_Bypass_Val ; \
     } execute_in_monitor_s;

  `define execute_in_TO_MONITOR_STRUCT_FUNCTION \
  virtual function execute_in_monitor_s to_monitor_struct();\
    execute_in_monitor_struct = \
            { \
            this.E_control , \
            this.IR , \
            this.npc_in , \
            this.bypass_alu_1 , \
            this.bypass_alu_2 , \
            this.bypass_mem_1 , \
            this.bypass_mem_2 , \
            this.VSR1 , \
            this.VSR2 , \
            this.W_Control_in , \
            this.Mem_Control_in , \
            this.enable_execute , \
            this.Mem_Bypass_Val  \
            };\
    return ( execute_in_monitor_struct);\
  endfunction\

  `define execute_in_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(execute_in_monitor_s execute_in_monitor_struct);\
            {\
            this.E_control , \
            this.IR , \
            this.npc_in , \
            this.bypass_alu_1 , \
            this.bypass_alu_2 , \
            this.bypass_mem_1 , \
            this.bypass_mem_2 , \
            this.VSR1 , \
            this.VSR2 , \
            this.W_Control_in , \
            this.Mem_Control_in , \
            this.enable_execute , \
            this.Mem_Bypass_Val  \
            } = execute_in_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the execute_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define execute_in_INITIATOR_STRUCT typedef struct packed  { \
  bit [5:0] E_control ; \
  bit [15:0] IR ; \
  bit [15:0] npc_in ; \
  bit bypass_alu_1 ; \
  bit bypass_alu_2 ; \
  bit bypass_mem_1 ; \
  bit bypass_mem_2 ; \
  bit [15:0] VSR1 ; \
  bit [15:0] VSR2 ; \
  bit [1:0] W_Control_in ; \
  bit Mem_Control_in ; \
  bit enable_execute ; \
  bit [15:0] Mem_Bypass_Val ; \
     } execute_in_initiator_s;

  `define execute_in_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function execute_in_initiator_s to_initiator_struct();\
    execute_in_initiator_struct = \
           {\
           this.E_control , \
           this.IR , \
           this.npc_in , \
           this.bypass_alu_1 , \
           this.bypass_alu_2 , \
           this.bypass_mem_1 , \
           this.bypass_mem_2 , \
           this.VSR1 , \
           this.VSR2 , \
           this.W_Control_in , \
           this.Mem_Control_in , \
           this.enable_execute , \
           this.Mem_Bypass_Val  \
           };\
    return ( execute_in_initiator_struct);\
  endfunction

  `define execute_in_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(execute_in_initiator_s execute_in_initiator_struct);\
           {\
           this.E_control , \
           this.IR , \
           this.npc_in , \
           this.bypass_alu_1 , \
           this.bypass_alu_2 , \
           this.bypass_mem_1 , \
           this.bypass_mem_2 , \
           this.VSR1 , \
           this.VSR2 , \
           this.W_Control_in , \
           this.Mem_Control_in , \
           this.enable_execute , \
           this.Mem_Bypass_Val  \
           } = execute_in_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the execute_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define execute_in_RESPONDER_STRUCT typedef struct packed  { \
  bit [5:0] E_control ; \
  bit [15:0] IR ; \
  bit [15:0] npc_in ; \
  bit bypass_alu_1 ; \
  bit bypass_alu_2 ; \
  bit bypass_mem_1 ; \
  bit bypass_mem_2 ; \
  bit [15:0] VSR1 ; \
  bit [15:0] VSR2 ; \
  bit [1:0] W_Control_in ; \
  bit Mem_Control_in ; \
  bit enable_execute ; \
  bit [15:0] Mem_Bypass_Val ; \
     } execute_in_responder_s;

  `define execute_in_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function execute_in_responder_s to_responder_struct();\
    execute_in_responder_struct = \
           {\
           this.E_control , \
           this.IR , \
           this.npc_in , \
           this.bypass_alu_1 , \
           this.bypass_alu_2 , \
           this.bypass_mem_1 , \
           this.bypass_mem_2 , \
           this.VSR1 , \
           this.VSR2 , \
           this.W_Control_in , \
           this.Mem_Control_in , \
           this.enable_execute , \
           this.Mem_Bypass_Val  \
           };\
    return ( execute_in_responder_struct);\
  endfunction

  `define execute_in_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(execute_in_responder_s execute_in_responder_struct);\
           {\
           this.E_control , \
           this.IR , \
           this.npc_in , \
           this.bypass_alu_1 , \
           this.bypass_alu_2 , \
           this.bypass_mem_1 , \
           this.bypass_mem_2 , \
           this.VSR1 , \
           this.VSR2 , \
           this.W_Control_in , \
           this.Mem_Control_in , \
           this.enable_execute , \
           this.Mem_Bypass_Val  \
           } = execute_in_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
