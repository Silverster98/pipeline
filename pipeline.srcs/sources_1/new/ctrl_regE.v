`timescale 1ns / 1ps
`include "ctrl_def.v"

module ctrl_regE(
    input wire rst,
    input wire clk, clear,
    input wire reg_wen, mem_wen, cp0_wen,
    input wire[`ALU_CTRL-1:0] aluctrl,
    input wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdata, 
    input wire[`SEL_SRCB_WIDTH-1:0] sel_srcB,
    input wire[`MEM_TYPE_WIDTH-1:0] mem_type,
    input wire[`SEL_ALUOUT_WIDTH-1:0] sel_aluout,
    input wire[`SEL_REGDST_WIDTH-1:0] sel_regdst,
    input wire overflow_test,
    
    output reg reg_wenE, mem_wenE, cp0_wenE,
    output reg[`ALU_CTRL-1:0] aluctrlE,
    output reg[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataE, 
    output reg[`SEL_SRCB_WIDTH-1:0] sel_srcBE,
    output reg[`MEM_TYPE_WIDTH-1:0] mem_typeE, 
    output reg[`SEL_ALUOUT_WIDTH-1:0] sel_aluoutE,
    output reg[`SEL_REGDST_WIDTH-1:0] sel_regdstE,
    output reg overflow_testE
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            reg_wenE <= 0;
            mem_wenE <= 0;
            cp0_wenE <= 0;
            aluctrlE <= `ALU_ADD;
            sel_aluoutE <= `SEL_ALUOUT_C;
            sel_reg_wdataE <= `SEL_REG_WDATA_ALUOUT;
            sel_srcBE <= `SEL_SRCB_FORD;
            mem_typeE <= `MEM_NONE;
            sel_regdstE <= `SEL_REGDST_RT;
            overflow_testE <= 0;
        end else begin
            reg_wenE <= reg_wen;
            mem_wenE <= mem_wen;
            cp0_wenE <= cp0_wen;
            aluctrlE <= aluctrl;
            sel_aluoutE <= sel_aluout;
            sel_reg_wdataE <= sel_reg_wdata;
            sel_srcBE  <= sel_srcB;
            mem_typeE  <= mem_type;
            sel_regdstE <= sel_regdst;
            overflow_testE <= overflow_test;
        end
    end
    
endmodule
