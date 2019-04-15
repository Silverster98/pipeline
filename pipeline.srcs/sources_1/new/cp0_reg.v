`timescale 1ns / 1ps
`include "ctrl_def.v"

module cp0_reg(
    input wire clk,
    input wire rst,
    input wire we,
    input wire[4:0] waddr,
    input wire[4:0] raddr,
    input wire[31:0] wdata,
    input wire[31:0] exception_final,
    input wire[31:0] current_pc,
    input wire is_in_delayslot,
    
    input wire[5:0] int_i,
    
    output reg[31:0] data_o,
    output reg       timer_int_o,
    output reg[31:0] cp0_reg_count,
    output reg[31:0] cp0_reg_compare,
    output reg[31:0] cp0_reg_status,
    output reg[31:0] cp0_reg_cause,
    output reg[31:0] cp0_reg_epc,
    output reg[31:0] cp0_reg_config
    );
    
    always @ (posedge clk) begin
        if (rst == 1) begin
            cp0_reg_count <= 32'h00000000;
            timer_int_o <= 1'b0;
        end else begin
            cp0_reg_count = cp0_reg_count + 1; // stall
            timer_int_o = 1'b0; // stall
            
            if (we == 1'b1) begin
                if (waddr == `CP0_REG_COUNT) begin
                    cp0_reg_count <= wdata;
                end
            end
            
            if (cp0_reg_compare != 32'h00000000 && cp0_reg_count == cp0_reg_compare) begin
                timer_int_o <= 1'b1;
            end
        end
    end
    
    always @ (negedge clk) begin
        if (rst == 1) begin
            cp0_reg_compare <= 32'h00000000;
            cp0_reg_status <= 32'h10000000;
            cp0_reg_cause <= 32'h00000000;
            cp0_reg_epc <= 32'h00000000;
            cp0_reg_config <= 32'h00000000;
        end else begin
            cp0_reg_cause[15:10] = int_i;
            
            if (we == 1'b1) begin
                case (waddr)
                `CP0_REG_COMPARE : begin
                    cp0_reg_compare <= wdata;
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
            
            case (exception_final)
            32'h00000001 : begin // interrupt
                if (is_in_delayslot) begin
                    cp0_reg_epc <= current_pc - 4;
                    cp0_reg_cause[31] <= 1'b1;
                end else begin
                    cp0_reg_epc <= current_pc;
                    cp0_reg_cause[31] <= 1'b0;
                end
                
                cp0_reg_status[1] <= 1'b1;
                cp0_reg_cause[6:2] <= 5'b00000;
            end
            32'h00000008 : begin // syscall
                if (cp0_reg_status[1] == 1'b0) begin
                    if (is_in_delayslot) begin
                        cp0_reg_epc <= current_pc - 4;
                        cp0_reg_cause[31] <= 1'b1;
                    end else begin
                        cp0_reg_epc <= current_pc;
                        cp0_reg_cause[31] <= 1'b0;
                    end
                end
                
                cp0_reg_status[1] <= 1'b1;
                cp0_reg_cause[6:2] <= 5'b01000;
            end
            32'h0000000a : begin // invalid instruction
                if (cp0_reg_status[1] == 1'b0) begin
                    if (is_in_delayslot) begin
                        cp0_reg_epc <= current_pc - 4;
                        cp0_reg_cause[31] <= 1'b1;
                    end else begin
                        cp0_reg_epc <= current_pc;
                        cp0_reg_cause[31] <= 1'b0;
                    end
                end
                
                cp0_reg_status[1] <= 1'b1;
                cp0_reg_cause[6:2] <= 5'b01010;
            end
            32'h0000000d : begin // trap
                if (cp0_reg_status[1] == 1'b0) begin
                    if (is_in_delayslot) begin
                        cp0_reg_epc <= current_pc - 4;
                        cp0_reg_cause[31] <= 1'b1;
                    end else begin
                        cp0_reg_epc <= current_pc;
                        cp0_reg_cause[31] <= 1'b0;
                    end
                end
                
                cp0_reg_status[1] <= 1'b1;
                cp0_reg_cause[6:2] <= 5'b01101;
            end
            32'h0000000c : begin // overflow
                if (cp0_reg_status[1] == 1'b0) begin
                    if (is_in_delayslot) begin
                        cp0_reg_epc <= current_pc - 4;
                        cp0_reg_cause[31] <= 1'b1;
                    end else begin
                        cp0_reg_epc <= current_pc;
                        cp0_reg_cause[31] <= 1'b0;
                    end
                end
                
                cp0_reg_status[1] <= 1'b1;
                cp0_reg_cause[6:2] <= 5'b01100;
            end
            32'h0000000e : begin // eret
                cp0_reg_status[1] <= 1'b0;
            end
            default : ;
            endcase
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
