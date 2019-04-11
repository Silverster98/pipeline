`timescale 1ns / 1ps

module exception_final_judge(
    input wire rst,
    input wire clk,
    input wire[31:0] cp0_epc_new,
    input wire[31:0] current_pc,
    input wire[31:0] exception_type,
    input wire[31:0] cp0_cause, cp0_status,
    
    output reg[31:0] exception_type_final,
    output reg[31:0] exception_pc,
    output reg exception
    );
    
    always @ (*) begin
        if (rst == 1) begin
            exception_type_final <= 32'h00000000;
            exception <= 1'b0;
            exception_pc <= 32'h00000000;
        end else begin
            exception_type_final = 32'h00000000;
            if (current_pc != 32'h00000000) begin
                if ((cp0_status[15:8] & cp0_cause[15:8]) != 8'h00 && (cp0_status[1] == 1'b0) && (cp0_status[0] == 1'b1)) begin
                    exception_type_final <= 32'h00000001; // interrupt
                    exception <= 1'b1;
                    exception_pc <= 32'h00000020;
                end else if (exception_type[8] == 1'b1) begin
                    exception_type_final = 32'h00000008; // syscall
                    exception <= 1'b1;
                    exception_pc <= 32'h00000040;
                end else if (exception_type[9] == 1'b0) begin
                    exception_type_final = 32'h0000000a; // inst invalid
                    exception <= 1'b1;
                    exception_pc <= 32'h00000040;
                end else if (exception_type[10] == 1'b1) begin
                    exception_type_final = 32'h0000000d; // trap
                    exception <= 1'b1;
                    exception_pc <= 32'h00000040;
                end else if (exception_type[11] == 1'b1) begin
                    exception_type_final = 32'h0000000c; // overflow
                    exception <= 1'b1;
                    exception_pc <= 32'h00000040;
                end else if (exception_type[12] == 1'b1) begin
                    exception_type_final = 32'h0000000e; // eret
                    exception <= 1'b1;
                    exception_pc <= cp0_epc_new;
                end
            end
        end
    end
endmodule
