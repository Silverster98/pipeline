`timescale 1ns / 1ps
`include "ctrl_def.v"

module branch_judge(
    input wire[31:0] rs1,
    input wire[31:0] rs2,
    
    output wire[1:0] branch_judge
    );
    
    wire[32:0] temp;
    assign temp = {rs1[31], rs1} - {rs2[31], rs2};
    assign branch_judge = (temp == 0) ? `JUDGE_EZ :
                          (temp > 0)  ? `JUDGE_GZ :
                          `JUDGE_LZ;
endmodule
