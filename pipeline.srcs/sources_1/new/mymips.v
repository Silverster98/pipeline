`timescale 1ns / 1ps

module mymips(
    input wire clk,
    input wire rst,
    
    output wire[7:0] io_out
    );
    
    wire[31:0] inst_in, pc_out;
    wire[31:0] addr, wdata, data_in;
    wire[3:0] wsel;
    wire[5:0] interrupt;
    wire timer_int_o;
    
    wire[31:0] ram_wsel, io_wsel;
    
    wire[31:0] port0, port1, port2, port3;
    assign io_out = port0[7:0];
    
    assign interrupt = {5'b00000, timer_int_o};
    
    mips mips_core(
        .clk(clk),
        .rst(rst),
        .inst_in(inst_in),
        .ram_in(data_in),
        .int(interrupt),
        
        .pc_out(pc_out),
        .ram_addr(addr),
        .ram_wdata(wdata),
        .ram_wsel(wsel),
        .timer_int_o(timer_int_o)
    );
    
    rom mips_rom(
        .a(pc_out[11:2]),
        .spo(inst_in)
    );
    
    mem_map mmap(
        .addr_h12(addr[31:20]),
        .wsel(wsel),
        .ram_wsel(ram_wsel),
        .io_wsel(io_wsel)
    );
    
    ram mips_ram(
        .clk(clk),
        .addr(addr),
        .wdata(wdata),
        .wsel(ram_wsel),
        .mem_data_o(data_in)
    );
    
    io_port ioport(
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .wdata(wdata),
        .wsel(io_wsel),
        
        .port0(port0),
        .port1(port1),
        .port2(port2),
        .port3(port3)
    );
endmodule
