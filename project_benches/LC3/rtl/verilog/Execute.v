`include "data_defs.v"
module Execute(		clock, reset, E_Control, bypass_alu_1, bypass_alu_2, IR, npc, W_Control_in, Mem_Control_in, 
			VSR1, VSR2, enable_execute, Mem_Bypass_Val, bypass_mem_1, bypass_mem_2, 
			W_Control_out, Mem_Control_out, NZP, IR_Exec, 
			aluout, pcout, sr1, sr2, dr, M_Data); 	// MODIFICATION_RAVI Need in put in the bypass that could 
   // be either VSR1 or VSR2. Need controls for that as well. 

   input			clock, reset, enable_execute;
   input [1:0] 			W_Control_in;													
   input 			Mem_Control_in;													
   input [5:0] 			E_Control;
   input [15:0] 		IR;
   input [15:0] 		npc;
   input [15:0] 		VSR1, VSR2, Mem_Bypass_Val;
   input			bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2; //bypass1 and bypass2 allow for the use of bypass values for either VSR1 or VSR2 
   output [15:0] 		aluout, pcout;
   output [1:0] 		W_Control_out;
   output			Mem_Control_out;
   output [2:0] 		NZP;
   output [15:0] 		IR_Exec;
   
   output [2:0] 		sr1, sr2, dr;
   output [15:0] 		M_Data;
   
   reg [2:0] 			sr1, sr2, dr;
   reg [1:0] 			W_Control_out;
   reg				Mem_Control_out;
   reg [15:0] 			M_Data;

   wire [15:0] 			offset11, offset9, offset6, imm5, trapvect8;
   wire [1:0] 			pcselect1, alu_control, alu_control_temp;
   wire 			pcselect2, op2select;
   reg [15:0] 			addrin1, addrin2, aluin1_temp, aluin2_temp;
   wire 			alucarry; 		// overflow checking not implemented
   wire [15:0] 			VSR1_int, VSR2_int;
   wire 			alu_or_pc; 
   wire [15:0] 			aluin1, aluin2;
   reg [2:0] 			NZP;
   reg [15:0] 			IR_Exec;
   //assign {IR, VSR1, VSR2}=D_Data; // the D_Data values is going to come in from the register file based on the 
   // the sr1 and sr2 values sent to the RF from the Execute. 
   // create the correct sr1 sr2 values for reading the register file
   
   ALU 		alu		(clock, reset, aluin1, aluin2, alu_control, enable_execute, aluout, alucarry);
   extension 	ext		(IR, offset11, offset9, offset6, trapvect8, imm5); // IR and trapvect8 are not used for this project
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
DVMKBZjAn15DcJQitrqcgZ3iX0Btr8SzNW8p7V7CbYy8iu2kS0L14eQuDua43JCO
KHkD0o4V1fvk5GrF61p1g25lyWHaOE66S18H2ypvkoAEdtzXGaYc36i46YO2kRNz
9oCCOzJhvCVncs+tGqPiSr6pQobL5udnpuw3ZS4DLqc=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
YHaZHQ8DxG0338E4e3fKLQaTkl3Wkxh9NlKU+2Bkx3R//dGlSbJCppVjuPdfRx4D
P5EozUK5mk5INYvBiRfRa6d+kAH3KZa0BGx1PcGb4WC16ecknBjJFFzqcPUqVQTV
FtlSty5A9+wE6dgASX80j6lsBCdTMOpS9AH3ObZkAg0=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
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
fxlHs4BPs2oLTzkKDO8TWw==
`pragma protect end_protected

endmodule

