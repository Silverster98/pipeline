`timescale 1ns / 1ps
`include "ctrl_def.v"

module conflict_detect(
    input wire[`BRANCH_TYPE_WIDTH-1:0] branch_type,
    input wire[4:0] rsE, rtE, wdstM, wdstW, wdstE, 
    input wire reg_wenM, reg_wenW, reg_wenE, cp0_wenM,
    input wire[4:0] rs, rt,
    input wire sel_reg_wdataE, sel_reg_wdataM,
    
    output wire[1:0] sel_forward_rs, sel_forward_rt,
    output wire stallD, stallF, flushE,
    output wire[1:0] sel_branch_forward_rs, sel_branch_forward_rt,
    output wire sel_forward_cp0_data_o,
    output wire[1:0] sel_jump_forward_rs
    );
    
    // forward
    assign sel_forward_rs = (rsE != 0 && rsE == wdstM && reg_wenM) ? 2'b10 : 
                            (rsE != 0 && rsE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;
    assign sel_forward_rt = (rtE != 0 && rtE == wdstM && reg_wenM) ? 2'b10 : 
                            (rtE != 0 && rtE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;

    // stall and flush
    wire load_stall;
    assign load_stall = ((rs == rtE || rt == rtE) && sel_reg_wdataE == `SEL_REG_WDATA_MEMOUT) ? 1 : 0;
    assign stallD = load_stall;
    assign stallF = load_stall;
    assign flushE = load_stall;
    
    // forward for branch
    wire branch;
    assign branch = (branch_type != `BRANCH_NONE) ? 1 : 0;
    assign sel_branch_forward_rs = (branch && rs != 0 && rs == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_MEMOUT) ? 2'b11 :
                                   (branch && rs != 0 && rs == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_ALUOUT) ? 2'b10 :
                                   (branch && rs != 0 && rs == wdstE && reg_wenE && sel_reg_wdataE == `SEL_REG_WDATA_ALUOUT) ? 2'b01 :
                                   2'b00;
    assign sel_branch_forward_rt = (branch && rt != 0 && rt == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_MEMOUT) ? 2'b11 :
                                   (branch && rt != 0 && rt == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_ALUOUT) ? 2'b10 :
                                   (branch && rt != 0 && rt == wdstE && reg_wenE && sel_reg_wdataE == `SEL_REG_WDATA_ALUOUT) ? 2'b01 :
                                   2'b00;
    
    // forward for cp0 data out
    assign sel_forward_cp0_data_o = (cp0_wenM == 1'b1) ? 1 :0;
    
    // forward for jr jarl
    assign sel_jump_forward_rs = (rs != 0 && rs == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_MEMOUT) ? 2'b11 :
                                 (rs != 0 && rs == wdstM && reg_wenM && sel_reg_wdataM == `SEL_REG_WDATA_ALUOUT) ? 2'b10 :
                                 (rs != 0 && rs == wdstE && reg_wenE && sel_reg_wdataE == `SEL_REG_WDATA_ALUOUT) ? 2'b01 :
                                 2'b00;
endmodule
