/******************** type R **********************/
`define INST_TYPE_R     6'b000000 // decode according to funct field, op = 6'b000000
    // arithmetic operation
    `define INST_ADD    6'b100000 // add  (overflow test)
    `define INST_ADDU   6'b100001 // addu (no overflow test)
    `define INST_SUB    6'b100010 // sub  (overflow test)
    `define INST_SUBU   6'b100011 // subu (no overflow test)
    `define INST_SLT    6'b101010 // slt
    `define INST_SLTU   6'b101011 // sltu
    `define INST_DIV    6'b011010 // div
    `define INST_DIVU   6'b011011 // divu
    `define INST_MULT   6'b011000 // mult
    `define INST_MULTU  6'b011001 // multu
    
    // logical operation
    `define INST_AND    6'b100100 // and
    `define INST_NOR    6'b100111 // nor
    `define INST_OR     6'b100101 // or
    `define INST_XOR    6'b100110 // xor
    
    // shift operation
    `define INST_SLL    6'b000000 // sll
    `define INST_SLLV   6'b000100 // sllv
    `define INST_SRA    6'b000011 // sra
    `define INST_SRAV   6'b000111 // srav
    `define INST_SRL    6'b000010 // srl
    `define INST_SRLV   6'b000110 // srlv
    
    // jump
    `define INST_JR     6'b001000 // jr
    `define INST_JALR   6'b001001 // jalr
    
    // move
    `define INST_MFHI   6'b010000 // mfhi
    `define INST_MFLO   6'b010010 // mflo
    `define INST_MTHI   6'b010001 // mthi
    `define INST_MTLO   6'b010011 // mtlo
    
    // trap
    `define INST_BREAK  6'b001101 // break
    `define INST_SYSCALL 6'b001100 // syscall
    
    
/******************** type I **********************/
// arithmetic operation
`define INST_ADDI       6'b001000 // addi (overflow test)
`define INST_ADDIU      6'b001001 // addiu (no overflow test)
`define INST_SLTI       6'b001010 // slti
`define INST_SLTIU      6'b001011 // sltiu

// logical operation
`define INST_ANDI       6'b001100 // andi
`define INST_LUI        6'b001111 // lui
`define INST_ORI        6'b001101 // ori
`define INST_XORI       6'b001110 // xori

// branch
`define INST_BEQ        6'b000100 // beq
`define INST_BNE        6'b000101 // bne
`define INST_REGIMM     6'b000001 // regimm // decode according to rt
    `define INST_BGEZ   5'b00001  // bgez
    `define INST_BLTZ   5'b00000  // bltz
    `define INST_BLTZAL 5'b10000  // bltzal
    `define INST_BGEZAL 5'b10001  // bgezal
`define INST_BGTZ       6'b000111 // bgtz
`define INST_BLEZ       6'b000110 // blez

// memory access
`define INST_LB         6'b100000 // lb
`define INST_LBU        6'b100100 // lbu
`define INST_LH         6'b100001 // lh
`define INST_LHU        6'b100101 // lhu
`define INST_LW         6'b100011 // lw
`define INST_SB         6'b101000 // sb
`define INST_SH         6'b101001 // sh
`define INST_SW         6'b101011 // sw


/******************** type J **********************/
// jump
`define INST_J          6'b000010 // j
`define INST_JAL        6'b000011 // jal

// privilege
`define INST_COP0       6'b010000 // cop0
    `define INST_ERET   6'b011000 // eret // decode according to low 6 bit
    `define INST_MF     5'b00000  // mf // decode according to rs
    `define INST_MT     5'b00100  // mt // decode according to rs