module extension(ir, offset11, offset9, offset6, trapvect8, imm5);
   input 	[15:0] 	ir;
   output [15:0] 	offset11, offset9, offset6, trapvect8, imm5;

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
kgqBr5spOJRlKyOToPsX/FMvcEyAJRCmd6hNh0aGVVsf0neAWVe0b9wG06hJv4Q6
q8+2Koy3VjRC3vDL8kY6BVu54MAuCzBYTlZQN5jaM13tXMQyYFz0YdB1ocsEzDs6
EmVp8oHYPvw89MkdE1Fzr9WIMhZ7Xo31owGpSUrWCCw=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
JllwSB57lVU0u4aSolIXITBxsmTZpJZw2RXVPc7qcD4vOxSlLxjpqY7Lz+g+rTBU
c///FKP4vpk7/68pCwH4KAjwv/y92Ad2LJ5eaqaloPconIGrhgsvkUHF57qlAWVC
jfn5RMuLn+Hu8wqz5U74dpRge58rCWiLORjHxhUFHN0=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
84BSvx0bUPmvm6H8Ds5nv+ieEu2ed52HS9LRA1wn+g63yKfldm3DYZogNuincfFj
1y3uUMU8HN6tXtL2/+iUe6aFVFF73mBYOM68W1zqnC9dpkIyulhWpDyjIdPYEzvZ
UFxF+fzZULHQdXr9g5ehN36XkMu3spNXxTvfKv58QF52VlEX9l3HNzbsKkyLwT6X
lA0L9FFux2FLODM2ViT+X5rfxHDT1QayAo4YvPW3lHSS/uWFc4HOrTqjux1uo71p
FCjHl+T1vPtBa8Vm6LkE2HxURERppoIvXZQWEsz/rJ+l3Z6mChFbFg9ELKQfOqyB
8FW6yRuk8PHlU3YgR4gJ4dSBOal4EcUkc7AQWoKTQrZv21f1D6necP0G0GRJ0X7v
dDyy3C1qxAr7vux8U6sO/M9Kqi5mJb2vAxOJNnUgS6uWsX61G7QiFkja4S0CCrK0
ffOyzbWnCnmwL6VRiHDpXweMRZSmaCk6nbYM9XKk/+blG19hZ6b5TwxuIc59NHJF
O3bJJu1JPRV3uw9HcqX+LrpMuwexoIMLbbqE8nx37cmbD85D4MxG5enNPsa1a4EQ
i75zamwlUKdtzAyesI/jbs+SH+EZ3cvwOsq/CMJZGXiLFiZnPt4T88VWm5/ybUyY
XAn0pizthNEquE0ZnbH/7RsyqIPXX318BvqMEmyqPuA=
`pragma protect end_protected
endmodule //extension

module ALU(clock, reset, aluin1, aluin2, alu_control, enable_execute, aluout, alucarry);
   
   input			clock, reset;
   input [15:0] 		aluin1, aluin2;
   input [1:0] 			alu_control;
   input			enable_execute;
   output [15:0] 		aluout;
   output 			alucarry;
   
   reg [15:0] 			aluout;
   reg 				alucarry;

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
FRwR91q2WYbjIjHmLGRfFh8tT7FjTpUNoPaDJyZharOhNLKW4F6L1BswXqyfiCdv
yk7fTYWAOmwshO6zhyE0X33yzCPegnQXEZxwBPWEDBnmAohIQt8vY8OkO5p/hVtM
1ZoU1gTZavHWN3L98oLs1g7B69bpAyqCLyfqsc24Tjc=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
gAVcKMSrREx3gxrdkqZw5rJlL6DScQnbU2eJ5Lxo4x1uFst3/+DZBdQ+WAsZ5d6u
ownsB2YL3VbstJKhu6LXzT5W7kReZahIUC2bJM6xRusEnKRTO4lpYKjtYE+mtVoc
9ECHKKfevGaKiRXAsQGc7SN1u1yTmblmdr3v3MESnmI=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
v6gwDC9hc3cEBMACi8W6UXNeV37acoaucgazyGzi4B5Bk8zIyhBFoAUwj34SEgN0
LEE5kjNMssrkRodXOgemFIJETui+T2JFvmjiUyi7NJcQFzaTKda1XA7ADEsHik5B
3us4XF46Xl0AAe3YmvtnHNmzHniBwgFD/60vwQpJkrnC4k+OYjERZU6Iko51g5AQ
eXfht7hwfaqYBbXixnXduYKLZirvuenLhTqAZtyyLuZOzbUpnqJRPy4RxXqovHH9
rSRO8Wy/EAyFcQR2pyi6/sXRszHkZDklAtf2lUOq66ezAnD0hvlaH1gCxKYFxY6V
57EZ49VfiXRU2zYLzbRumim2DpHDcD7GZt4sg45Uj+ZOADAeDm38420ovwe8/sjQ
NNm3wQuPs3OUpwg69ZpBA3MRIcahNJivNMm7ewfLadNfTFO8p+zxOVNeYgZOfqGY
LGR1i1xUADliQmI4XTFEgN5ebqUcnGG14htJJoZ465/KH+wiJk/ALgItqIIQz3xb
fmRK4tW4gKAh87hgcGQR4LEyoBqV/qadu7yRgD8Yy81uZvZQAjA6go8eAurluLQd
1p/m4zdoZ4aH9PTYcklUCVeaC9MG1P48RcIgjNlf4VXfnUxbtGVZym/KKPAaxSk5
kdk1I1N6nTWBxmHZjHcnSUKfwZVdhT7mdh47V5TmTaQE67LWfyRRZhrAcV58+YFe
Q8aqxcEbCmaOXsDddOhsFYOQLsGuPonlwnStSDMsRNww9spSL/8TJ/sHz27lH8LG
3Ck1zJclLX55EjovlV2OstwSVVfK1DuMptJMu+WWU7dYDbzolXB4GlL4QKikkaAw
zopJKxKq4iSY3TTe/Lu7U2OBU+aBl6BNwt/VCLv4+00b7nmHcCDxcrroqbpt3Rzw
30w4ufgcyRBNAVKH+bw4cGilwbyOC9Wixnp3mB8Lh67wtGvK0NISYY26Bl2ktVXJ
nUdgwfX7MLbKtzUz4Akk6Q==
`pragma protect end_protected
endmodule // ALU
