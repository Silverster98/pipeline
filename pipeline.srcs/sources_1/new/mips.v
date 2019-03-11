`timescale 1ns / 1ps
`include "instruction.v"

module mips(
    input wire clk,
    input wire rst,
    input wire io_en,
    output wire[7:0] io_out
    );
    
    wire[31:0] npc, pc;
    wire[31:0] im_out, inst;
    wire[31:0] pc_plus4;
    wire stallF, stallD, flushD, flushE, flushM;
    wire flush, Jflush;
    wire[31:0] jpc;
    
    wire[5:0] op;
    wire[4:0] rs, rt, rd;
    wire[4:0] sa;
    wire[5:0] funct;
    wire[15:0] imm16;
    wire[25:0] imm26;
    wire[31:0] extimm16, extimm16E, upperimm16, upperimm16E;
    wire[31:0] extimm26;
    wire[31:0] pc_plus4D;
    wire reg_wen;
    wire[31:0] reg_wdata;
    wire[31:0] reg_rs1o, reg_rs2o;
    
    wire[31:0] A, B, C, srcA, srcB;
    wire[4:0] rsE, rtE, rdE, wdstE, saE, opE, opM;
    wire sel_srcB, sel_regdst;
    wire[2:0] alu_ctrl;
    wire beqout, bgtzout;
    wire[31:0] left32, pc_plus4E, pc_branch;
    wire sel_aluout;
    wire[31:0] aluout;
    
    wire beqoutM, bgtzoutM;
    wire[31:0] aluoutM, wdataM, pc_branchM;
    wire[4:0] wdstM;
    wire sel_branch;
    
    wire mem_wen;
    wire[31:0] memout, memoutW, aluoutW;
    wire[4:0] wdstW;
    wire sel_reg_wdata;
    
    wire branch;
                                    
    wire reg_wenE, mem_wenE, branchE; 
    wire[2:0] alu_ctrlE;
    wire sel_aluoutE, sel_reg_wdataE, sel_srcBE, sel_regdstE;
    wire reg_wenM, mem_wenM, branchM, sel_reg_wdataM;
    wire reg_wenW, sel_reg_wdataW;
    
    wire[1:0] sel_forward_rs, sel_forward_rt;
    wire[31:0] forward_B;
    
    /**************** mips control unit ****************/
    cu mips_cu(
        .rst(rst),
        .op(op),
        .funct(funct),
        .reg_wen(reg_wen),
        .mem_wen(mem_wen),
        .branch(branch),
        .aluctrl(alu_ctrl),
        .sel_aluout(sel_aluout),
        .sel_reg_wdata(sel_reg_wdata),
        .sel_srcB(sel_srcB),
        .sel_regdst(sel_regdst)
    );
    
    /**************** next is inst fetch part ****************/
    mux32_2 mux_jpc(
        .in1(pc_plus4),
        .in2(extimm26),
        .sel(Jflush),
        .out(jpc)
    );
    
    mux32_2 mux_npc(
        .in1(jpc),
        .in2(pc_branchM),
        .sel(sel_branch),
        .out(npc)
    );
    
    
    pc mips_pc(
        .clk(clk),
        .rst(rst),
        .en(!stallF),
        .npc(npc),
        .pc(pc)
    );
    
    rom mips_im(
        .a(pc[11:2]),      // input wire [9 : 0] a
        .spo(im_out)  // output wire [31 : 0] spo
    );
