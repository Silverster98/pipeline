`include "instruction.v"
`timescale 1ns / 1ps

module alu(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[`ALU_CTRL-1:0] alu_ctrl,
    input wire[4:0] sa,
    
    output wire[31:0] C,
    output wire beqout
    );
    
    reg[32:0] temp;
    assign C = temp[31:0];
    assign beqout = (temp == 0) ? 1'b1 : 1'b0;
    
    always @ (*) begin
        case (alu_ctrl)
            `ALU_ADD : temp <= {A[31], A} + {B[31], B};
            `ALU_SUB : temp <= {A[31], A} - {B[31], B};
            `ALU_AND : temp <= {A[31], A} & {B[31], B};
            `ALU_OR  : temp <= {A[31], A} | {B[31], B};
            `ALU_SL  : temp <= {B[31], B} << sa;
            `ALU_SR  : temp <= {B[31], B} >> sa;
            default  : temp <= {A[31], A};
        endcase
    end
endmodule
