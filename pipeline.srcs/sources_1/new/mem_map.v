`timescale 1ns / 1ps

module mem_map(
    input wire[3:0] addr_h4,
    input wire wen,
    
    output wire ram_wen,
    output wire io_wen
    );
    
    assign io_wen = (addr_h4 == 4'b1111) ? wen : 0;
    assign ram_wen = (addr_h4 != 4'b1111) ? wen : 0;
endmodule
