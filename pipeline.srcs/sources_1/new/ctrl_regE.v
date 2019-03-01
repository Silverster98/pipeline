`timescale 1ns / 1ps

module ctrl_regE(
    input wire clk,
    input wire reg_wen, mem_wen, branch,
    input wire[2:0] aluctrl,
    input wire sel_reg_wdata, sel_srcB, sel_regdst,
    
    output reg reg_wenE, mem_wenE, branchE,
    output reg[2:0] aluctrlE,
    output reg sel_reg_wdataE, sel_srcBE, sel_regdstE
    );
    
    always @ (posedge clk) begin
        reg_wenE <= reg_wen;
        mem_wenE <= mem_wen;
        branchE  <= branch;
        aluctrlE <= aluctrl;
        sel_reg_wdataE <= sel_reg_wdata;
        sel_srcBE  <= sel_srcB;
        sel_regdstE    <= sel_regdst;
    end
    
endmodule