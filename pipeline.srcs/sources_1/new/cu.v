`timescale 1ns / 1ps
`include "instruction.v"
`include "ctrl_def.v"

module cu(
    input wire rst,
    input wire[5:0] op,
    input wire[4:0] rs,
    input wire[4:0] rt,
    input wire[5:0] funct,
    
    output reg reg_wen, mem_wen, cp0_wen,
    output reg[`BRANCH_TYPE_WIDTH-1:0] branch_type,
    output reg[`ALU_CTRL-1:0] aluctrl,
    output reg[`SEL_ALUOUT_WIDTH-1:0] sel_aluout,
    output reg[`SEL_REGDST_WIDTH-1:0] sel_regdst,
    output reg[`SEL_SRCB_WIDTH-1:0] sel_srcB,
    output reg[`MEM_TYPE_WIDTH-1:0] mem_type,
    output reg[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdata,
    output reg[`SEL_BRANCH_RT_WIDTH-1:0] sel_branch_rt
    );
    
    wire Rtype;
    assign Rtype = (op == `INST_TYPE_R) ? 1 : 0;
    
    always @ (*) begin
        if (rst == 1) begin
            reg_wen    = 0;
            mem_wen    = 0;
            cp0_wen    = 0;
            branch_type = `BRANCH_NONE;
            aluctrl    = `ALU_ADD;
            sel_aluout = `SEL_ALUOUT_C;
            sel_srcB   = `SEL_SRCB_FORD;
            sel_regdst = `SEL_REGDST_RD;
            mem_type   = `MEM_NONE;
            sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
            sel_branch_rt = `SEL_BRANCH_RT_RT;
        end else if (Rtype) begin
            case (funct)
            `INST_ADD : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_ADDU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SUB : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SUBU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLT : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLTU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUBU;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_DIV : ;
            `INST_DIVU : ;
            `INST_MULT : ;
            `INST_MULTU : ;
            `INST_AND : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_NOR : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_NOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_OR  : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_OR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_XOR : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_XOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SL;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLLV : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SLV;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SRA : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SRA;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SRAV : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SRAV;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SRL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SRLV : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SRV;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_JR : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_JALR : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_PC4;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_MFHI : ;
            `INST_MFLO : ;
            `INST_MTHI : ;
            `INST_MTLO : ;
            `INST_BREAK : ;
            `INST_SYSCALL : ;
            endcase
        end else begin
            case (op)
            `INST_ADDI  : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_ADDIU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLTI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SLTIU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_ANDI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_LUI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_IMM;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_ORI   : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_OR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_XORI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_XOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_BEQ   : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_BEQ;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_BNE : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_BNE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_REGIMM : begin
                case (rt)
                `INST_BGEZ : begin
                    reg_wen    = 0;
                    mem_wen    = 0;
                    cp0_wen    = 0;
                    branch_type = `BRANCH_BGEZ;
                    aluctrl    = `ALU_ADD;
                    sel_aluout = `SEL_ALUOUT_C;
                    sel_srcB   = `SEL_SRCB_0;
                    sel_regdst = `SEL_REGDST_RT;
                    mem_type   = `MEM_NONE;
                    sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                    sel_branch_rt = `SEL_BRANCH_RT_ZERO;
                end
                `INST_BLTZ : begin
                    reg_wen    = 0;
                    mem_wen    = 0;
                    cp0_wen    = 0;
                    branch_type = `BRANCH_BLTZ;
                    aluctrl    = `ALU_ADD;
                    sel_aluout = `SEL_ALUOUT_C;
                    sel_srcB   = `SEL_SRCB_0;
                    sel_regdst = `SEL_REGDST_RT;
                    mem_type   = `MEM_NONE;
                    sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                    sel_branch_rt = `SEL_BRANCH_RT_ZERO;
                end
                `INST_BLTZAL : begin
                    reg_wen    = 1;
                    mem_wen    = 0;
                    cp0_wen    = 0;
                    branch_type = `BRANCH_BLTZAL;
                    aluctrl    = `ALU_ADD;
                    sel_aluout = `SEL_ALUOUT_PC4; // can't use, C and PC4 are both needed
                    sel_srcB   = `SEL_SRCB_0;
                    sel_regdst = `SEL_REGDST_R31;
                    mem_type   = `MEM_NONE;
                    sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                    sel_branch_rt = `SEL_BRANCH_RT_ZERO;
                end
                `INST_BGEZAL : begin
                    reg_wen    = 1;
                    mem_wen    = 0;
                    cp0_wen    = 0;
                    branch_type = `BRANCH_BGEZAL;
                    aluctrl    = `ALU_ADD;
                    sel_aluout = `SEL_ALUOUT_PC4; // can't use, C and PC4 are both needed
                    sel_srcB   = `SEL_SRCB_0;
                    sel_regdst = `SEL_REGDST_R31;
                    mem_type   = `MEM_NONE;
                    sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                    sel_branch_rt = `SEL_BRANCH_RT_ZERO;
                end
                endcase
            end
            `INST_BGTZ : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_BGTZ;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_ZERO;
            end
            `INST_BLEZ : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_BLEZ;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_ZERO;
            end
            `INST_LB : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_LB;
                sel_reg_wdata = `SEL_REG_WDATA_MEMOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_LBU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_LBU;
                sel_reg_wdata = `SEL_REG_WDATA_MEMOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_LH : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_LH;
                sel_reg_wdata = `SEL_REG_WDATA_MEMOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_LHU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_LHU;
                sel_reg_wdata = `SEL_REG_WDATA_MEMOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_LW    : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_LW;
                sel_reg_wdata = `SEL_REG_WDATA_MEMOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SB : begin
                reg_wen    = 0;
                mem_wen    = 1;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_SB;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SH : begin
                reg_wen    = 0;
                mem_wen    = 1;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_SH;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_SW    : begin
                reg_wen    = 0;
                mem_wen    = 1;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_IMM;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_SW;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_J     : begin
                reg_wen    = 0;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RT;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_JAL   : begin
                reg_wen    = 1;
                mem_wen    = 0;
                cp0_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_PC4;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_R31;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            `INST_COP0   : begin
                if (funct == `INST_ERET) begin
                end else begin
                    case (rs)
                    `INST_MFC0 : begin
                        reg_wen    = 1;
                        mem_wen    = 0;
                        cp0_wen    = 0;
                        branch_type = `BRANCH_NONE;
                        aluctrl    = `ALU_ADD;
                        sel_aluout = `SEL_ALUOUT_CP0;
                        sel_srcB   = `SEL_SRCB_FORD;
                        sel_regdst = `SEL_REGDST_RT;
                        mem_type   = `MEM_NONE;
                        sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                        sel_branch_rt = `SEL_BRANCH_RT_RT;
                    end
                    `INST_MTC0 : begin
                        reg_wen    = 0;
                        mem_wen    = 0;
                        cp0_wen    = 1;
                        branch_type = `BRANCH_NONE;
                        aluctrl    = `ALU_ADD;
                        sel_aluout = `SEL_ALUOUT_C;
                        sel_srcB   = `SEL_SRCB_FORD;
                        sel_regdst = `SEL_REGDST_RT;
                        mem_type   = `MEM_NONE;
                        sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                        sel_branch_rt = `SEL_BRANCH_RT_RT;
                    end
                    endcase
                end
            end
            default : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = `SEL_SRCB_FORD;
                sel_regdst = `SEL_REGDST_RD;
                mem_type   = `MEM_NONE;
                sel_reg_wdata = `SEL_REG_WDATA_ALUOUT;
                sel_branch_rt = `SEL_BRANCH_RT_RT;
            end
            endcase
        end
    end
endmodule
