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
`define SEL_ALUOUT_WIDTH 3
`define SEL_ALUOUT_C     3'b000
`define SEL_ALUOUT_IMM   3'b001
`define SEL_ALUOUT_BOOL  3'b010
`define SEL_ALUOUT_PC4   3'b011
`define SEL_ALUOUT_CP0   3'b100
`define SEL_ALUOUT_HI    3'b101
`define SEL_ALUOUT_LO    3'b110

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
`define SEL_SRCB_ZIMM  2'b11

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

// about sel reg_wdata
`define SEL_REG_WDATA_WIDTH 1
`define SEL_REG_WDATA_ALUOUT 1'b0
`define SEL_REG_WDATA_MEMOUT 1'b1

// about cp0
`define CP0_REG_COUNT   5'b01001
`define CP0_REG_COMPARE 5'b01011
`define CP0_REG_STATUS  5'b01100
`define CP0_REG_CAUSE   5'b01101
`define CP0_REG_EPC     5'b01110
`define CP0_REG_PRID    5'b01111
`define CP0_REG_CONFIG  5'b10000

// about branch judge
`define JUDGE_EZ 2'b00
`define JUDGE_GZ 2'b01
`define JUDGE_LZ 2'b11 

// about sel_branch_rt
`define SEL_BRANCH_RT_WIDTH 1
`define SEL_BRANCH_RT_RT    1'b0
`define SEL_BRANCH_RT_ZERO  1'b1
