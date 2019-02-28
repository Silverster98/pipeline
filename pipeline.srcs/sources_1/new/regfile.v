`timescale 1ns / 1ps

module regfile(
    input wire clk,
    input wire[4:0] rs1,
    input wire[4:0] rs2,
    input wire[4:0] rd,
    input wire wen,
    input wire[31:0] wdata,
    
    output wire[31:0] rs1o,
    output wire[31:0] rs2o
    );
    
    reg[31:0] gpr[31:0];
    
    assign rs1o = (rs1 == 5'b00000) ? 32'h00000000 : gpr[rs1];
    assign rs2o = (rs2 == 5'b00000) ? 32'h00000000 : gpr[rs2];
    
    always @ (posedge clk) begin
        if (wen) gpr[rd] <= wdata;
    end
endmodule
