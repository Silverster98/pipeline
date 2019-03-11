`timescale 1ns / 1ps

module regM(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire en,
    input wire in_beqout, in_bgtzout,
    input wire[31:0] in_aluout,
    input wire[31:0] in_wdata_mem, 
    input wire[4:0]  in_wdst,
    input wire[31:0] in_pc_branch,
    input wire[5:0]  in_op,
    
    output reg out_beqout, out_bgtzout,
    output reg[31:0] out_aluout,
    output reg[31:0] out_wdata_mem,
    output reg[4:0]  out_wdst,
    output reg[31:0] out_pc_branch,
    output reg[5:0]  out_op
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_beqout <= 1'b0;
            out_bgtzout <= 1'b0;
            out_aluout <= 32'h00000000;
            out_wdata_mem <= 32'h00000000;
            out_wdst <= 5'b00000;
            out_pc_branch <= 32'h00000000;
            out_op <= 6'b000000;
        end else if (en) begin
            out_beqout <= in_beqout;
            out_bgtzout <= in_bgtzout;
            out_aluout <= in_aluout;
            out_wdata_mem <= in_wdata_mem;
            out_wdst <= in_wdst;
            out_pc_branch <= in_pc_branch;
            out_op <= in_op;
        end else begin
            out_beqout <= out_beqout;
            out_bgtzout <= out_bgtzout;
            out_aluout <= out_aluout;
            out_wdata_mem <= out_wdata_mem;
            out_wdst <= out_wdst;
            out_pc_branch <= out_pc_branch;
            out_op <= out_op;
        end
    end
endmodule
