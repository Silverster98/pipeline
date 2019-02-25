`timescale 1ns / 1ps

module im(
    input wire[9:0] pc,
    
    output reg[31:0] inst
    );
    
    reg[31:0] im[1023:0];
    
    always @ (pc) begin
        inst <= im[pc];
    end
endmodule
