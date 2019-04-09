`timescale 1ns / 1ps

module ctrl_regM(
    input wire rst,
    input wire clk, clear,
    input wire reg_wen, mem_wen, cp0_wen,
    input wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdata,
    input wire[`BRANCH_TYPE_WIDTH-1:0] branch_type,
    input wire[`MEM_TYPE_WIDTH-1:0] mem_type,
    
    output reg[`BRANCH_TYPE_WIDTH-1:0] branch_typeM,
    output reg[`MEM_TYPE_WIDTH-1:0] mem_typeM,
    output reg reg_wenM, mem_wenM, cp0_wenM,
    output reg[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataM
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            reg_wenM <= 0;
            mem_wenM <= 0;
            cp0_wenM <= 0;
            branch_typeM <= `BRANCH_NONE;
            mem_typeM <= `MEM_NONE;
            sel_reg_wdataM <= `SEL_REG_WDATA_ALUOUT;
        end else begin
            reg_wenM <= reg_wen;
            mem_wenM <= mem_wen;
            cp0_wenM <= cp0_wen;
            branch_typeM <= branch_type;
            mem_typeM <= mem_type;
            sel_reg_wdataM <= sel_reg_wdata;
        end
    end
endmodule
