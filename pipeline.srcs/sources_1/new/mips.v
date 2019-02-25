`timescale 1ns / 1ps

module mips(
    input wire clk,
    input wire rst
    );
    
    wire[31:0] npc, pc;
    wire[31:0] im_out, inst;
    wire[31:0] pc_plus4;
    
    pc mips_pc(
        .clk(clk),
        .rst(rst),
        .npc(npc),
        .pc(pc)
    );
    
    im mips_im(
        .pc(pc[11:2]),
        .inst(im_out)
    );
    
    myreg ir(
        .clk(clk),
        .in32(im_out),
        .out32(inst)
    );
    
    adder32 pc_plus4_adder(
        .A(pc),
        .B(32'h00000004),
        .C(pc_plus4)
    );
    
    assign npc = pc_plus4;
    
endmodule