//    im mips_im(
//        .pc(pc[11:2]),
//        .inst(im_out)
//    );
    
    adder32 pc_plus4_adder(
        .A(pc),
        .B(32'h00000004),
        .C(pc_plus4)
    );
    
    assign flush = flushD | Jflush;
    
    myreg_en_clear ir(
        .rst(rst),
        .clk(clk),
        .en(!stallD),
        .clear(flush),
        .in32(im_out),
        .out32(inst)
    );
    
    myreg_en_clear pc4_regD(
        .rst(0),
        .clk(clk),
        .en(!stallD),
        .clear(flushD),
        .in32(pc_plus4),
        .out32(pc_plus4D)
    );
    
    /**************** next is inst decode part ****************/
    assign Jflush = (op == `INST_J) ? 1 : 0;
    assign op = inst[31:26];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign sa = inst[10:6];
    assign funct = inst[5:0];
    assign imm16 = inst[15:0];
    assign imm26 = inst[25:0];
    
    wire[31:0] t3;
    assign io_out = (io_en == 1) ? t3[7:0] : 8'h00;
    
    regfile mips_regfile(
        .clk(clk),
        .rs1(rs),
        .rs2(rt),
        .rd(wdstW),
        .wen(reg_wenW),
        .wdata(reg_wdata),
        .rs1o(reg_rs1o),
        .rs2o(reg_rs2o),
        .t3(t3)
    );
    
    myreg_en_clear A_reg(
        .clk(clk),
        .in32(reg_rs1o),
        .en(1),
        .clear(flushE),
        .out32(A)
    );
    
    myreg B_reg(
        .clk(clk),
        .in32(reg_rs2o),
        .out32(B)
    );
    
    myreg6 op_reg(
        .clk(clk),
        .in6(op),
        .out6(opE)
    );
    
    myreg5 rs_reg(
        .clk(clk),
        .in5(rs),
        .out5(rsE)
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
    
    extend_imm26 ext_imm26(
        .imm26(imm26),
        .out32(extimm26)
    );
    
    load_upper load_upper_imm16(
        .imm16(imm16),
        .out32(upperimm16)
    );
    
    myreg extimm16_reg(
        .clk(clk),
        .in32(extimm16),
        .out32(extimm16E)
    );
    
    myreg upperimm16_reg(
        .clk(clk),
        .in32(upperimm16),
        .out32(upperimm16E)
    );
    
    myreg pc4_regE(
        .clk(clk),
        .in32(pc_plus4D),
        .out32(pc_plus4E)
    );
    
    ctrl_regE mips_ctrl_regE(
        .rst(rst),
        .clk(clk),
        .clear(flushE),
        .reg_wen(reg_wen),
        .mem_wen(mem_wen),
        .branch(branch),
        .aluctrl(alu_ctrl),
        .sel_aluout(sel_aluout),
        .sel_reg_wdata(sel_reg_wdata),
        .sel_srcB(sel_srcB),
        .sel_regdst(sel_regdst),
        .reg_wenE(reg_wenE),
        .mem_wenE(mem_wenE),
        .branchE(branchE),
        .aluctrlE(alu_ctrlE),
        .sel_aluoutE(sel_aluoutE),
        .sel_reg_wdataE(sel_reg_wdataE),
        .sel_srcBE(sel_srcBE),
        .sel_regdstE(sel_regdstE)
    );
    
    /**************** next is execute part ****************/
//    assign srcA = A;
    mux32_4 mux_forward_srcA(
        .in1(A),
        .in2(reg_wdata),
        .in3(aluoutM),
        .sel(sel_forward_rs),
        .out(srcA)
    );
    
    mux32_4 mux_forward_srcB(
        .in1(B),
        .in2(reg_wdata),
        .in3(aluoutM),
        .sel(sel_forward_rt),
        .out(forward_B)
    );
    
    
    mux32_2 mux_srcB(
        .in1(forward_B),
        .in2(extimm16E),
        .sel(sel_srcBE),
        .out(srcB)
    );
    
    mux5_2 mux_regdst(
        .in1(rtE),
        .in2(rdE),
        .sel(sel_regdstE),
        .out(wdstE)
    );
    
    alu mips_alu(
        .A(srcA),
        .B(srcB),
        .alu_ctrl(alu_ctrlE),
        .sa(saE),
        .C(C),
        .beqout(beqout),
        .bgtzout(bgtzout)
    );
    
    assign left32 = {extimm16E[29:0], 2'b00};
    
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
    
    myreg1 bgtzout_regM(
        .clk(clk),
        .in(bgtzout),
        .out(bgtzoutM)
    );
    
    mux32_2 mux_aluout(
        .in1(C),
        .in2(upperimm16E),
        .sel(sel_aluoutE),
        .out(aluout)
    );
    
    myreg c_regM(
        .clk(clk),
        .in32(aluout),
        .out32(aluoutM)
    );
    
    myreg wdata_regM(
        .clk(clk),
        .in32(B),
        .out32(wdataM)
    );
    
    myreg5 wdst_regM(
        .clk(clk),
        .in5(wdstE),
        .out5(wdstM)
    );
    
    myreg pc_branch_regM(
        .clk(clk),
        .in32(pc_branch),
        .out32(pc_branchM)
    );
    
    myreg6 op_regE(
        .clk(clk),
        .in6(opE),
        .out6(opM)
    );
    
    ctrl_regM mips_ctrl_regM(
        .rst(rst),
        .clk(clk),
        .clear(flushM),
        .reg_wen(reg_wenE),
        .mem_wen(mem_wenE),
        .branch(branchE),
        .sel_reg_wdata(sel_reg_wdataE),
        .reg_wenM(reg_wenM),
        .mem_wenM(mem_wenM),
        .branchM(branchM),
        .sel_reg_wdataM(sel_reg_wdataM)
    );
    
    /**************** next is memary access part ****************/
    wire bgtz_op;
    wire beq_branch, bgtz_branch;
    assign beq_branch = branchM && beqoutM;
    assign bgtz_op = (opM == `INST_BGTZ) ? 1 : 0;
    assign bgtz_branch = bgtz_op && bgtzoutM;
    assign sel_branch = beq_branch || bgtz_branch;
    
    ram mips_dm(
      .a(aluoutM[9:2]),      // input wire [7 : 0] a
      .d(wdataM),      // input wire [31 : 0] d
      .clk(clk),  // input wire clk
      .we(mem_wenM),    // input wire we
      .spo(memout)  // output wire [31 : 0] spo
    );
    
//    dm mips_dm(
//        .clk(clk),
//        .addr(aluoutM),
//        .wen(mem_wenM),
//        .wdata(wdataM),
//        .out(memout)
//    );
    
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
    
    ctrl_regW mips_ctrl_regW(
        .rst(rst),
        .clk(clk),
        .reg_wen(reg_wenM),
        .sel_reg_wdata(sel_reg_wdataM),
        .reg_wenW(reg_wenW),
        .sel_reg_wdataW(sel_reg_wdataW)
    );
    
    /**************** next is write back part ****************/
    mux32_2 mux_reg_wdata(
        .in1(aluoutW),
        .in2(memoutW),
        .sel(sel_reg_wdataW),
        .out(reg_wdata)
    );
    
    /**************** next is conflict detect part ****************/
    conflict_detect mips_conflict_detect(
        .rsE(rsE),
        .rtE(rtE),
        .wdstM(wdstM),
        .wdstW(wdstW),
        .reg_wenM(reg_wenM),
        .reg_wenW(reg_wenW),
        .rs(rs),
        .rt(rt),
        .sel_reg_wdataE(sel_reg_wdataE),
        .sel_branch(sel_branch),
        .sel_forward_rs(sel_forward_rs),
        .sel_forward_rt(sel_forward_rt),
        .stallF(stallF),
        .stallD(stallD),
        .flushD(flushD),
        .flushE(flushE),
        .flushM(flushM)
    );
  
endmodule
