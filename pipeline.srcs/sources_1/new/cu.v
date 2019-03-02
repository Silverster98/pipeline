`timescale 1ns / 1ps
`include "instruction.v"

module cu(
    input wire[5:0] op,
    input wire[5:0] funct,
    
    output reg reg_wen, mem_wen, branch,
    output reg[2:0] aluctrl,
    output reg sel_reg_wdata, sel_srcB, sel_regdst
    );
    
    initial begin
        reg_wen    = 0;
        mem_wen    = 0;
        branch     = 0;
        aluctrl    = `ALU_ADD;
        sel_srcB   = 0;
        sel_regdst = 0;
        sel_reg_wdata = 0;
    end
    
    wire Rtype;
    assign Rtype = (op == `INST_TYPE_R) ? 1 : 0;
    
    always @ (*) begin
        if (Rtype) begin
            case (funct)
            `INST_ADD : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_ADD;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            `INST_SUB : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_SUB;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            `INST_SLT : ;
            `INST_OR  : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_OR;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            `INST_AND : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_AND;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            `INST_SLL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_SL;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            `INST_SRL : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_SR;
                sel_srcB   = 0;
                sel_regdst = 1;
                sel_reg_wdata = 0;
            end
            endcase
        end else begin
            case (op)
            `INST_ADDIU : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_ADD;
                sel_srcB   = 1;
                sel_regdst = 0;
                sel_reg_wdata = 0;
            end
            `INST_ADDI  : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_ADD;
                sel_srcB   = 1;
                sel_regdst = 0;
                sel_reg_wdata = 0;
            end
            `INST_ORI   : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_OR;
                sel_srcB   = 1;
                sel_regdst = 0;
                sel_reg_wdata = 0;
            end
            `INST_BEQ   : begin
                reg_wen    = 0;
                mem_wen    = 0;
                branch     = 1;
                aluctrl    = `ALU_SUB;
                sel_srcB   = 0;
                sel_regdst = 0;
                sel_reg_wdata = 0;
            end
            `INST_LW    : begin
                reg_wen    = 1;
                mem_wen    = 0;
                branch     = 0;
                aluctrl    = `ALU_ADD;
                sel_srcB   = 1;
                sel_regdst = 0;
                sel_reg_wdata = 1;
            end
            `INST_SW    : begin
                reg_wen    = 0;
                mem_wen    = 1;
                branch     = 0;
                aluctrl    = `ALU_ADD;
                sel_srcB   = 1;
                sel_regdst = 0;
                sel_reg_wdata = 0;
            end
            `INST_J     : ;
            `INST_JAL   : ;
            endcase
        end
    end
endmodule
