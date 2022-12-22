`include "data_defs.v"
module Writeback(	clock, reset, enable_writeback, W_Control, aluout, memout, pcout, npc, 
					sr1, sr2, dr, d1, d2, psr // connections to register file
				);
  	input 			clock, reset, enable_writeback;
  	input 	[15:0] 	aluout, memout, pcout, npc;
  	input 	[1:0] 	W_Control;
  	
  	input 	[2:0] 	sr1, sr2, dr;     	// source and destination register addresses
  	
  	output	[2:0]	psr;
  	output 	[15:0] 	d1, d2;				// two read port output

  	reg 	[15:0] 	DR_in;      	
	reg		[2:0]	psr;
  	// MODIFICATION_RAVI we can write to the register file here and need a enable_writeback signal somewhere 
  	RegFile RF 	(	.clock(clock), .sr1(sr1), .sr2(sr2), 
  					.din(DR_in), .dr(dr), .wr(enable_writeback),
  					.d1(d1), .d2(d2) 
  				);
  	
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
cknIeT5DVbu8+RLiaEtPiD0ohvVr4QWQjtIoT/sFzRDYloWpZVhMYYzYDk3Ci95U
X5w9tAnp1p7mMKuUagTMow10n0MUIziH/xgy9erMn5WUdBemvLgrCZT7K2fKNDAo
NXd8wPk7Jj5UHPrLP4Fon1mOj/F2ExhVHfSsmD72cY8=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
sstBvoVc3qHkHuALbRJmMPBuPLYdMNzI63VJ6oC+eEV59Q+MokdWN8uBkIW88Ud1
18SeSlivEViPHB+p1yvDRQkIHKnl+3V4EPu/cUQyq9CB2/8QyP7SNoPToYspMviB
Og0w1xWvrjroI6djFzrRjJf59SH7gN7ZnAU+hwgLPCo=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
P0vZ7FDjuFjc5ktkoVIahXoX//XaS5xb7RWG1PbqZsmlWmZKzMXy/zkrQZhRfTBE
MOOQtU6wJ50HwCjT6CO/P8a8p0kkhuqEjx+zpJmJvphwiF6S4fRYW8hqi10MYHkI
+u8RVL70vHN0OKZ7KD8Wn2TOOamH+3SFh/aBguuO2C3B6CIw4yhqmVC3O563lPBr
XK3l0oZ1FE0VrC+fZh/G113IUI+VZo5jNUHwZoPXjUZQ1yGfmuwNno/5ANXwj/Om
s9dZifSylSkZHZyLo8xj+RoqjQ5tMOZssQH7q2vV7MN4z+cpfuznRNGknyeJu8R0
wgBjoFOVROMh4gwIPKrGsDgmkMMncInC1jjlkeG+uJd/WROFABG1Gc94LwxVqJae
QU4gdQKJgl+mqmTLv0VhOEGWBMt/22Gnq1JMzRb22kpiBI+6wsBJeAsL8LyhqydU
PWtVt0UYYf85SPRTvKbA0GlFPgRXNkioruvFDDIBxQaZ+yGZUTGl07xe7th/wi0S
RvmaSoKioFF1mRbGvlJCUgocePx6aRBdokAzRr6GjsPD2ztMZV/WsJB2piGMKfZ0
c/p3jHRaXOK4HCzS8vJ95uJ2bd+6JNv2D7NZQmaAXQ1XO6dMSSA51qKgRdzbG9kk
pO7L6Y7ncdbbhkvu5HYmMDa22Nd761eMk7MKC0NQBQmGm6aU2EU6gfKmqvuL52+L
zn7hvZ/3Rq/ylHXuiJMM2ISqpuZEMBzZ3E68mSB6CoSG1kvDlZdq+dY/RNnmJrAM
SdrOf6RYiyNsfBagIQYHPrUfqiMh/9Z3zAA1+xY02e8y90Q0QnbPlkx5wkiv9isq
y0T5X9VXMoJn+XPTCusWpi0ujT29oPYFnPQQMMiSMgNbwFYC2sfeEeePlVyrOvIA
VbHCPbBwgkVDCaNBZl75QxVs2DN8Gd1eKunahcBMX2oTY1Ts4lnOuetOVrbRl+5K
0SytFAaJq/PDcYmiXFgKMeVAWDYdfrYJsTPyyOVyOo0=
`pragma protect end_protected
endmodule

