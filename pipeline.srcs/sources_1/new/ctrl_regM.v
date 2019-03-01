`timescale 1ns / 1ps

module ctrl_regM(
    input wire clk,
    input wire reg_wen, mem_wen, branch,sel_reg_wdata,
    
    output reg reg_wenM, mem_wenM, branchM, sel_reg_wdataM
    );
    
    initial begin
        reg_wenM = 0;
        mem_wenM = 0;
        branchM  = 0;
        sel_reg_wdataM = 0;
    end
    
    always @ (posedge clk) begin
        reg_wenM <= reg_wen;
        mem_wenM <= mem_wen;
        branchM  <= branch;
        sel_reg_wdataM <= sel_reg_wdata;
    end
endmodule
