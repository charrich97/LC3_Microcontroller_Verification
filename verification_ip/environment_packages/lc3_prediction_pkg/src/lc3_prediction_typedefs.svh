typedef enum bit [3:0] {
  ADD = 4'b0001,
  AND = 4'b0101,
  BR  = 4'b0000,
  JMP = 4'b1100,
  JSR = 4'b0100,
  LD  = 4'b0010,
  LDI = 4'b1010,
  LDR = 4'b0110,
  LEA = 4'b1110,
  NOT = 4'b1001,
  RTI = 4'b1000,
  ST  = 4'b0011,
  STI = 4'b1011,
  STR = 4'b0111,
  TRAP = 4'b1111,
  RESERVED = 4'b1101
} opcode_t;

typedef enum bit [1:0] {
  CONTROL,
  ALU,
  MEMORY,
  PRIVILEGE
} optype_t;

typedef enum bit [1:0] {ALUOUT=2'd0, MEMOUT=2'd1, PCOUT=2'd2} w_control_t;
typedef enum bit {MEM_CONTROL_ENABLED=1'b1, MEM_CONTROL_DISABLED=1'b0} mem_control_t;
