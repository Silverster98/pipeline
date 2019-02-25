`timescale 1ns / 1ps

module pc(
    input wire clk,
    input wire rst,
    input wire[31:0] npc,
    
    output reg[31:0] pc
    );
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'h00000000;
        end else begin
            pc <= npc;
        end
    end
endmodule
