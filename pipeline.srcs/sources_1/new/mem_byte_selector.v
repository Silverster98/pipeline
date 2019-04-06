`timescale 1ns / 1ps
`include "ctrl_def.v"

module mem_module(
    input wire wen,
    input wire[1:0] addrlow2,
    input wire[`MEM_TYPE_WIDTH-1:0] mem_type,
    
    output wire mem_wsel 
    );
    
    
endmodule
