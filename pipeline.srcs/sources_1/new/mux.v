`timescale 1ns / 1ps

module mux5_4(
    input wire[4:0] in1, in2, in3, in4,
    input wire[1:0] sel,
    
    output wire[4:0] out 
    );
    
    assign out = (sel == 2'b00) ? in1 :
                 (sel == 2'b01) ? in2 :
                 (sel == 3'b10) ? in3 :
                 in4;
endmodule

module mux32_2(
    input wire[31:0] in1, in2,
    input wire sel,
    
    output wire[31:0] out
    );
    
    assign out = (sel == 1'b0) ? in1 : in2;
endmodule

module mux32_4(
    input wire[31:0] in1, in2, in3, in4,
    input wire[1:0] sel,
    
    output wire[31:0] out
    );
    
    assign out = (sel == 2'b00) ? in1 :
                 (sel == 2'b01) ? in2 :
                 (sel == 2'b10) ? in3 :
                 in4;
endmodule

module mux32_8(
    input wire[31:0] in1, in2, in3, in4, in5, in6, in7, in8,
    input wire[2:0] sel,
    
    output wire[31:0] out
    );
    
    assign out = (sel == 3'b000) ? in1 :
                 (sel == 3'b001) ? in2 :
                 (sel == 3'b010) ? in3 :
                 (sel == 3'b011) ? in4 :
                 (sel == 3'b100) ? in5 :
                 (sel == 3'b101) ? in6 :
                 (sel == 3'b110) ? in7 :
                 in8;
endmodule
