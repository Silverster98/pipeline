`timescale 1ns / 1ps

module extend_imm16(
    input wire[15:0] imm16,
    
    output wire[31:0] out32 
    );
    
    assign out32 = {{16{imm16[15]}}, imm16};
endmodule
