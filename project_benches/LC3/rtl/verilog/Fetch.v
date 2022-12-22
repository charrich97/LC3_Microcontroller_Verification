`include "data_defs.v"
module Fetch(clock, reset, enable_updatePC, enable_fetch, pc, npc_out, instrmem_rd, taddr, br_taken);
  	input 			clock, reset, br_taken, enable_fetch, enable_updatePC;
  	input 	[15:0] 	taddr;
  	//input [3:0] 	state;
  	output 	[15:0] 	pc, npc_out;   // current and next PC
  	output 			instrmem_rd;
	
  	//reg		[15:0]	npc_out;
  	reg 	[15:0] 	ipc;        // internal PC
  	wire 	[15:0] 	muxout;
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
D0PUH1vaYxB0SZu2v0lPvFjkxWmhcN1SmUxOLuOc0tYS6l3UDGcxDeBNCmIXFDnk
MBjs8eSapdjTx4nu7/Eb8PRdwZACH0qSHURMy05Tz4XJ/W12tGxcmIwN1TsAg3hq
N7vvEI4uKrrbvknqOwbkzsRuX+U2g42rnxYMC3g7Yzs=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
Ssbt4d2b/NjxDG9b2URmLACs+VRT5ENZL1qIPc5zUgokjkE4TM4SHbMsM3QQpYQe
Uek1ebLQgUa32sF10SWje25MmcGu3dr8RI1SEPDVsa+3zNRAJ3VPc69/c+y6eKla
nUpAh/2BmtBy7q0bH7YcjpmBEGxG1NbKq1WTyfnJVz8=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
NwPXa1SzsOznektqtHoghCJ3QshGOi258irJ7pF/Kxy2hYH9mf0arxwyYhw31SQH
S+4wZN2eMrq0lD0btYswsFVNazeKYYuBHsQ9potajkca0NsBDxgy/uQlSqevhWNK
sCzNfsFVvJe7564xmU6mUUf6lMVD0oUNO9/zUTj0cZSoMOWL3J+oRk/7K+hu1WMl
EfC+SvZosBD9JxoVMvdBvVxYUr/SXak2OpxHbo1g/mTuLiBvVGZPNQy7QRMH1rAE
DZjkcP/uFNwSxamrFPg+C2UA/akZk8PqvZu9sidQ+H3cXbYNzr4LO7oolHazR3Eh
Pnv2a3+5CG4x9XQbLLqVAGulQRdZ5y0Z93Fobm2nwVry1BYTSli1dNTY4DaBJ68T
5fPoz7ybL86QIFHxchgfSar+EMurQtyuVvQ4kW506yirwSNw8B1vG40ow3x2r5to
CGKhalFZPPQ6MyIJF0SF1dxf/SMLsTets5NHdhoEK+AJ8QF027yD9Tk1ZpCmEPZR
Q8Wdf215fbKDAImsib3s8HBYF00758zEst8AZ+Viv+dx60LIPE//vhHjzcK+AZAd
3WXbypNPgy5lfMBJ7sXd0/OYaoleT6AM7z+W8n9CLY+JWdwxg8TfxWksTSa1SK5W
AR4wUcqKL6ctpVRKnOytriQU3L0mhPbvokwo8P7HPJTjsNVoxuYFT38O4cyDt5fd
ffy0uZzLzKN+MQrrIBfLtDBj35X3+CT08ftl7diN3yDXlkVez5uh6V7AHdwUbAcB
PIpPZKn9hJ0mmtTHsQ+1Yli8TdGO+koTv2Zaz/lyp8kzfMiFt2yQJnMox63cicNI
ryPEvdU0AskdB5fC+LV1P/ZBgcJeFNlTefD1RjHyLHFFEb29CSYN2XiZtr5wt7mi
W5i0iOSr9AwvKovHf38qE6DZ0GGdAtSXHc1HJR6dUpsXbdneJks3tl1L+3PCbvOP
w6kXyD+QZrDJZmCNURQofUrXI/ZxvaaKWZIn3aWXWdGhYUHqHGvnmwvJMQQhfCFw
7Yj1n6SZTwOQhQw3+U44QxBTsv7BXvL+nGlxk66hxM7YgrIXjtXPXPbaOqASQiDX
gWrsqOo4tdncplNc4v57qg==
`pragma protect end_protected
  								
endmodule
