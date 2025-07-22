module PC(
input clk,
input rst,//�ߵ�ƽ��Ч
input ena,
input busy,
input [31:0] addr_in,
output [31:0] addr_out
);
reg [31:0] pc_reg;
assign addr_out = (ena)?pc_reg:32'bz;

always@(negedge clk,posedge rst)
begin
if (rst && ena)
    pc_reg=32'h00400000;
else if (ena)  //else if (ena && ！busy)  乘除指令多周期
    pc_reg=addr_in;
end
endmodule
