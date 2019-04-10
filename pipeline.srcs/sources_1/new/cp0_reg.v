`timescale 1ns / 1ps
`include "ctrl_def.v"

module cp0_reg(
    input wire clk,
    input wire rst,
    input wire we,
    input wire[4:0] waddr,
    input wire[4:0] raddr,
    input wire[31:0] wdata,
    
    input wire[5:0] int_i,
    
    output reg[31:0] data_o,
    output reg       timer_int_o
    );
    
    reg[31:0] cp0_reg_count;
    reg[31:0] cp0_reg_compare;
    reg[31:0] cp0_reg_status;
    reg[31:0] cp0_reg_cause;
    reg[31:0] cp0_reg_epc;
//    reg[31:0] cp0_reg_prid,
    reg[31:0] cp0_reg_config;
    
    always @ (negedge clk) begin
        if (rst == 1) begin
            cp0_reg_count <= 32'h00000000;
            cp0_reg_compare <= 32'h00000000;
            cp0_reg_status <= 32'h10000000;
            cp0_reg_cause <= 32'h00000000;
            cp0_reg_epc <= 32'h00000000;
//            cp0_reg_prid <= 
            cp0_reg_config <= 32'h00000000;
            timer_int_o <= 1'b0;
        end else begin
            cp0_reg_count <= cp0_reg_count + 1;
            cp0_reg_cause[15:10] <= int_i;
            
            if (cp0_reg_compare != 32'h00000000 && cp0_reg_count == cp0_reg_compare) begin
                timer_int_o <= 1'b1;
            end
            
            if (we == 1'b1) begin
                case (waddr)
                `CP0_REG_COUNT : begin
                    cp0_reg_count <= wdata;
                end
                `CP0_REG_COMPARE : begin
                    cp0_reg_compare <= wdata;
                    timer_int_o <= 1'b0;
                end
                `CP0_REG_STATUS : begin
                    cp0_reg_status <= wdata;
                end
                `CP0_REG_EPC : begin
                    cp0_reg_epc <= wdata;
                end
                `CP0_REG_CAUSE : begin
                    cp0_reg_cause[9:8] <= wdata[9:8];
                    cp0_reg_cause[23] <= wdata[23];
                    cp0_reg_cause[22] <= wdata[22];
                end
                endcase
            end
        end
    end
    
    always @ (*) begin
        if (rst == 1'b1) begin
            data_o <= 32'h00000000;
        end else begin
            case (raddr)
            `CP0_REG_COUNT : begin
                data_o <= cp0_reg_count;
            end
            `CP0_REG_COMPARE : begin
                data_o <= cp0_reg_compare;
            end
            `CP0_REG_STATUS : begin
                data_o <= cp0_reg_status;
            end
            `CP0_REG_EPC : begin
                data_o <= cp0_reg_epc;
            end
            `CP0_REG_CAUSE : begin
                data_o <= cp0_reg_cause;
            end
            endcase
        end
    end
endmodule
