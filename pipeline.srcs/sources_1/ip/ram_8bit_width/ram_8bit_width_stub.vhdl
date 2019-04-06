-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Sat Apr  6 14:19:29 2019
-- Host        : ubuntu running 64-bit Ubuntu 16.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/silvester/project/pipeline/pipeline.srcs/sources_1/ip/ram_8bit_width/ram_8bit_width_stub.vhdl
-- Design      : ram_8bit_width
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ram_8bit_width is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    d : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end ram_8bit_width;

architecture stub of ram_8bit_width is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[9:0],d[7:0],clk,we,spo[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2018.1";
begin
end;
