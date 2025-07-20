module DMEM (
input clk,
input ena,
input [1:0] w,
input WR,
input [31:0] addr,//输入地址，指定数据读写的地址 
input [31:0] datain_32, //存储器写入的数据，在 clk 上升沿时被写入 
input [15:0] datain_16,
input [7:0] datain_8,
output [31:0] dataout_32, //存储器读出的数据 
output [15:0] dataout_16,
output [7:0] dataout_8
);
reg [31:0] file [1023:0]; 

assign dataout_32 = ((ena && !WR)?file[addr>>2]:32'bz);
assign dataout_16 = ((ena && !WR) ? 
    (addr[1]==1'b1 ? file[addr >> 2][31:16] : file[addr >> 2][15:0]) : 
    16'bz);
assign dataout_8 = ((ena && !WR) ? 
    (addr[1:0] == 2'b00 ? file[addr >> 2][7:0] :
    (addr[1:0] == 2'b01 ? file[addr >> 2][15:8] :
    (addr[1:0] == 2'b10 ? file[addr >> 2][23:16] : file[addr >> 2][31:24]))) :
    8'bz);
                                   
always @(posedge clk)
begin
    if (ena)
    begin
        if (WR)
        begin
            if (w==2'b00)
                file[addr >> 2] = datain_32;
            else if (w==2'b01)
            begin
                if (addr[1]==0)
                    file[addr >> 2][15:0] = datain_16;
                else
                    file[addr >> 2][31:16] = datain_16;
            end
            else if (w==2'b10)
            begin
                if (addr[1:0]==2'b00)
                    file[addr >> 2][7:0] = datain_8;
                else if (addr[1:0]==2'b01)
                    file[addr >> 2][15:8] = datain_8;
                else if (addr[1:0]==2'b10)
                    file[addr >> 2][23:16] = datain_8;
                else 
                    file[addr >> 2][31:24] = datain_8;
            end
        end
    end
end
endmodule
