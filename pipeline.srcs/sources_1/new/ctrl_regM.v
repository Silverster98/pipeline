`timescale 1ns / 1ps

module ctrl_regM(
    input wire rst,
    input wire clk, clear,
    input wire reg_wen, mem_wen, sel_reg_wdata,
    input wire[`BRANCH_TYPE_WIDTH:0] branch_type,
    
    output reg[`BRANCH_TYPE_WIDTH:0] branch_typeM,
    output reg reg_wenM, mem_wenM, branchM, sel_reg_wdataM
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            reg_wenM <= 0;
            mem_wenM <= 0;
            branch_typeM <= `BRANCH_NONE;
            sel_reg_wdataM <= 0;
        end else begin
            reg_wenM <= reg_wen;
            mem_wenM <= mem_wen;
            branch_typeM <= branch_type;
            sel_reg_wdataM <= sel_reg_wdata;
        end
    end
endmodule
