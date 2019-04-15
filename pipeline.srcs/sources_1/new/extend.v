`timescale 1ns / 1ps

module extend_imm16(
    input wire[15:0] imm16,
    
    output wire[31:0] out32 
    );
    
    assign out32 = {{16{imm16[15]}}, imm16};
endmodule

module zero_extend_imm16(
    input wire[15:0] imm16,
    
    output wire[31:0] out32 
    );
    
    assign out32 = {{16'h0000}, imm16};
endmodule

module load_upper(
    input wire[15:0] imm16,
    
    output wire[31:0] out32
    );
    
    assign out32 = {imm16, 16'h0000};
endmodule

module extend_imm26(
    input wire[25:0] imm26,
    
    output wire[31:0] out32
    );
    
    assign out32 = {4'b0000, imm26, 2'b00};
endmodule
