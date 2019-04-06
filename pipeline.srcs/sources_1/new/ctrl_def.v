/******** define some value about ctrl signal ********/

// about ALU
`define ALU_CTRL  4
`define ALU_ADD   4'b0000
`define ALU_SUB   4'b0001
`define ALU_AND   4'b0010
`define ALU_OR    4'b0011
`define ALU_NOR   4'b0110
`define ALU_XOR   4'b0111
`define ALU_SL    4'b0100
`define ALU_SR    4'b0101
`define ALU_SLV   4'b1000
`define ALU_SRV   4'b1001
`define ALU_SRA   4'b1010
`define ALU_SRAV  4'b1011
`define ALU_SUBU  4'b1100

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

// sel_srcB
`define SEL_SRCB_WIDTH 2
`define SEL_SRCB_FORD  2'b00
`define SEL_SRCB_IMM   2'b01
`define SEL_SRCB_0     2'b10

// about mem instruction type
`define MEM_TYPE_WIDTH 4
`define MEM_NONE       4'b0000
`define MEM_LB         4'b0001
`define MEM_LBU        4'b0010
`define MEM_LH         4'b0011
`define MEM_LHU        4'b0100
`define MEM_LW         4'b0101
`define MEM_SB         4'b0110
`define MEM_SH         4'b0111
`define MEM_SW         4'b1000
