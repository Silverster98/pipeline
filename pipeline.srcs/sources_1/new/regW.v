`timescale 1ns / 1ps

module regW(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire en,
    input wire[31:0] in_aluout,
    input wire[31:0] in_memout,
    input wire[4:0]  in_wdst,
    input wire[4:0]  in_rd,
    input wire[31:0] in_pc4,
    input wire[31:0] in_cp0_data_o,
    input wire[31:0] in_cp0_wdata,
    
    output reg[31:0] out_aluout,
    output reg[31:0] out_memout,
    output reg[4:0]  out_wdst,
    output reg[4:0]  out_rd,
    output reg[31:0] out_pc4,
    output reg[31:0] out_cp0_data_o,
    output reg[31:0] out_cp0_wdata
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_aluout <= 32'h00000000;
            out_memout <= 32'h00000000;
            out_wdst   <= 5'b00000;
            out_rd     <= 5'b00000;
            out_pc4    <= 32'h00000000;
            out_cp0_data_o <= 32'h00000000;
            out_cp0_wdata <= 32'h00000000;
        end else if (en) begin
            out_aluout <= in_aluout;
            out_memout <= in_memout;
            out_wdst   <= in_wdst;
            out_rd     <= in_rd;
            out_pc4    <= in_pc4;
            out_cp0_data_o <= in_cp0_data_o;
            out_cp0_wdata <= in_cp0_wdata;
        end else begin
            out_aluout <= out_aluout;
            out_memout <= out_memout;
            out_wdst   <= out_wdst;
            out_rd     <= out_rd;
            out_pc4    <= out_pc4;
            out_cp0_data_o <= out_cp0_data_o;
            out_cp0_wdata <= out_cp0_wdata;
        end
    end
endmodule
