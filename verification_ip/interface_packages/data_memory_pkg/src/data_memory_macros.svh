//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the data_memory package.
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
//      the data_memory_configuration class.
//
  `define data_memory_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } data_memory_configuration_s;

  `define data_memory_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function data_memory_configuration_s to_struct();\
    data_memory_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( data_memory_configuration_struct );\
  endfunction

  `define data_memory_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(data_memory_configuration_s data_memory_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = data_memory_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the data_memory_transaction class.
//
  `define data_memory_MONITOR_STRUCT typedef struct packed  { \
  Data_dout_t Data_dout ; \
  complete_data_t complete_data ; \
  Data_din_t Data_din ; \
  Data_addr_t Data_addr ; \
  Data_addr_t Data_rd ; \
  D_macc_t D_macc ; \
     } data_memory_monitor_s;

  `define data_memory_TO_MONITOR_STRUCT_FUNCTION \
  virtual function data_memory_monitor_s to_monitor_struct();\
    data_memory_monitor_struct = \
            { \
            this.Data_dout , \
            this.complete_data , \
            this.Data_din , \
            this.Data_addr , \
            this.Data_rd , \
            this.D_macc  \
            };\
    return ( data_memory_monitor_struct);\
  endfunction\

  `define data_memory_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(data_memory_monitor_s data_memory_monitor_struct);\
            {\
            this.Data_dout , \
            this.complete_data , \
            this.Data_din , \
            this.Data_addr , \
            this.Data_rd , \
            this.D_macc  \
            } = data_memory_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the data_memory_transaction class.
//      Also update the comments in the driver BFM.
//
  `define data_memory_INITIATOR_STRUCT typedef struct packed  { \
  Data_dout_t Data_dout ; \
  complete_data_t complete_data ; \
  Data_din_t Data_din ; \
  Data_addr_t Data_addr ; \
  Data_addr_t Data_rd ; \
  D_macc_t D_macc ; \
     } data_memory_initiator_s;

  `define data_memory_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function data_memory_initiator_s to_initiator_struct();\
    data_memory_initiator_struct = \
           {\
           this.Data_dout , \
           this.complete_data , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd , \
           this.D_macc  \
           };\
    return ( data_memory_initiator_struct);\
  endfunction

  `define data_memory_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(data_memory_initiator_s data_memory_initiator_struct);\
           {\
           this.Data_dout , \
           this.complete_data , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd , \
           this.D_macc  \
           } = data_memory_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the data_memory_transaction class.
//      Also update the comments in the driver BFM.
//
  `define data_memory_RESPONDER_STRUCT typedef struct packed  { \
  Data_dout_t Data_dout ; \
  complete_data_t complete_data ; \
  Data_din_t Data_din ; \
  Data_addr_t Data_addr ; \
  Data_addr_t Data_rd ; \
  D_macc_t D_macc ; \
     } data_memory_responder_s;

  `define data_memory_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function data_memory_responder_s to_responder_struct();\
    data_memory_responder_struct = \
           {\
           this.Data_dout , \
           this.complete_data , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd , \
           this.D_macc  \
           };\
    return ( data_memory_responder_struct);\
  endfunction

  `define data_memory_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(data_memory_responder_s data_memory_responder_struct);\
           {\
           this.Data_dout , \
           this.complete_data , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd , \
           this.D_macc  \
           } = data_memory_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
