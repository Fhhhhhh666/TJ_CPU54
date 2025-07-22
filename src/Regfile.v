module regfile(
input clk,
input ena,
input rst,
input [31:0] datain,
input [4:0] Rsc,
input [4:0] Rtc,
input [4:0] Rdc,
input wena,
output [31:0] Rs,
output [31:0] Rt
);
reg [31:0] array_reg[31:0];

assign Rs = (ena)? array_reg[Rsc]:32'bz;
assign Rt = (ena)? array_reg[Rtc]:32'bz;
always @(posedge clk,posedge rst)
begin
if (ena && rst)
begin
       array_reg[0]  = 32'h0;
       array_reg[1]  = 32'h0;
       array_reg[2]  = 32'h0;
       array_reg[3]  = 32'h0;
       array_reg[4]  = 32'h0;
       array_reg[5]  = 32'h0;
       array_reg[6]  = 32'h0;
       array_reg[7]  = 32'h0;
       array_reg[8]  = 32'h0;
       array_reg[9]  = 32'h0;
       array_reg[10] = 32'h0;
       array_reg[11] = 32'h0;
       array_reg[12] = 32'h0;
       array_reg[13] = 32'h0;
       array_reg[14] = 32'h0;
       array_reg[15] = 32'h0;
       array_reg[16] = 32'h0;
       array_reg[17] = 32'h0;
       array_reg[18] = 32'h0;
       array_reg[19] = 32'h0;
       array_reg[20] = 32'h0;
       array_reg[21] = 32'h0;
       array_reg[22] = 32'h0;
       array_reg[23] = 32'h0;
       array_reg[24] = 32'h0;
       array_reg[25] = 32'h0;
       array_reg[26] = 32'h0;
       array_reg[27] = 32'h0;
       array_reg[28] = 32'h0;
       array_reg[29] = 32'h0;
       array_reg[30] = 32'h0;
       array_reg[31] = 32'h0;
end
else if (ena && wena)
begin
    if (Rdc!=0)
    array_reg[Rdc] = datain;
end
end

endmodule
