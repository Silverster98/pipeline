`timescale 1ns / 1ps

module conflict_detect(
    input wire[4:0] rsE, rtE, wdstM, wdstW,
    input wire reg_wenM, reg_wenW,
    
    output wire[1:0] sel_forward_rs, sel_forward_rt
    );
    
    assign sel_forward_rs = (rsE != 0 && rsE == wdstM && reg_wenM) ? 2'b10 : 
                            (rsE != 0 && rsE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;
    assign sel_forward_rt = (rtE != 0 && rtE == wdstM && reg_wenM) ? 2'b10 : 
                            (rtE != 0 && rtE == wdstW && reg_wenW) ? 2'b01 :
                            2'b00;
endmodule
