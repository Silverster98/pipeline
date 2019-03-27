/******** define some value about ctrl signal ********/

// about ALU
`define ALU_CTRL  3
`define ALU_ADD   3'b000
`define ALU_SUB   3'b001
`define ALU_AND   3'b010
`define ALU_OR    3'b011
`define ALU_NOR   3'b110
`define ALU_XOR   3'b111
`define ALU_SL    3'b100
`define ALU_SR    3'b101

// about sel_aluout signal
`define SEL_ALUOUT_WIDTH 2
`define SEL_ALUOUT_C     2'b00
`define SEL_ALUOUT_IMM   2'b01
`define SEL_ALUOUT_BOOL  2'b10
`define SEL_ALUOUT_PC4   2'b11

// about sel_regdst signal
`define SEL_REGDST_WIDTH 2
`define SEL_REGDST_RT    2'b00
`define SEL_REGDST_RD    2'b01
`define SEL_REGDST_R31   2'b10
