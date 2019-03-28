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

`define ANS_GZ    2'b01
`define ANS_EZ    2'b00
`define ANS_LZ    2'b11

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

// branch type
`define BRANCH_TYPE_WIDTH 4
`define BRANCH_BEQ       4'b0000
`define BRANCH_BNE       4'b0001
`define BRANCH_BGEZ      4'b0010
`define BRANCH_BGTZ      4'b0011
`define BRANCH_BLEZ      4'b0100
`define BRANCH_BLTZ      4'b0101
`define BRANCH_BLTZAL    4'b0110
`define BRANCH_BGEZAL    4'b0111
`define BRANCH_NONE      4'b1111

