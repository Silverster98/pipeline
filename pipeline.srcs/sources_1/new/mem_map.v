`timescale 1ns / 1ps

module mem_map(
    input wire[11:0] addr_h12,
    input wire[3:0] wsel,
    
    output wire[3:0] ram_wsel,
    output wire[3:0] io_wsel
    );
    
    assign io_wsel = (addr_h12 == 12'hfff) ? wsel : 4'b0000;
    assign ram_wsel = (addr_h12 != 12'hfff) ? wsel : 4'b0000;
endmodule
