`timescale 1ns / 1ps

module myreg_en_clear(
    input wire rst,
    input wire clk,
    input wire[31:0] in32,
    input wire en,
    input wire clear,
    
    output reg[31:0] out32
    );
    wire set_zero = clear || rst;
    
    always @ (posedge clk) begin
        if (set_zero) out32 <= 32'h00000000;
        else if (en) out32 <= in32;
        else out32 <= out32;
    end
endmodule

module myreg1(
    input wire clk,
    input wire in1,
    
    output reg out1
    );
    
    always @ (posedge clk) begin
        out1 <= in1;
    end
endmodule
