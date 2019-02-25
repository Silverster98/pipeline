`timescale 1ns / 1ps

module myreg(
    input wire clk,
    input wire[31:0] in32,
    
    output reg[31:0] out32
    );
    
    always @ (posedge clk) begin
        out32 <= in32;
    end
endmodule
