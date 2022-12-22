//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the environment package.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//


  // pragma uvmf custom additional begin
typedef enum bit [3:0] { 
	ADD = 4'd1 ,
	AND = 4'd5 ,
	NOT = 4'd9 ,
	BR  = 4'd0 ,
	JMP = 4'd12,
	LD  = 4'd2 ,
	LDR = 4'd6 ,
	LDI = 4'd10,
	LEA = 4'd14,
	ST  = 4'd3 ,
	STR = 4'd7 ,
	STI = 4'd11
} opcode;

  // pragma uvmf custom additional end

