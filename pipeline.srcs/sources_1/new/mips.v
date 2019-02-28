`timescale 1ns / 1ps

module mips(
    input wire clk,
    input wire rst
    );
    
    wire[31:0] npc, pc;
    wire[31:0] im_out, inst;
    wire[31:0] pc_plus4;
    
    wire[5:0] op;
    wire[4:0] rs, rt, rd;
    wire[4:0] sa;
    wire[5:0] funct;
    wire[15:0] imm16;
    wire[25:0] imm26;
    wire[31:0] extimm16, extimm16E;
    wire[31:0] pc_plus4D;
    wire reg_wen;
    wire[31:0] reg_wdata;
    wire[31:0] reg_rs1o, reg_rs2o;
    
    wire[31:0] A, B, C, srcA, srcB;
    wire[4:0] rtE, rdE, write_regE, saE;
    wire sel_srcB, sel_regdst;
    wire[2:0] alu_ctrl;
    wire beqout;
    wire[31:0] left32, pc_plus4E, pc_branch;
    
    wire beqoutM;
    wire[31:0] aluoutM, wdataM, pc_branchM;
    wire[4:0] wdstM;
    
    wire mem_wen;
    wire[31:0] memout, memoutW, aluoutW;
    wire[4:0] wdstW;
    wire sel_reg_wdata;
    
    
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
    
    myreg pc4_regD(
        .clk(clk),
        .in32(pc_plus4),
        .out32(pc_plus4D)
    );
    
    // decode
    assign npc = pc_plus4;
    
    assign op = inst[31:26];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign sa = inst[10:6];
    assign funct = inst[5:0];
    assign imm16 = inst[15:0];
    assign imm26 = inst[25:0];
    
    regfile mips_regfile(
        .clk(clk),
        .rs1(rs),
        .rs2(rt),
        .rd(wdstW),
        .wen(reg_wen),
        .wdata(reg_wdata),
        .rs1o(reg_rs1o),
        .rs2o(reg_rs2o)
    );
    
    myreg A_reg(
        .clk(clk),
        .in32(reg_rs1o),
        .out32(A)
    );
    
    myreg B_reg(
        .clk(clk),
        .in32(reg_rs2o),
        .out32(B)
    );
    
    myreg5 rt_reg(
        .clk(clk),
        .in5(rt),
        .out5(rtE)
    );
    
    myreg5 rd_reg(
        .clk(clk),
        .in5(rd),
        .out5(rdE)
    );
    
    myreg5 sa_reg(
        .clk(clk),
        .in5(sa),
        .out5(saE)
    );
    
    extend_imm16 ext_imm16(
        .imm16(imm16),
        .out32(extimm16)
    );
    
    myreg extimm16_reg(
        .clk(clk),
        .in32(extimm16),
        .out32(extimm16E)
    );
    
    myreg pc4_regE(
        .clk(clk),
        .in32(pc_plus4D),
        .out32(pc_plus4E)
    );
    
    // execute
    assign srcA = A;
    
    mux32_2 mux_srcB(
        .in1(B),
        .in2(extimm16),
        .sel(sel_srcB),
        .out(srcB)
    );
    
    mux5_2 mux_regdst(
        .in1(rtE),
        .in2(rdE),
        .sel(sel_regdst),
        .out(write_regE)
    );
    
    alu mips_alu(
        .A(srcA),
        .B(srcB),
        .alu_ctrl(alu_ctrl),
        .sa(saE),
        .C(C),
        .beqout(beqout)
    );
    
    assign left32 = {extimm16[29:0], 2'b00};
    
    adder32 pc4_plus_imm(
        .A(left32),
        .B(pc_plus4E),
        .C(pc_branch)
    );
    
    myreg1 beqout_regM(
        .clk(clk),
        .in(beqout),
        .out(beqoutM)
    );
    
    myreg c_regM(
        .clk(clk),
        .in32(C),
        .out32(aluoutM)
    );
    
    myreg wdata_regM(
        .clk(clk),
        .in32(B),
        .out32(wdataM)
    );
    
    myreg5 wdst_regM(
        .clk(clk),
        .in5(write_regE),
        .out5(wdstM)
    );
    
    myreg pc_branch_regM(
        .clk(clk),
        .in32(pc_branch),
        .out32(pc_branchM)
    );
    
    // access memory
    dm mips_dm(
        .clk(clk),
        .addr(aluoutM),
        .wen(mem_wen),
        .wdata(wdataM),
        .out(memout)
    );
    
    myreg aluout_regW(
        .clk(clk),
        .in32(aluoutM),
        .out32(aluoutW)
    );
    
    myreg memoutM(
        .clk(clk),
        .in32(memout),
        .out32(memoutW)
    );
    
    myreg5 wdst_regW(
        .clk(clk),
        .in5(wdstM),
        .out5(wdstW)
    );
    
    // write back
    mux32_2 mux_reg_wdata(
        .in1(aluoutW),
        .in2(memoutW),
        .sel(sel_reg_wdata),
        .out(reg_wdata)
    );
  
endmodule
