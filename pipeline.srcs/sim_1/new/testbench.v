`timescale 1ns / 1ps

module testbench();
    reg clk, rst;
    mips mips_core(clk, rst);
    
    initial begin
        $readmemh("/home/silvester/project/pipeline/inst.txt", mips_core.mips_im.im);
        $readmemh("/home/silvester/project/pipeline/regdata.txt", mips_core.mips_regfile.gpr);
        rst = 1;
        clk = 0;
        #17 rst = 0;
        #250
        $stop;
        
    end
    
    always #10 clk = ~clk; // clock
endmodule
