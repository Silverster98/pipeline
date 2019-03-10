`timescale 1ns / 1ps

module ctrl_regW(
    input wire rst,
    input wire clk,
    input wire reg_wen, sel_reg_wdata,
    
    output reg reg_wenW, sel_reg_wdataW
    );
    
    always @ (*) begin
        if (rst) begin
            reg_wenW = 0;
            sel_reg_wdataW = 0;
        end
    end
    
    always @ (posedge clk) begin
        reg_wenW <= reg_wen;
        sel_reg_wdataW <= sel_reg_wdata;
    end
endmodule
