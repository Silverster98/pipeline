`timescale 1ns / 1ps
`include "ctrl_def.v"

module regM(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire[31:0] in_aluout,
    input wire[31:0] in_wdata_mem, 
    input wire[4:0]  in_wdst,
    input wire[4:0]  in_rd,
    
    output reg[31:0] out_aluout,
    output reg[31:0] out_wdata_mem,
    output reg[4:0]  out_wdst,
    output reg[4:0]  out_rd
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_aluout <= 32'h00000000;
            out_wdata_mem <= 32'h00000000;
            out_wdst <= 5'b00000;
            out_rd <= 5'b00000;
        end else begin
            out_aluout <= in_aluout;
            out_wdata_mem <= in_wdata_mem;
            out_wdst <= in_wdst;
            out_rd <= in_rd;
        end
    end
endmodule
