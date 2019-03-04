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

module myreg_en_clear(
    input wire clk,
    input wire[31:0] in32,
    input wire en,
    input wire clear,
    
    output reg[31:0] out32
    );
    
    initial begin
        out32 <= 0;
    end
    
    always @ (posedge clk) begin
        if (clear) out32 <= 0;
        else if (en) out32 <= in32;
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

module myreg6(
    input wire clk,
    input wire[5:0] in6,
    
    output reg[5:0] out6
    );
    
    initial begin
        out6 <= 0;
    end
    
    always @ (posedge clk) begin
        out6 <= in6;
    end
endmodule
