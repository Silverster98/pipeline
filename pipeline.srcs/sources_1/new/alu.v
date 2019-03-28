`include "instruction.v"
`include "ctrl_def.v"
`timescale 1ns / 1ps

module alu(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[`ALU_CTRL-1:0] alu_ctrl,
    input wire[4:0] sa,
    
    output wire[31:0] C,
    output wire[1:0] ans_status
    );
    
    reg[32:0] temp;
    assign C = temp[31:0];
    assign ans_status = (temp == 0) ? `ANS_EZ :
                        (temp > 0 ) ? `ANS_GZ :
                        `ANS_LZ;
    
    always @ (*) begin
        case (alu_ctrl)
            `ALU_ADD : temp <= {A[31], A} + {B[31], B};
            `ALU_SUB : temp <= {A[31], A} - {B[31], B};
            `ALU_AND : temp <= {A[31], A} & {B[31], B};
            `ALU_OR  : temp <= {A[31], A} | {B[31], B};
            `ALU_NOR : temp <= ({A[31], A} | {B[31], B}) ^ 33'h1ffffffff;
            `ALU_XOR : temp <= {A[31], A} ^ {B[31], B};
            `ALU_SL  : temp <= {B[31], B} << sa;
            `ALU_SR  : temp <= {B[31], B} >> sa;
            default  : temp <= {A[31], A};
        endcase
    end
endmodule
