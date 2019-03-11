`timescale 1ns / 1ps

module conflict_detect(
    input wire[4:0] rsE, rtE, wdstM, wdstW,
    input wire reg_wenM, reg_wenW,
    input wire[4:0] rs, rt,
    input wire sel_reg_wdataE,
    input wire sel_branch,
    
    output wire[1:0] sel_forward_rs, sel_forward_rt,
    output wire stallD, stallF, flushD, flushE, flushM
    );
    
    // forward
    assign sel_forward_rs = (rsE != 0 && rsE == wdstM && reg_wenM) ? 2'b10 : 
                            (rsE != 0 && rsE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;
    assign sel_forward_rt = (rtE != 0 && rtE == wdstM && reg_wenM) ? 2'b10 : 
                            (rtE != 0 && rtE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;

    // stall
    wire lwstall;
    assign lwstall = ((rs == rtE || rt == rtE) && sel_reg_wdataE);
    assign stallD = lwstall;
    assign stallF = lwstall;
    assign flushE = (sel_branch == 1) ? 1 :lwstall;
    assign flushM = (sel_branch == 1) ? 1 : 0;
    assign flushD = (sel_branch == 1) ? 1 : 0;
endmodule
