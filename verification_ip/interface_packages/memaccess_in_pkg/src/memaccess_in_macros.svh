//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the memaccess_in package.
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
//      the memaccess_in_configuration class.
//
  `define memaccess_in_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } memaccess_in_configuration_s;

  `define memaccess_in_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function memaccess_in_configuration_s to_struct();\
    memaccess_in_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( memaccess_in_configuration_struct );\
  endfunction

  `define memaccess_in_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(memaccess_in_configuration_s memaccess_in_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = memaccess_in_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the memaccess_in_transaction class.
//
  `define memaccess_in_MONITOR_STRUCT typedef struct packed  { \
  mem_state_t mem_state ; \
  M_control_t M_control ; \
  M_Data_t M_Data ; \
  M_addr_t M_addr ; \
  DMem_dout_t DMem_dout ; \
     } memaccess_in_monitor_s;

  `define memaccess_in_TO_MONITOR_STRUCT_FUNCTION \
  virtual function memaccess_in_monitor_s to_monitor_struct();\
    memaccess_in_monitor_struct = \
            { \
            this.mem_state , \
            this.M_control , \
            this.M_Data , \
            this.M_addr , \
            this.DMem_dout  \
            };\
    return ( memaccess_in_monitor_struct);\
  endfunction\

  `define memaccess_in_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(memaccess_in_monitor_s memaccess_in_monitor_struct);\
            {\
            this.mem_state , \
            this.M_control , \
            this.M_Data , \
            this.M_addr , \
            this.DMem_dout  \
            } = memaccess_in_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the memaccess_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define memaccess_in_INITIATOR_STRUCT typedef struct packed  { \
  mem_state_t mem_state ; \
  M_control_t M_control ; \
  M_Data_t M_Data ; \
  M_addr_t M_addr ; \
  DMem_dout_t DMem_dout ; \
     } memaccess_in_initiator_s;

  `define memaccess_in_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function memaccess_in_initiator_s to_initiator_struct();\
    memaccess_in_initiator_struct = \
           {\
           this.mem_state , \
           this.M_control , \
           this.M_Data , \
           this.M_addr , \
           this.DMem_dout  \
           };\
    return ( memaccess_in_initiator_struct);\
  endfunction

  `define memaccess_in_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(memaccess_in_initiator_s memaccess_in_initiator_struct);\
           {\
           this.mem_state , \
           this.M_control , \
           this.M_Data , \
           this.M_addr , \
           this.DMem_dout  \
           } = memaccess_in_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the memaccess_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define memaccess_in_RESPONDER_STRUCT typedef struct packed  { \
  mem_state_t mem_state ; \
  M_control_t M_control ; \
  M_Data_t M_Data ; \
  M_addr_t M_addr ; \
  DMem_dout_t DMem_dout ; \
     } memaccess_in_responder_s;

  `define memaccess_in_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function memaccess_in_responder_s to_responder_struct();\
    memaccess_in_responder_struct = \
           {\
           this.mem_state , \
           this.M_control , \
           this.M_Data , \
           this.M_addr , \
           this.DMem_dout  \
           };\
    return ( memaccess_in_responder_struct);\
  endfunction

  `define memaccess_in_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(memaccess_in_responder_s memaccess_in_responder_struct);\
           {\
           this.mem_state , \
           this.M_control , \
           this.M_Data , \
           this.M_addr , \
           this.DMem_dout  \
           } = memaccess_in_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
