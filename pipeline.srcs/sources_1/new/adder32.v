`timescale 1ns / 1ps

module adder32(
    input wire[31:0] A,
    input wire[31:0] B,
    
    output wire[31:0] C
    );
    
    assign C = A + B;
endmodule
