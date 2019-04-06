`timescale 1ns / 1ps

module mymips(
    input wire clk,
    input wire rst
    );
    
    wire[31:0] inst_in, pc_out;
    wire[31:0] addr, wdata, data_in;
    wire[3:0] wsel;
    
    mips mips_core(
        .clk(clk),
        .rst(rst),
        .inst_in(inst_in),
        .ram_in(data_in),
        .pc_out(pc_out),
        .ram_addr(addr),
        .ram_wdata(wdata),
        .ram_wsel(wsel)
    );
    
    rom mips_rom(
        .a(pc_out[11:2]),
        .spo(inst_in)
    );
    
//    mem_map mmap(
//        .addr_h4(addr[31:28]),
//        .wen(wen),
//        .ram_wen(ram_wen),
//        .io_wen(io_wen)
//    );
    
//    ram mips_ram(
//        .a(addr[9:2]),      // input wire [7 : 0] a
//        .d(wdata),      // input wire [31 : 0] d
//        .clk(clk),  // input wire clk
//        .we(ram_wen),    // input wire we
//        .spo(data_in)  // output wire [31 : 0] spo
//    );
    ram mips_ram(
        .clk(clk),
        .addr(addr),
        .wdata(wdata),
        .wsel(wsel),
        .mem_data_o(data_in)
    );
    
//    io_port ioport(
//        .clk(clk),
//        .rst(rst),
//        .addr(addr[3:2]),
//        .wdata(wdata),
//        .wen(io_wen)
//    );
endmodule
