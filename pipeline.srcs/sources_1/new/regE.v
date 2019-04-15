`timescale 1ns / 1ps

module regE(
    input wire rst,
    input wire clk,
    input wire clear,
    input wire[31:0] in_A, in_B,
    input wire[4:0] in_rs, in_rt, in_rd, in_sa,
    input wire[31:0] in_extimm16, in_upperimm16, in_pc_plus4, in_zextimm16,
    input wire[31:0] in_exception_type,
    input wire in_is_in_delayslot,
    
    output reg[31:0] out_A, out_B,
    output reg[4:0] out_rs, out_rt, out_rd, out_sa,
    output reg[31:0] out_extimm16, out_upperimm16, out_pc_plus4, out_zextimm16,
    output reg[31:0] out_exception_type,
    output reg out_is_in_delayslot
    );
    
    wire set_zero;
    assign set_zero = rst || clear;
    
    always @ (posedge clk) begin
        if (set_zero) begin
            out_A <= 32'h00000000;
            out_B <= 32'h00000000;
            out_rs <= 5'b00000;
            out_rt <= 5'b00000;
            out_rd <= 5'b00000;
            out_sa <= 5'b00000;
            out_extimm16 <= 32'h00000000;
            out_upperimm16 <= 32'h00000000;
            out_zextimm16 <= 32'h00000000;
            out_pc_plus4 <= 32'h00000000;
            out_exception_type <= 32'h00000200;
            out_is_in_delayslot <= 1'b0;
        end else begin
            out_A <= in_A;
            out_B <= in_B;
            out_rs <= in_rs;
            out_rt <= in_rt;
            out_rd <= in_rd;
            out_sa <= in_sa;
            out_extimm16 <= in_extimm16;
            out_upperimm16 <= in_upperimm16;
            out_zextimm16 <= in_zextimm16;
            out_pc_plus4 <= in_pc_plus4;
            out_exception_type <= in_exception_type;
            out_is_in_delayslot <= in_is_in_delayslot;
        end
    end
endmodule
