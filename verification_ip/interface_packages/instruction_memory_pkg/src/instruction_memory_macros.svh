//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the instruction_memory package.
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
//      the instruction_memory_configuration class.
//
  `define instruction_memory_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } instruction_memory_configuration_s;

  `define instruction_memory_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function instruction_memory_configuration_s to_struct();\
    instruction_memory_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( instruction_memory_configuration_struct );\
  endfunction

  `define instruction_memory_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(instruction_memory_configuration_s instruction_memory_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = instruction_memory_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the instruction_memory_transaction class.
//
  `define instruction_memory_MONITOR_STRUCT typedef struct packed  { \
  op_t opcode ; \
  reg_t sr1 ; \
  reg_t sr2 ; \
  reg_t dr ; \
  im_t im ; \
  baser_t baser ; \
  pcoffset9_t pcoffset9 ; \
  pcoffset6_t pcoffset6 ; \
  imm5_t imm5 ; \
  nzp_t nzp ; \
  bit [15:0] instruction ; \
  bit complete_instr ; \
  instrmem_rd_t instrmem_rd ; \
  bit [16:0] PC ; \
  bit I_macc ; \
     } instruction_memory_monitor_s;

  `define instruction_memory_TO_MONITOR_STRUCT_FUNCTION \
  virtual function instruction_memory_monitor_s to_monitor_struct();\
    instruction_memory_monitor_struct = \
            { \
            this.opcode , \
            this.sr1 , \
            this.sr2 , \
            this.dr , \
            this.im , \
            this.baser , \
            this.pcoffset9 , \
            this.pcoffset6 , \
            this.imm5 , \
            this.nzp , \
            this.instruction , \
            this.complete_instr , \
            this.instrmem_rd , \
            this.PC , \
            this.I_macc  \
            };\
    return ( instruction_memory_monitor_struct);\
  endfunction\

  `define instruction_memory_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(instruction_memory_monitor_s instruction_memory_monitor_struct);\
            {\
            this.opcode , \
            this.sr1 , \
            this.sr2 , \
            this.dr , \
            this.im , \
            this.baser , \
            this.pcoffset9 , \
            this.pcoffset6 , \
            this.imm5 , \
            this.nzp , \
            this.instruction , \
            this.complete_instr , \
            this.instrmem_rd , \
            this.PC , \
            this.I_macc  \
            } = instruction_memory_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the instruction_memory_transaction class.
//      Also update the comments in the driver BFM.
//
  `define instruction_memory_INITIATOR_STRUCT typedef struct packed  { \
  op_t opcode ; \
  reg_t sr1 ; \
  reg_t sr2 ; \
  reg_t dr ; \
  im_t im ; \
  baser_t baser ; \
  pcoffset9_t pcoffset9 ; \
  pcoffset6_t pcoffset6 ; \
  imm5_t imm5 ; \
  nzp_t nzp ; \
  bit [15:0] instruction ; \
  bit complete_instr ; \
  instrmem_rd_t instrmem_rd ; \
  bit [16:0] PC ; \
  bit I_macc ; \
     } instruction_memory_initiator_s;

  `define instruction_memory_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function instruction_memory_initiator_s to_initiator_struct();\
    instruction_memory_initiator_struct = \
           {\
           this.opcode , \
           this.sr1 , \
           this.sr2 , \
           this.dr , \
           this.im , \
           this.baser , \
           this.pcoffset9 , \
           this.pcoffset6 , \
           this.imm5 , \
           this.nzp , \
           this.instruction , \
           this.complete_instr , \
           this.instrmem_rd , \
           this.PC , \
           this.I_macc  \
           };\
    return ( instruction_memory_initiator_struct);\
  endfunction

  `define instruction_memory_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(instruction_memory_initiator_s instruction_memory_initiator_struct);\
           {\
           this.opcode , \
           this.sr1 , \
           this.sr2 , \
           this.dr , \
           this.im , \
           this.baser , \
           this.pcoffset9 , \
           this.pcoffset6 , \
           this.imm5 , \
           this.nzp , \
           this.instruction , \
           this.complete_instr , \
           this.instrmem_rd , \
           this.PC , \
           this.I_macc  \
           } = instruction_memory_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the instruction_memory_transaction class.
//      Also update the comments in the driver BFM.
//
  `define instruction_memory_RESPONDER_STRUCT typedef struct packed  { \
  op_t opcode ; \
  reg_t sr1 ; \
  reg_t sr2 ; \
  reg_t dr ; \
  im_t im ; \
  baser_t baser ; \
  pcoffset9_t pcoffset9 ; \
  pcoffset6_t pcoffset6 ; \
  imm5_t imm5 ; \
  nzp_t nzp ; \
  bit [15:0] instruction ; \
  bit complete_instr ; \
  instrmem_rd_t instrmem_rd ; \
  bit [16:0] PC ; \
  bit I_macc ; \
     } instruction_memory_responder_s;

  `define instruction_memory_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function instruction_memory_responder_s to_responder_struct();\
    instruction_memory_responder_struct = \
           {\
           this.opcode , \
           this.sr1 , \
           this.sr2 , \
           this.dr , \
           this.im , \
           this.baser , \
           this.pcoffset9 , \
           this.pcoffset6 , \
           this.imm5 , \
           this.nzp , \
           this.instruction , \
           this.complete_instr , \
           this.instrmem_rd , \
           this.PC , \
           this.I_macc  \
           };\
    return ( instruction_memory_responder_struct);\
  endfunction

  `define instruction_memory_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(instruction_memory_responder_s instruction_memory_responder_struct);\
           {\
           this.opcode , \
           this.sr1 , \
           this.sr2 , \
           this.dr , \
           this.im , \
           this.baser , \
           this.pcoffset9 , \
           this.pcoffset6 , \
           this.imm5 , \
           this.nzp , \
           this.instruction , \
           this.complete_instr , \
           this.instrmem_rd , \
           this.PC , \
           this.I_macc  \
           } = instruction_memory_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
