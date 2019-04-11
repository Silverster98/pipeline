`timescale 1ns / 1ps
`include "ctrl_def.v"

module ctrl_regW(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire reg_wen, cp0_wen,
    input wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdata,
    
    output reg reg_wenW, cp0_wenW,
    output reg[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataW
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            reg_wenW <= 0;
            cp0_wenW <= 0;
            sel_reg_wdataW <= `SEL_REG_WDATA_ALUOUT;
        end else begin
            reg_wenW <= reg_wen;
            cp0_wenW <= cp0_wen;
            sel_reg_wdataW <= sel_reg_wdata;
        end
    end
endmodule
