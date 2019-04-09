`timescale 1ns / 1ps
`include "instruction.v"
`include "ctrl_def.v"

module mips(
    input wire clk,
    input wire rst,
    input wire[31:0] inst_in,
    input wire[31:0] ram_in,
    
    output wire[31:0] pc_out,
    output wire[31:0] ram_addr,
    output wire[31:0] ram_wdata,
    output wire[3:0]  ram_wsel
    );
    
    wire[31:0] npc, pc;
    wire[31:0] im_out, inst;
    wire[31:0] pc_plus4;
    wire stallF, stallD, flushD, flushE, flushM;
    wire flush;
    wire[31:0] jpc, jaddr;
    
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
    wire[4:0] rsE, rtE, rdE, wdstE, saE;
    wire[`SEL_SRCB_WIDTH-1:0] sel_srcB;
    wire[`ALU_CTRL-1:0] alu_ctrl;
    wire[1:0] ans_status;
    wire[31:0] left32, pc_plus4E, pc_branch;
    wire[1:0] sel_aluout, sel_regdst;
    wire[31:0] aluout;
    
    wire[1:0] ans_statusM;
    wire[31:0] aluoutM, wdataM, pc_branchM, pc_plus4M;
    wire[4:0] wdstM, rdM;
    wire sel_branch;
    
    wire mem_wen;
    wire[31:0] memout, memoutW, aluoutW, pc_plus4W;
    wire[4:0] wdstW, rdW;
    wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdata;

    wire[`BRANCH_TYPE_WIDTH-1:0] branch_type, branch_typeE, branch_typeM;
                                    
    wire reg_wenE, mem_wenE; 
    wire[`ALU_CTRL-1:0] alu_ctrlE;
    wire[1:0] sel_aluoutE, sel_regdstE;
    wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataE;
    wire[`SEL_SRCB_WIDTH-1:0] sel_srcBE;
    wire reg_wenM, mem_wenM;
    wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataM;
    wire reg_wenW;
    wire[`SEL_REG_WDATA_WIDTH-1:0] sel_reg_wdataW;
    
    wire[1:0] sel_forward_rs, sel_forward_rt;
    wire[31:0] forward_B;
    
    wire[31:0] bool;
    wire sel_bool;
    
    wire[`MEM_TYPE_WIDTH-1:0] mem_type, mem_typeE, mem_typeM;
    wire[31:0] cp0_data_o, cp0_data_oM, cp0_data_oW;
    wire[31:0] cp0_wdata;
    wire timer_int_o;
    wire cp0_wen, cp0_wenE, cp0_wenM, cp0_wenW;
    
    wire[1:0] sel_jaddr;
    
    
    /**************** mips control unit ****************/
    cu mips_cu(
        .rst(rst),
        .op(op),
        .rs(rs),
        .rt(rt),
        .funct(funct),
        .reg_wen(reg_wen),
        .mem_wen(mem_wen),
        .cp0_wen(cp0_wen),
        .branch_type(branch_type),
        .aluctrl(alu_ctrl),
        .sel_aluout(sel_aluout),
        .sel_reg_wdata(sel_reg_wdata),
        .sel_srcB(sel_srcB),
        .mem_type(mem_type),
        .sel_regdst(sel_regdst)
    );
    
    /**************** next is inst fetch part ****************/
    mux32_4 mux_jpc(
        .in1(pc_plus4),
        .in2(reg_rs1o),
        .in3(extimm26),
        .sel(sel_jaddr),
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
    assign pc_out = pc;
    
    adder32 pc_plus4_adder(
        .A(pc),
        .B(32'h00000004),
        .C(pc_plus4)
    );
    
    assign flush = flushD;
    assign im_out = inst_in;
    
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
        .clear(flush),
        .in32(pc_plus4),
        .out32(pc_plus4D)
    );
    
    /**************** next is inst decode part ****************/
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
        .wen(reg_wenW),
        .wdata(reg_wdata),
        .rs1o(reg_rs1o),
        .rs2o(reg_rs2o)
    );
    
    extend_imm16 ext_imm16(
        .imm16(imm16),
        .out32(extimm16)
    );
    
    extend_imm26 ext_imm26(
        .imm26(imm26),
        .out32(extimm26)
    );
    
    assign sel_jaddr = (op == `INST_J || op == `INST_JAL) ? 2'b10 :
                       (op == `INST_TYPE_R && (funct == `INST_JR || funct == `INST_JALR)) ? 2'b01 :
                       2'b00;
    
    load_upper load_upper_imm16(
        .imm16(imm16),
        .out32(upperimm16)
    );
    
    regE mips_regE(
        .rst(rst),
        .clk(clk),
        .clear(flushE),
        .en(1),
        .in_A(reg_rs1o),
        .in_B(reg_rs2o),
        .in_rs(rs),
        .in_rt(rt),
        .in_rd(rd),
        .in_sa(sa),
        .in_extimm16(extimm16),
        .in_upperimm16(upperimm16),
        .in_pc_plus4(pc_plus4D),
        .out_A(A),
        .out_B(B),
        .out_rs(rsE),
        .out_rt(rtE),
        .out_rd(rdE),
        .out_sa(saE),
        .out_extimm16(extimm16E),
        .out_upperimm16(upperimm16E),
        .out_pc_plus4(pc_plus4E)
    );
    
    ctrl_regE mips_ctrl_regE(
        .rst(rst),
        .clk(clk),
        .clear(flushE),
        .reg_wen(reg_wen),
        .mem_wen(mem_wen),
        .cp0_wen(cp0_wen),
        .branch_type(branch_type),
        .aluctrl(alu_ctrl),
        .sel_aluout(sel_aluout),
        .sel_reg_wdata(sel_reg_wdata),
        .sel_srcB(sel_srcB),
        .mem_type(mem_type),
        .sel_regdst(sel_regdst),
        .reg_wenE(reg_wenE),
        .mem_wenE(mem_wenE),
        .cp0_wenE(cp0_wenE),
        .branch_typeE(branch_typeE),
        .aluctrlE(alu_ctrlE),
        .sel_aluoutE(sel_aluoutE),
        .sel_reg_wdataE(sel_reg_wdataE),
        .sel_srcBE(sel_srcBE),
        .mem_typeE(mem_typeE),
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
    
    
    mux32_4 mux_srcB(
        .in1(forward_B),
        .in2(extimm16E),
        .in3(32'h00000000),
        .sel(sel_srcBE),
        .out(srcB)
    );
    
    mux5_4 mux_regdst(
        .in1(rtE),
        .in2(rdE),
        .in3(5'b11111),
        .sel(sel_regdstE),
        .out(wdstE)
    );
    
    alu mips_alu(
        .A(srcA),
        .B(srcB),
        .alu_ctrl(alu_ctrlE),
        .sa(saE),
        .C(C),
        .ans_status(ans_status)
    );
    
    assign sel_bool = (ans_status == `ANS_LZ) ? 1 : 0;
    mux32_2 mux_bool(
        .in1(32'h00000000),
        .in2(32'h00000001),
        .sel(sel_bool),
        .out(bool)
    );
    
    assign left32 = {extimm16E[29:0], 2'b00};
    
    adder32 pc4_plus_imm(
        .A(left32),
        .B(pc_plus4E),
        .C(pc_branch)
    );
    
    mux32_4 mux_aluout(
        .in1(C),
        .in2(upperimm16E),
        .in3(bool),
        .in4(pc_plus4E),
        .sel(sel_aluoutE),
        .out(aluout)
    );
    
    cp0_reg mips_cp0(
        .clk(clk),
        .rst(rst),
        .we(cp0_wenW),
        .waddr(rdW),
        .raddr(rdE),
        .wdata(cp0_wdata),
        .int_i(intr),      // intruction 
        .data_o(cp0_data_o),
        .timer_int_o(timer_int_o)
    );
    
    regM mips_regM(
        .rst(rst),
        .clk(clk),
        .clear(0),
        .en(1),
        .in_ans_status(ans_status),
        .in_aluout(aluout),
        .in_wdata_mem(forward_B),
        .in_wdst(wdstE),
        .in_pc_branch(pc_branch),
        .in_rd(rdE),
        .in_pc4(pc_plus4E),
        .in_cp0_data_o(cp0_data_o),
        .out_ans_status(ans_statusM),
        .out_aluout(aluoutM),
        .out_wdata_mem(wdataM),
        .out_wdst(wdstM),
        .out_pc_branch(pc_branchM),
        .out_rd(rdM),
        .out_pc4(pc_plus4M),
        .out_cp0_data_o(cp0_data_oM)
    );
    
    ctrl_regM mips_ctrl_regM(
        .rst(rst),
        .clk(clk),
        .clear(flushM),
        .reg_wen(reg_wenE),
        .mem_wen(mem_wenE),
        .cp0_wen(cp0_wenE),
        .branch_type(branch_typeE),
        .mem_type(mem_typeE),
        .sel_reg_wdata(sel_reg_wdataE),
        .reg_wenM(reg_wenM),
        .mem_wenM(mem_wenM),
        .cp0_wenM(cp0_wenM),
        .branch_typeM(branch_typeM),
        .mem_typeM(mem_typeM),
        .sel_reg_wdataM(sel_reg_wdataM)
    );
    
    /**************** next is memary access part ****************/
    wire beq_branch, bgtz_branch, bne_branch, blez_branch, bgez_branch, bltz_branch;
    assign beq_branch = (branch_typeM == `BRANCH_BEQ) && (ans_statusM == `ANS_EZ);
    assign bne_branch = (branch_typeM == `BRANCH_BNE) && (ans_status == `ANS_GZ || ans_status == `ANS_LZ);
    assign bgtz_branch = (branch_typeM == `BRANCH_BGTZ) && (ans_statusM == `ANS_GZ);
    assign blez_branch = (branch_typeM == `BRANCH_BLEZ) && (ans_status == `ANS_EZ || ans_status == `ANS_LZ);
    assign bgez_branch = (branch_typeM == `BRANCH_BGEZ) && (ans_status == `ANS_EZ || ans_status == `ANS_GZ);
    assign bltz_branch = (branch_typeM == `BRANCH_BLTZ) && (ans_status == `ANS_LZ);

    assign sel_branch = beq_branch || bgtz_branch || bne_branch || blez_branch || bgez_branch || bltz_branch;
    
    assign ram_addr = aluoutM;
//    assign ram_wdata = wdataM;
//    assign ram_wen = mem_wenM;
//    assign memout = ram_in;
    
    mem_module mips_mem_module(
        .wen(mem_wenM),
        .addrlow2(ram_addr[1:0]),
        .mem_data_i(ram_in),
        .mem_wdata_i(wdataM),
        .mem_type(mem_typeM),
        .mem_wsel(ram_wsel),
        .mem_data_o(memout),
        .mem_wdata_o(ram_wdata)
    );
    

    regW mips_regW(
        .rst(rst),
        .clk(clk),
        .clear(0),
        .en(1),
        .in_aluout(aluoutM),
        .in_memout(memout),
        .in_wdst(wdstM),
        .in_rd(rdM),
        .in_pc4(pc_plus4M),
        .in_cp0_data_o(cp0_data_oM),
        .in_cp0_wdata(wdataM),
        .out_aluout(aluoutW),
        .out_memout(memoutW),
        .out_wdst(wdstW),
        .out_rd(rdW),
        .out_pc4(pc_plus4W),
        .out_cp0_data_o(cp0_data_oW),
        .out_cp0_wdata(cp0_wdata)
    );
    
    ctrl_regW mips_ctrl_regW(
        .rst(rst),
        .clk(clk),
        .reg_wen(reg_wenM),
        .cp0_wen(cp0_wenM),
        .sel_reg_wdata(sel_reg_wdataM),
        .reg_wenW(reg_wenW),
        .cp0_wenW(cp0_wenW),
        .sel_reg_wdataW(sel_reg_wdataW)
    );
    
    /**************** next is write back part ****************/
    mux32_8 mux_reg_wdata(
        .in1(aluoutW),
        .in2(memoutW),
        .in3(pc_plus4W),
        .in4(cp0_data_oW),
        .in5(), // HI
        .in6(), // LO
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
