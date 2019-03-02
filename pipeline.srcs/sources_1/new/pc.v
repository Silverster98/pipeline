`timescale 1ns / 1ps

module pc(
    input wire clk,
    input wire rst,
    input wire en,
    input wire[31:0] npc,
    
    output reg[31:0] pc
    );
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'h00000000;
        end else begin
            if (en) pc <= npc;
            else pc <= pc;
        end
    end
endmodule
