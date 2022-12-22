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
// the simulation running on the emulator when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
                                                                               

typedef enum bit [3:0] {RESERVED = 4'b1101, TRAP = 4'b1111, RTI = 4'b1000, JSR = 4'b0100,ADD=4'b0001, AND=4'b0101, NOT=4'b1001, LD=4'b0010, LDR=4'b0110, LDI=4'b1010, LEA=4'b1110, ST=4'b0011, STR=4'b0111, STI=4'b1011, BR=4'b0000, JMP=4'b1100} op_t;
typedef bit [2:0] reg_t;
typedef bit im_t;
typedef bit [2:0] baser_t;
typedef bit [8:0] pcoffset9_t;
typedef bit [5:0] pcoffset6_t;
typedef bit [4:0] imm5_t;
typedef bit [2:0] nzp_t;
typedef bit instrmem_rd_t;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

