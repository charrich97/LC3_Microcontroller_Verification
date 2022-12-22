//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the controller_in package.
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
//      the controller_in_configuration class.
//
  `define controller_in_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } controller_in_configuration_s;

  `define controller_in_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function controller_in_configuration_s to_struct();\
    controller_in_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( controller_in_configuration_struct );\
  endfunction

  `define controller_in_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(controller_in_configuration_s controller_in_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = controller_in_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the controller_in_transaction class.
//
  `define controller_in_MONITOR_STRUCT typedef struct packed  { \
  bit complete_data_trans_var ; \
  bit complete_instr_trans_var ; \
  bit [15:0] IR_trans_var ; \
  bit [2:0] psr_trans_var ; \
  bit [15:0] IR_Exec_trans_var ; \
  bit [15:0] IMem_dout_trans_var ; \
  bit [2:0] NZP_trans_var ; \
     } controller_in_monitor_s;

  `define controller_in_TO_MONITOR_STRUCT_FUNCTION \
  virtual function controller_in_monitor_s to_monitor_struct();\
    controller_in_monitor_struct = \
            { \
            this.complete_data_trans_var , \
            this.complete_instr_trans_var , \
            this.IR_trans_var , \
            this.psr_trans_var , \
            this.IR_Exec_trans_var , \
            this.IMem_dout_trans_var , \
            this.NZP_trans_var  \
            };\
    return ( controller_in_monitor_struct);\
  endfunction\

  `define controller_in_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(controller_in_monitor_s controller_in_monitor_struct);\
            {\
            this.complete_data_trans_var , \
            this.complete_instr_trans_var , \
            this.IR_trans_var , \
            this.psr_trans_var , \
            this.IR_Exec_trans_var , \
            this.IMem_dout_trans_var , \
            this.NZP_trans_var  \
            } = controller_in_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the controller_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define controller_in_INITIATOR_STRUCT typedef struct packed  { \
  bit complete_data_trans_var ; \
  bit complete_instr_trans_var ; \
  bit [15:0] IR_trans_var ; \
  bit [2:0] psr_trans_var ; \
  bit [15:0] IR_Exec_trans_var ; \
  bit [15:0] IMem_dout_trans_var ; \
  bit [2:0] NZP_trans_var ; \
     } controller_in_initiator_s;

  `define controller_in_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function controller_in_initiator_s to_initiator_struct();\
    controller_in_initiator_struct = \
           {\
           this.complete_data_trans_var , \
           this.complete_instr_trans_var , \
           this.IR_trans_var , \
           this.psr_trans_var , \
           this.IR_Exec_trans_var , \
           this.IMem_dout_trans_var , \
           this.NZP_trans_var  \
           };\
    return ( controller_in_initiator_struct);\
  endfunction

  `define controller_in_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(controller_in_initiator_s controller_in_initiator_struct);\
           {\
           this.complete_data_trans_var , \
           this.complete_instr_trans_var , \
           this.IR_trans_var , \
           this.psr_trans_var , \
           this.IR_Exec_trans_var , \
           this.IMem_dout_trans_var , \
           this.NZP_trans_var  \
           } = controller_in_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the controller_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define controller_in_RESPONDER_STRUCT typedef struct packed  { \
  bit complete_data_trans_var ; \
  bit complete_instr_trans_var ; \
  bit [15:0] IR_trans_var ; \
  bit [2:0] psr_trans_var ; \
  bit [15:0] IR_Exec_trans_var ; \
  bit [15:0] IMem_dout_trans_var ; \
  bit [2:0] NZP_trans_var ; \
     } controller_in_responder_s;

  `define controller_in_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function controller_in_responder_s to_responder_struct();\
    controller_in_responder_struct = \
           {\
           this.complete_data_trans_var , \
           this.complete_instr_trans_var , \
           this.IR_trans_var , \
           this.psr_trans_var , \
           this.IR_Exec_trans_var , \
           this.IMem_dout_trans_var , \
           this.NZP_trans_var  \
           };\
    return ( controller_in_responder_struct);\
  endfunction

  `define controller_in_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(controller_in_responder_s controller_in_responder_struct);\
           {\
           this.complete_data_trans_var , \
           this.complete_instr_trans_var , \
           this.IR_trans_var , \
           this.psr_trans_var , \
           this.IR_Exec_trans_var , \
           this.IMem_dout_trans_var , \
           this.NZP_trans_var  \
           } = controller_in_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
