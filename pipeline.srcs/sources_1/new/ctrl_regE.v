`timescale 1ns / 1ps

module ctrl_regE(
    input wire rst,
    input wire clk, clear,
    input wire reg_wen, mem_wen, branch,
    input wire[2:0] aluctrl,
    input wire sel_reg_wdata, sel_srcB,
    input wire[1:0] sel_aluout, sel_regdst,
    
    output reg reg_wenE, mem_wenE, branchE,
    output reg[2:0] aluctrlE,
    output reg sel_reg_wdataE, sel_srcBE, 
    output reg[1:0] sel_aluoutE, sel_regdstE
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            reg_wenE <= 0;
            mem_wenE <= 0;
            branchE  <= 0;
            aluctrlE <= 0;
            sel_aluoutE <= 2'b00;
            sel_reg_wdataE <= 0;
            sel_srcBE <= 0;
            sel_regdstE <= 2'b00;
        end else begin
            reg_wenE <= reg_wen;
            mem_wenE <= mem_wen;
            branchE  <= branch;
            aluctrlE <= aluctrl;
            sel_aluoutE <= sel_aluout;
            sel_reg_wdataE <= sel_reg_wdata;
            sel_srcBE  <= sel_srcB;
            sel_regdstE <= sel_regdst;
        end
    end
    
endmodule
