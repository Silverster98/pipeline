`timescale 1ns / 1ps

module mymips(
    input wire clk,
    input wire rst
    );
    
    wire[31:0] inst_in, pc_out;
    wire[31:0] ram_addr, ram_wdata, ram_in;
    wire ram_wen;
    
    mips mips_core(
        .clk(clk),
        .rst(rst),
        .inst_in(inst_in),
        .ram_in(ram_in),
        .pc_out(pc_out),
        .ram_addr(ram_addr),
        .ram_wdata(ram_wdata),
        .ram_wen(ram_wen)
    );
    
    rom mips_rom(
        .a(pc_out[11:2]),
        .spo(inst_in)
    );
    
    ram mips_ram(
        .a(ram_addr[9:2]),      // input wire [7 : 0] a
        .d(ram_wdata),      // input wire [31 : 0] d
        .clk(clk),  // input wire clk
        .we(ram_wen),    // input wire we
        .spo(ram_in)  // output wire [31 : 0] spo
    );
endmodule
