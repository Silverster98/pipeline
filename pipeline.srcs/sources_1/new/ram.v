`timescale 1ns / 1ps

module ram(
    input wire clk,
    input wire[31:0] addr,
//    input wire wen,
    input wire[31:0] wdata,
    input wire[3:0] wsel,
    
    output wire[31:0] mem_data_o
    );
    
    wire[7:0] out0, out1, out2, out3;
    
    // first ram, bit0-bit7
    ram_8bit_width ram0 (
      .a(addr[11:2]),      // input wire [9 : 0] a
      .d(wdata[7:0]),      // input wire [7 : 0] d
      .clk(clk),  // input wire clk
      .we(wsel[0]),    // input wire we
      .spo(out0)  // output wire [7 : 0] spo
    );
    
    // first ram, bit8-bit15
    ram_8bit_width ram1 (
      .a(addr[11:2]),      // input wire [9 : 0] a
      .d(wdata[15:8]),      // input wire [7 : 0] d
      .clk(clk),  // input wire clk
      .we(wsel[1]),    // input wire we
      .spo(out1)  // output wire [7 : 0] spo
    );
    
    // first ram, bit8-bit15
    ram_8bit_width ram2 (
      .a(addr[11:2]),      // input wire [9 : 0] a
      .d(wdata[23:16]),      // input wire [7 : 0] d
      .clk(clk),  // input wire clk
      .we(wsel[2]),    // input wire we
      .spo(out2)  // output wire [7 : 0] spo
    );
    
    // first ram, bit8-bit15
    ram_8bit_width ram3 (
      .a(addr[11:2]),      // input wire [9 : 0] a
      .d(wdata[31:24]),      // input wire [7 : 0] d
      .clk(clk),  // input wire clk
      .we(wsel[3]),    // input wire we
      .spo(out3)  // output wire [7 : 0] spo
    );
    
    assign mem_data_o = {out3, out2, out1, out0};
endmodule
