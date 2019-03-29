`timescale 1ns / 1ps
`include "instruction.v"
`include "ctrl_def.v"

module cu(
    input wire rst,
    input wire[5:0] op,
    input wire[5:0] funct,
    
    output reg reg_wen, mem_wen,
    output reg[`BRANCH_TYPE_WIDTH-1:0] branch_type,
    output reg[`ALU_CTRL-1:0] aluctrl,
    output reg[`SEL_ALUOUT_WIDTH-1:0] sel_aluout,
    output reg[`SEL_REGDST_WIDTH-1:0] sel_regdst,
    output reg sel_reg_wdata, sel_srcB
    );
    
    wire Rtype;
    assign Rtype = (op == `INST_TYPE_R) ? 1 : 0;
    
    always @ (*) begin
        if (rst == 1) begin
            reg_wen    = 0;
            mem_wen    = 0;
            branch_type = `BRANCH_NONE;
            aluctrl    = `ALU_ADD;
            sel_aluout = `SEL_ALUOUT_C;
            sel_srcB   = 0;
            sel_regdst = `SEL_REGDST_RD;
            sel_reg_wdata = 0;
        end else if (Rtype) begin
            case (funct)
            `INST_ADD : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_ADDU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SUB : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SUBU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SLT : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SLTU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_AND : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_NOR : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_NOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_OR  : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_OR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_XOR : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_XOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SLL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SL;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SLLV : ;
            `INST_SRA : ;
            `INST_SRAV : ;
            `INST_SRL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            `INST_SRLV : ;
            
            `INST_JR : ;
            `INST_JALR : ;
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
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_ADDIU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_SLTI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_SLTIU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_BOOL;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_ANDI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_LUI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_AND;
                sel_aluout = `SEL_ALUOUT_IMM;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_ORI   : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_OR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_XORI : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_XOR;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_BEQ   : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_BEQ;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_BNE : ;
            `INST_REGIMM : begin
                
            end
            `INST_BGTZ : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_BGTZ;
                aluctrl    = `ALU_SUB;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_BLEZ : ;
            `INST_LB : ;
            `INST_LBU : ;
            `INST_LH : ;
            `INST_LHU : ;
            `INST_LW    : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 1;
            end
            `INST_SB : ;
            `INST_SH : ;
            `INST_SW    : begin
                reg_wen    = 0;
                mem_wen    = 1;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 1;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_J     : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RT;
                sel_reg_wdata = 0;
            end
            `INST_JAL   : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_PC4;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_R31;
                sel_reg_wdata = 0;
            end
            default : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch_type = `BRANCH_NONE;
                aluctrl    = `ALU_ADD;
                sel_aluout = `SEL_ALUOUT_C;
                sel_srcB   = 0;
                sel_regdst = `SEL_REGDST_RD;
                sel_reg_wdata = 0;
            end
            endcase
        end
    end
endmodule
