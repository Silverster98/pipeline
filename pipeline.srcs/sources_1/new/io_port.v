`timescale 1ns / 1ps

module io_port(
    input wire clk,
    input wire rst,
    input wire[31:0] addr,
    input wire[31:0] wdata,
    input wire[3:0] wsel,
    
    output wire[31:0] port0,
    output wire[31:0] port1,
    output wire[31:0] port2,
    output wire[31:0] port3
    );
    
    reg[31:0] port[2:0]; // just 16 Byte
    assign port0 = port[0];
    assign port1 = port[1];
    assign port2 = port[2];
    assign port3 = port[3];
    
    always @ (posedge clk) begin
        if (rst) begin
            port[0] <= 32'h00000000;
            port[1] <= 32'h00000000;
            port[2] <= 32'h00000000;
            port[3] <= 32'h00000000;
        end else begin
            if (wsel[0] == 1'b1) port[addr[3:2]][7:0] <= wdata[7:0];
            if (wsel[1] == 1'b1) port[addr[3:2]][15:8] <= wdata[15:8];
            if (wsel[2] == 1'b1) port[addr[3:2]][23:16] <= wdata[23:16];
            if (wsel[3] == 1'b1) port[addr[3:2]][31:24] <= wdata[31:24];
        end
    end
endmodule
