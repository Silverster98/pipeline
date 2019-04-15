`timescale 1ns / 1ps

module testbench();
    reg clk, rst;
    wire[7:0] io_out;
    mymips mymips_core(
        .clk(clk),
        .rst(rst),
        
        .io_out(io_out)
    );
    
    initial begin
//        $readmemh("/home/silvester/project/pipeline/inst.txt", mips_core.mips_im.im);
//        $readmemh("/home/silvester/project/pipeline/regdata.txt", mips_core.mips_regfile.gpr);
        rst = 1;
        clk = 0;
        #17 rst = 0;
        #16000
        $stop;
        
    end
    
    always #5 clk = ~clk; // clock
endmodule
