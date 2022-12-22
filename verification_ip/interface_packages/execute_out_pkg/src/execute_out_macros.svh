//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the execute_out package.
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
//      the execute_out_configuration class.
//
  `define execute_out_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } execute_out_configuration_s;

  `define execute_out_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function execute_out_configuration_s to_struct();\
    execute_out_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( execute_out_configuration_struct );\
  endfunction

  `define execute_out_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(execute_out_configuration_s execute_out_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = execute_out_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the execute_out_transaction class.
//
  `define execute_out_MONITOR_STRUCT typedef struct packed  { \
  bit [1:0] W_Control_out ; \
  bit Mem_Control_out ; \
  bit [15:0] aluout ; \
  bit [15:0] pcout ; \
  bit [2:0] dr ; \
  bit [2:0] sr1 ; \
  bit [2:0] sr2 ; \
  bit [15:0] IR_Exec ; \
  bit [2:0] NZP ; \
  bit [15:0] M_Data ; \
  bit enable_execute_status ; \
     } execute_out_monitor_s;

  `define execute_out_TO_MONITOR_STRUCT_FUNCTION \
  virtual function execute_out_monitor_s to_monitor_struct();\
    execute_out_monitor_struct = \
            { \
            this.W_Control_out , \
            this.Mem_Control_out , \
            this.aluout , \
            this.pcout , \
            this.dr , \
            this.sr1 , \
            this.sr2 , \
            this.IR_Exec , \
            this.NZP , \
            this.M_Data , \
            this.enable_execute_status  \
            };\
    return ( execute_out_monitor_struct);\
  endfunction\

  `define execute_out_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(execute_out_monitor_s execute_out_monitor_struct);\
            {\
            this.W_Control_out , \
            this.Mem_Control_out , \
            this.aluout , \
            this.pcout , \
            this.dr , \
            this.sr1 , \
            this.sr2 , \
            this.IR_Exec , \
            this.NZP , \
            this.M_Data , \
            this.enable_execute_status  \
            } = execute_out_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the execute_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define execute_out_INITIATOR_STRUCT typedef struct packed  { \
  bit [1:0] W_Control_out ; \
  bit Mem_Control_out ; \
  bit [15:0] aluout ; \
  bit [15:0] pcout ; \
  bit [2:0] dr ; \
  bit [2:0] sr1 ; \
  bit [2:0] sr2 ; \
  bit [15:0] IR_Exec ; \
  bit [2:0] NZP ; \
  bit [15:0] M_Data ; \
  bit enable_execute_status ; \
     } execute_out_initiator_s;

  `define execute_out_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function execute_out_initiator_s to_initiator_struct();\
    execute_out_initiator_struct = \
           {\
           this.W_Control_out , \
           this.Mem_Control_out , \
           this.aluout , \
           this.pcout , \
           this.dr , \
           this.sr1 , \
           this.sr2 , \
           this.IR_Exec , \
           this.NZP , \
           this.M_Data , \
           this.enable_execute_status  \
           };\
    return ( execute_out_initiator_struct);\
  endfunction

  `define execute_out_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(execute_out_initiator_s execute_out_initiator_struct);\
           {\
           this.W_Control_out , \
           this.Mem_Control_out , \
           this.aluout , \
           this.pcout , \
           this.dr , \
           this.sr1 , \
           this.sr2 , \
           this.IR_Exec , \
           this.NZP , \
           this.M_Data , \
           this.enable_execute_status  \
           } = execute_out_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the execute_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define execute_out_RESPONDER_STRUCT typedef struct packed  { \
  bit [1:0] W_Control_out ; \
  bit Mem_Control_out ; \
  bit [15:0] aluout ; \
  bit [15:0] pcout ; \
  bit [2:0] dr ; \
  bit [2:0] sr1 ; \
  bit [2:0] sr2 ; \
  bit [15:0] IR_Exec ; \
  bit [2:0] NZP ; \
  bit [15:0] M_Data ; \
  bit enable_execute_status ; \
     } execute_out_responder_s;

  `define execute_out_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function execute_out_responder_s to_responder_struct();\
    execute_out_responder_struct = \
           {\
           this.W_Control_out , \
           this.Mem_Control_out , \
           this.aluout , \
           this.pcout , \
           this.dr , \
           this.sr1 , \
           this.sr2 , \
           this.IR_Exec , \
           this.NZP , \
           this.M_Data , \
           this.enable_execute_status  \
           };\
    return ( execute_out_responder_struct);\
  endfunction

  `define execute_out_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(execute_out_responder_s execute_out_responder_struct);\
           {\
           this.W_Control_out , \
           this.Mem_Control_out , \
           this.aluout , \
           this.pcout , \
           this.dr , \
           this.sr1 , \
           this.sr2 , \
           this.IR_Exec , \
           this.NZP , \
           this.M_Data , \
           this.enable_execute_status  \
           } = execute_out_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
