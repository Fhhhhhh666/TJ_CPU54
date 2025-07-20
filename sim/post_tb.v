`timescale 1ns / 1ps
 module cpu_post_tb;
reg clk;            
reg rst;            
wire [31:0] inst;   
wire [31:0] pc;     

initial 
begin
clk = 1'b0;
rst = 1'b1;
#50 rst = 1'b0;
end

always  #50 clk = ~clk;
sccomp_dataflow sc_inst(
.clk_in(clk),
.reset(rst),
.inst(inst), 
.pc(pc)
);


endmodule