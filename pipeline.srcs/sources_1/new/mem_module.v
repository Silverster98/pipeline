`timescale 1ns / 1ps
`include "ctrl_def.v"

module mem_module(
    input wire wen,
    input wire[1:0] addrlow2,
    input wire[31:0] mem_data_i,
    input wire[31:0] mem_wdata_i,
    input wire[`MEM_TYPE_WIDTH-1:0] mem_type,
    
    output reg[3:0] mem_wsel,
    output reg[31:0] mem_data_o,
    output reg[31:0] mem_wdata_o
    );
    
    always @ (*) begin 
        if (wen) begin
            mem_data_o <= mem_data_i;
            case (mem_type)
                `MEM_SB : begin
                    mem_wdata_o <= {mem_wdata_i[7:0], mem_wdata_i[7:0], mem_wdata_i[7:0], mem_wdata_i[7:0]};
                    case (addrlow2)
                        2'b00 : mem_wsel <= 4'b0001;
                        2'b01 : mem_wsel <= 4'b0010;
                        2'b10 : mem_wsel <= 4'b0100;
                        2'b11 : mem_wsel <= 4'b1000;
                        default : mem_wsel <= 4'b0000;
                    endcase
                end
                `MEM_SH : begin
                    mem_wdata_o <= {mem_wdata_i[15:0], mem_wdata_i[15:0]};
                    case (addrlow2)
                        2'b00 : mem_wsel <= 4'b0011;
                        2'b10 : mem_wsel <= 4'b1100;
                        default : mem_wsel <= 4'b0000;
                    endcase
                end
                `MEM_SW : begin
                    mem_wdata_o <= mem_wdata_i;
                    mem_wsel <= 4'b1111;
                end
            endcase
        end else begin
            mem_wsel <= 4'b0000;
            mem_wdata_o <= mem_wdata_i;
            case (mem_type)
                `MEM_LB : begin
                    case (addrlow2)
                        2'b00 : mem_data_o <= {{24{mem_data_i[7]}}, mem_data_i[7:0]};
                        2'b01 : mem_data_o <= {{24{mem_data_i[15]}}, mem_data_i[15:8]};
                        2'b10 : mem_data_o <= {{24{mem_data_i[23]}}, mem_data_i[23:16]};
                        2'b11 : mem_data_o <= {{24{mem_data_i[31]}}, mem_data_i[31:24]};
                    endcase
                end
                `MEM_LBU : begin
                    case (addrlow2)
                        2'b00 : mem_data_o <= {{24{1'b0}}, mem_data_i[7:0]};
                        2'b01 : mem_data_o <= {{24{1'b0}}, mem_data_i[15:8]};
                        2'b10 : mem_data_o <= {{24{1'b0}}, mem_data_i[23:16]};
                        2'b11 : mem_data_o <= {{24{1'b0}}, mem_data_i[31:24]};
                    endcase
                end
                `MEM_LH : begin
                    case (addrlow2)
                        2'b00 : mem_data_o <= {{16{mem_data_i[15]}}, mem_data_i[15:0]};
                        2'b10 : mem_data_o <= {{16{mem_data_i[31]}}, mem_data_i[31:16]};
                    endcase
                end
                `MEM_LHU : begin
                    case (addrlow2)
                        2'b00 : mem_data_o <= {{16{1'b0}}, mem_data_i[15:0]};
                        2'b10 : mem_data_o <= {{16{1'b0}}, mem_data_i[31:16]};
                    endcase
                end
                `MEM_LW : mem_data_o <= mem_data_i;
            endcase
        end
    end
endmodule
