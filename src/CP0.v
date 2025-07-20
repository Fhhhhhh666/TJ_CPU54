module CP0( 
input clk, 
input rst, 
input mfc0,   //CPU指令Mfc0
input mtc0,   //CPU指令Mtc0
input [31:0]pc, 
input [4:0] Rd,  //指定CP0寄存器
input [31:0] wdata,   //数据从GP寄存器到CP0寄存器
input exception, 
input eret,     // 指令ERET
input [4:0]cause, 
input intr,    //暂不用考虑
output [31:0] rdata, //数据从CP0寄存器到GP寄存器
output [31:0] status, 
output reg timer_int,  //暂不用考虑
output [31:0]exc_addr   //异常起始地址
);

parameter STATUS = 12,
            CAUSE = 13,
            EPC= 14;

reg [31:0] CP0_reg [31:0];
assign status = CP0_reg[STATUS];
assign rdata = (mfc0)? CP0_reg[Rd] : 32'bz;
assign exc_addr = (eret)? CP0_reg[EPC] : 32'bz;

always@(posedge clk,posedge rst)
begin
    if (rst)
    begin
        CP0_reg[0] <= 32'b0;
        CP0_reg[1] <= 32'b0;
        CP0_reg[2] <= 32'b0;
        CP0_reg[3] <= 32'b0;
        CP0_reg[4] <= 32'b0;
        CP0_reg[5] <= 32'b0;
        CP0_reg[6] <= 32'b0;
        CP0_reg[7] <= 32'b0;
        CP0_reg[8] <= 32'b0;
        CP0_reg[9] <= 32'b0;
        CP0_reg[10] <= 32'b0;
        CP0_reg[11] <= 32'b0;
        CP0_reg[12] <= 32'b0;
        CP0_reg[13] <= 32'b0;
        CP0_reg[14] <= 32'b0;
        CP0_reg[15] <= 32'b0;
        CP0_reg[16] <= 32'b0;
        CP0_reg[17] <= 32'b0;
        CP0_reg[18] <= 32'b0;
        CP0_reg[19] <= 32'b0;
        CP0_reg[20] <= 32'b0;
        CP0_reg[21] <= 32'b0;
        CP0_reg[22] <= 32'b0;
        CP0_reg[23] <= 32'b0;
        CP0_reg[24] <= 32'b0;
        CP0_reg[25] <= 32'b0;
        CP0_reg[26] <= 32'b0;
        CP0_reg[27] <= 32'b0;
        CP0_reg[28] <= 32'b0;
        CP0_reg[29] <= 32'b0;
        CP0_reg[30] <= 32'b0;
        CP0_reg[31] <= 32'b0;    
    end
    else
    begin
        if (mtc0)
        begin
            CP0_reg[Rd]<= wdata;
        end
        else if (exception)
        begin
            CP0_reg[STATUS] <= (CP0_reg[STATUS] << 5);
            CP0_reg[CAUSE] <= {24'b0,cause,2'b0};
            CP0_reg[EPC] <= pc;      
        end
        else if (eret)
        begin
            CP0_reg[STATUS] <= (CP0_reg[STATUS] >> 5);
        end
    end
end
endmodule