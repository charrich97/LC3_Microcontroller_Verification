`include "data_defs.v"
module MemAccess(	mem_state, M_Control, M_Data, M_Addr, memout, Data_addr, Data_din, Data_dout, Data_rd);
   input 	[1:0] 	mem_state;
   input 		M_Control;
   input [15:0] 	M_Data;
   input [15:0] 	M_Addr;
   input [15:0] 	Data_dout;

   output [15:0] 	Data_addr;
   output [15:0] 	Data_din;
   output 		Data_rd;
   output [15:0] 	memout;

   reg [15:0] 		addr;           // addresses for memory address
   reg [15:0] 		din;            // data read from/written to memory
   reg 			rd;                    // read/write signal

   reg [15:0] 		Data_addr;
   reg [15:0] 		Data_din;
   reg 			Data_rd;

`pragma protect begin_protected
`pragma protect version = 1
`pragma protect author = "BobOden"
`pragma protect author_info = "ECE792-036"
`pragma protect encrypt_agent = "RTLC VELOCE", encrypt_agent_info = "1.5"
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VERIF-SIM-RSA-1"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
XKlQpAnHsePvNURGzGJAszEFqtbhJbfnHkKYFVRTGceLJ4LMENGhhi/ilzJ0f4Hw
8wWDF/bc8Qtvq+YLBFeSvHnx9SSthrchoYljchCJsFTLafthwA1aAp6rm6mQOyM3
xxcjg3KHmGlbb3C86oo3K1dmzOTdk0fCpSRzpCL7RGo=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
E0qv0IVEIrfN++8iviPjU2mxhHCXimBpSml1ngvPMJV0NosLweokBX6YKTUi6+6Q
a4Sc4VFZ5yvxXPGI6t62vHtWk+8UsdlFs3+RW+WkxFNtx/YWV3/Tg2sthtCQkVee
cgAuSzEFEfiBxI+O6DbEJlOeJWv1zkX5pwxR35e9Lcs=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
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
`pragma protect end_protected
   
endmodule // MemAccess
