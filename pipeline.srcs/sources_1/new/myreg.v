`timescale 1ns / 1ps

module myreg1(
    input wire clk,
    input wire in,
    
    output reg out
    );
    
    always @ (posedge clk) begin
        out <= in;
    end
endmodule

module myreg(
    input wire clk,
    input wire[31:0] in32,
    
    output reg[31:0] out32
    );
    
    always @ (posedge clk) begin
        out32 <= in32;
    end
endmodule

module myreg_en(
    input wire clk,
    input wire[31:0] in32,
    input wire en,
    
    output reg[31:0] out32
    );
    
    always @ (posedge clk) begin
        if (en) out32 <= in32;
        else out32 <= out32;
    end
endmodule

module myreg5(
    input wire clk,
    input wire[4:0] in5,
    
    output reg[4:0] out5
    );
    
    always @ (posedge clk) begin
        out5 <= in5;
    end
endmodule
