`timescale 1ns / 1ps

module io_port(
    input wire clk,
    input wire rst,
    input wire[3:2] addr,
    input wire[31:0] wdata,
    input wire wen
    );
    
    reg[31:0] port[2:0]; // just 16 Byte
    
    always @ (posedge clk) begin
        if (rst) begin
            port[0] <= 32'h00000000;
            port[1] <= 32'h00000000;
            port[2] <= 32'h00000000;
            port[3] <= 32'h00000000;
        end else begin
            if (wen) port[addr] <= wdata;
        end
    end
endmodule
