module HILO(
input clk,
input ena,
input rst,
input [31:0] hi_datain,
input [31:0] lo_datain,
input cs,
input wena,
input ready,
output [31:0] dataout
);
reg [31:0] HI_reg;
reg [31:0] LO_reg;
assign dataout = (cs==2'b00) ? LO_reg:(
                 (cs==2'b11) ? 32'hz:HI_reg);
//单周期版本
always@(*)   //多周期则改为 always@(posedge clk ,posedge rst)
begin
    if (ena && rst)
    begin
        HI_reg = 32'h0;
        LO_reg = 32'h0;
    end
    else if (ena && wena && ready)
    begin
        if (cs==2'b00)
            LO_reg = lo_datain;
        else if (cs==2'b11)
            HI_reg = hi_datain;
        else if (cs==2'b01)
        begin
            LO_reg = lo_datain;
            HI_reg = hi_datain;
        end
    end
end







endmodule
