`timescale 1ns / 1ps

module regW(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire en,
    input wire[31:0] in_aluout,
    input wire[31:0] in_memout,
    input wire[4:0]  in_wdst,
    output reg[31:0] out_aluout,
    output reg[31:0] out_memout,
    output reg[4:0]  out_wdst 
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_aluout <= 32'h00000000;
            out_memout <= 32'h00000000;
            out_wdst   <= 5'b00000;
        end else if (en) begin
            out_aluout <= in_aluout;
            out_memout <= in_memout;
            out_wdst   <= in_wdst;
        end else begin
            out_aluout <= out_aluout;
            out_memout <= out_memout;
            out_wdst   <= out_wdst;
        end
    end
endmodule
