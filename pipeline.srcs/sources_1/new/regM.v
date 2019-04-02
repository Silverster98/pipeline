`timescale 1ns / 1ps
`include "ctrl_def.v"

module regM(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire en,
    input wire[1:0]  in_ans_status,
    input wire[31:0] in_aluout,
    input wire[31:0] in_wdata_mem, 
    input wire[4:0]  in_wdst,
    input wire[31:0] in_pc_branch,
    
    output reg[1:0]  out_ans_status,
    output reg[31:0] out_aluout,
    output reg[31:0] out_wdata_mem,
    output reg[4:0]  out_wdst,
    output reg[31:0] out_pc_branch
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_ans_status <= `ANS_EZ;
            out_aluout <= 32'h00000000;
            out_wdata_mem <= 32'h00000000;
            out_wdst <= 5'b00000;
            out_pc_branch <= 32'h00000000;
        end else if (en) begin
            out_ans_status <= in_ans_status;
            out_aluout <= in_aluout;
            out_wdata_mem <= in_wdata_mem;
            out_wdst <= in_wdst;
            out_pc_branch <= in_pc_branch;
        end else begin
            out_ans_status <= out_ans_status;
            out_aluout <= out_aluout;
            out_wdata_mem <= out_wdata_mem;
            out_wdst <= out_wdst;
            out_pc_branch <= out_pc_branch;
        end
    end
endmodule
