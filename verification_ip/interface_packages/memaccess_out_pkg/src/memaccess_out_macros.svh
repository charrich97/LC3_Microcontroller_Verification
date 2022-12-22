//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the memaccess_out package.
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
//      the memaccess_out_configuration class.
//
  `define memaccess_out_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } memaccess_out_configuration_s;

  `define memaccess_out_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function memaccess_out_configuration_s to_struct();\
    memaccess_out_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( memaccess_out_configuration_struct );\
  endfunction

  `define memaccess_out_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(memaccess_out_configuration_s memaccess_out_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = memaccess_out_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the memaccess_out_transaction class.
//
  `define memaccess_out_MONITOR_STRUCT typedef struct packed  { \
  DMem_addr_t DMem_addr ; \
  DMem_din_t DMem_din ; \
  DMem_rd_t DMem_rd ; \
  memout_t memout ; \
     } memaccess_out_monitor_s;

  `define memaccess_out_TO_MONITOR_STRUCT_FUNCTION \
  virtual function memaccess_out_monitor_s to_monitor_struct();\
    memaccess_out_monitor_struct = \
            { \
            this.DMem_addr , \
            this.DMem_din , \
            this.DMem_rd , \
            this.memout  \
            };\
    return ( memaccess_out_monitor_struct);\
  endfunction\

  `define memaccess_out_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(memaccess_out_monitor_s memaccess_out_monitor_struct);\
            {\
            this.DMem_addr , \
            this.DMem_din , \
            this.DMem_rd , \
            this.memout  \
            } = memaccess_out_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the memaccess_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define memaccess_out_INITIATOR_STRUCT typedef struct packed  { \
  DMem_addr_t DMem_addr ; \
  DMem_din_t DMem_din ; \
  DMem_rd_t DMem_rd ; \
  memout_t memout ; \
     } memaccess_out_initiator_s;

  `define memaccess_out_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function memaccess_out_initiator_s to_initiator_struct();\
    memaccess_out_initiator_struct = \
           {\
           this.DMem_addr , \
           this.DMem_din , \
           this.DMem_rd , \
           this.memout  \
           };\
    return ( memaccess_out_initiator_struct);\
  endfunction

  `define memaccess_out_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(memaccess_out_initiator_s memaccess_out_initiator_struct);\
           {\
           this.DMem_addr , \
           this.DMem_din , \
           this.DMem_rd , \
           this.memout  \
           } = memaccess_out_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the memaccess_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define memaccess_out_RESPONDER_STRUCT typedef struct packed  { \
  DMem_addr_t DMem_addr ; \
  DMem_din_t DMem_din ; \
  DMem_rd_t DMem_rd ; \
  memout_t memout ; \
     } memaccess_out_responder_s;

  `define memaccess_out_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function memaccess_out_responder_s to_responder_struct();\
    memaccess_out_responder_struct = \
           {\
           this.DMem_addr , \
           this.DMem_din , \
           this.DMem_rd , \
           this.memout  \
           };\
    return ( memaccess_out_responder_struct);\
  endfunction

  `define memaccess_out_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(memaccess_out_responder_s memaccess_out_responder_struct);\
           {\
           this.DMem_addr , \
           this.DMem_din , \
           this.DMem_rd , \
           this.memout  \
           } = memaccess_out_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
