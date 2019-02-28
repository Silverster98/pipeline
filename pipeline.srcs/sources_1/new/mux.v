`timescale 1ns / 1ps

module mux5_2(
    input wire[4:0] in1, in2,
    input wire sel,
    
    output wire[4:0] out 
    );
    
    assign out = (sel == 1'b0) ? in1 : in2;
endmodule

module mux32_2(
    input wire[31:0] in1, in2,
    input wire sel,
    
    output wire[31:0] out
    );
    
    assign out = (sel == 1'b0) ? in1 : in2;
endmodule