// registerfile consists of 8 general purpose registers
module RegFile(clock, wr, sr1, sr2, din, dr, d1, d2); // 

  	input 			clock, wr;
  	input 	[2:0] 	sr1, sr2, dr;     	// source and destination register addresses
  	input 	[15:0] 	din;             	// data will be stored
  	output 	[15:0] 	d1, d2;				// two read port output

  	reg 	[15:0] 	ram [0:7] ;
  	wire 	[15:0] 	R0,R1,R2,R3,R4,R5,R6,R7;

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
dl/rHn9rXPS5/+JbU03mIaHSkbsp2h+Ng81auVRH+PSfD/Wzrmg+NEC/a4a4TfrW
2r1j7T5c4YGjYXoN4VXHtKU0zm7+cwOc8AVQ5+7RtGyWBNV+cYv7Ite/cwYvnplo
SCl+aqZz14vfu5o+EO4NXlH1Bw/bX56FZC/gRZ7DZBg=
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_keyname =  "MGC-VELOCE-RSA"
`pragma protect key_method = "rsa"
`pragma protect encoding = ( enctype =  "base64")
`pragma protect key_block
At0/kY7xWJEa3vfXN2PoVf6xvPEXYIsuXynI1zfbN+7kxYi6m93oTEz5M1LVf40k
trfSweH2bMwXd6kq6+D1TZMivL0935eGNl2zkqPJD3g9IX8ngEQtdW1YmoqSeaEB
HH9sDtzEHfPMJ14hfSOpfhZnXZ4KSkGOuDX0oXYV9MI=
`pragma protect data_method =  "aes128-cbc"
`pragma protect encoding = ( enctype =  "base64" )
`pragma protect data_block
lPRtPan8DN43/DixeS6Xn8ncChUGKnjdw2ZqHcp1v1wG15beoiJVw+NDRjqlmgkP
YZlDBJ4DZ/GcmA2AEOVGkxuLb+HOLcggTbVecKUkBeCpjBTcInM0KYMIeqVrmmoo
pTnvCihlnNUGDDEGKQXHASYcEmqJOkqxI4zZsFoi7XnxawpA98WQvnuBFxEYf5HU
gn9oH6k1r22+W1qukr1Lm64ZpT+P7mXE6Pzf+e87aiG0/v1JR2jIzBEnvUgte/VJ
YD11IfYf9ewYH1dsur4J2O/dcf59ru910DsOrecbURgApKFn+4LwhFmugQm5wTwW
pXbbfSzrKJXRw3DkMImXpmZN4zKoeAYuhFtW6Z+GK+lzcfftAur4h1Q448+4c19p
8jwtl2rbmYFMKwh2R/W0sAy+Z1sQQHomeu03MefioiDQJg39gL0qlSaFmJUIpww/
9uj+CYghy3tnflkiH3RPtntj2H+aPjOb7II4/dqoMxoig9mR6pKiCA1X8xZdGB75
7sXBk+FAvsQc+xoj7+wv98i3Py0QcPuYKNZhaK5amm3LRJPNnOfSiWbD2XshaJ8N
h20T7Ltd1AHdVnKR6qTHetfGNiuEb/UtwBOrn16IhWtzpP/iqr4wTCUhC6iQu3Jx
Kq01GyjFWWv+mJ3ZZbYX69WAZWcNzCjyBGTZ5hhT2D91++q5kMwKYlfzOjFb6HVh
2xoH1wesPrFIqYfM+YhwBV7pe60Uw/Onq9AB0eeG/5XiZCVc1ELtBzpiAIEoaORD
QtgGFw26uw7i/mM9r1ykHokwIudwP4cuLVI/AswhyD+6rvACs0/by5gOgiWqlpr7
GNmpsZrrE7iNrIQCoqX07c3cOhTNV81LkSPA8x1GznK/ig1PyUK4Kdg+pksoyvyn
IoPQNcrKgE58ylMFwj6bWX9MxWJV/91TfZDmA4NnAZl1npi8sC8p9Q9Aay+Jk0cg
Bm77I2CGfQOgQoYzpExROCrX0FYUy2tFkZ4gFXLQoSYQMo2JliVUT+d+SCn4D5MY
dzgYNro0l1BNPkw++n3Nehyoa0LGzC6b6jESHmevGJ2RDsS/NTE3gjYMeu9pGk3A
tyB5uKLrgXnvD+KsUuN9fdRyYhGPaptiXIiaIlKIQGT48PFpfVXj2a9F+DhQjW6W
TATspk5PSC/y5KO0/6fAVC9OOr1m55K/ZqNnHP0Kwniufokt0LcOmNFLXvsag5rX
`pragma protect end_protected
  // These lines are not necessary, but they allow
  // viewing of the the registers in a waveform viewer.
  // They do not affect synthesis.
  	assign 	R0	=	ram[0];
  	assign 	R1	=	ram[1];  
  	assign 	R2	=	ram[2];
  	assign 	R3	=	ram[3];  
  	assign 	R4	=	ram[4];
  	assign 	R5	=	ram[5];  
  	assign 	R6	=	ram[6];
  	assign 	R7	=	ram[7];
   
endmodule
