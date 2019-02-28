`timescale 1ns / 1ps

module dm(
    input wire clk,
    input wire[31:0] addr,
    input wire wen,
    input wire[31:0] wdata,
    
    output wire[31:0] out 
    );
    
    reg[31:0] dm[1023:0];
    
    assign out = dm[addr[11:2]];
    
    always @ (posedge clk) begin
        if (wen) begin
            dm[addr[11:2]] <= wdata;
        end
    end
endmodule
