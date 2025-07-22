module MULTU(
input clk,
input reset,
input multu_instrc,
input [31:0] a,
input [31:0] b,
output ready,
output busy,
output [63:0] z
);

/*
//多周期版本
reg [63:0]tmp;
reg [63:0] stored0;
reg [63:0] stored1;
reg [63:0] stored2;
reg [63:0] stored3;
reg [63:0] stored4;
reg [63:0] stored5;
reg [63:0] stored6;
reg [63:0] stored7;
reg [63:0] stored8;
reg [63:0] stored9;
reg [63:0] stored10;
reg [63:0] stored11;
reg [63:0] stored12;
reg [63:0] stored13;
reg [63:0] stored14;
reg [63:0] stored15;
reg [63:0] stored16;
reg [63:0] stored17;
reg [63:0] stored18;
reg [63:0] stored19;
reg [63:0] stored20;
reg [63:0] stored21;
reg [63:0] stored22;
reg [63:0] stored23;
reg [63:0] stored24;
reg [63:0] stored25;
reg [63:0] stored26;
reg [63:0] stored27;
reg [63:0] stored28;
reg [63:0] stored29;
reg [63:0] stored30;
reg [63:0] stored31;
reg [5:0] cnt;

always @(posedge clk,posedge reset)
begin
    if (reset || ~multu_instrc)
    begin
        busy<=0;
        ready<=0;
        cnt <=0;    
        tmp<=0;
        stored0<=0;
        stored1<=0;
        stored2<=0;
        stored3<=0;
        stored4<=0;
        stored5<=0;
        stored6<=0;
        stored7<=0;        
        stored8<=0;
        stored9<=0;
        stored10<=0;
        stored11=0;  
        stored12<=0;
        stored13<=0;
        stored14<=0;
        stored15<=0;
        stored16<=0;
        stored17<=0;
        stored18<=0;
        stored19<=0;
        stored20<=0;
        stored21<=0;
        stored22<=0;
        stored23<=0;      
        stored24<=0;
        stored25<=0;
        stored26<=0;
        stored27<=0;
        stored28<=0;
        stored29<=0;
        stored30<=0;      
        stored31<=0;                         
    end
    else if (multu_instrc)
    begin
        if (cnt==0)
        begin
            busy<=1;
            cnt<=1;
            stored0 <= b[0] ? {32'b0,a}:64'b0;
            stored1 <= b[1] ? {31'b0,a,1'b0}:64'b0;
            stored2 <= b[2] ? {30'b0,a,2'b0}:64'b0;
            stored3 <= b[3] ? {29'b0,a,3'b0}:64'b0;
            stored4 <= b[4] ? {28'b0,a,4'b0}:64'b0;
            stored5 <= b[5] ? {27'b0, a, 5'b0} : 64'b0;
            stored6 <= b[6] ? {26'b0, a, 6'b0} : 64'b0;
            stored7 <= b[7] ? {25'b0, a, 7'b0} : 64'b0;
            stored8 <= b[8] ? {24'b0, a, 8'b0} : 64'b0;
            stored9 <= b[9] ? {23'b0, a, 9'b0} : 64'b0;
            stored10 <= b[10] ? {22'b0, a, 10'b0} : 64'b0;
            stored11 <= b[11] ? {21'b0, a, 11'b0} : 64'b0;
            stored12 <= b[12] ? {20'b0, a, 12'b0} : 64'b0;
            stored13 <= b[13] ? {19'b0, a, 13'b0} : 64'b0;
            stored14 <= b[14] ? {18'b0, a, 14'b0} : 64'b0;
            stored15 <= b[15] ? {17'b0, a, 15'b0} : 64'b0;
            stored16 <= b[16] ? {16'b0, a, 16'b0} : 64'b0;
            stored17 <= b[17] ? {15'b0, a, 17'b0} : 64'b0;
            stored18 <= b[18] ? {14'b0, a, 18'b0} : 64'b0;
            stored19 <= b[19] ? {13'b0, a, 19'b0} : 64'b0;
            stored20 <= b[20] ? {12'b0, a, 20'b0} : 64'b0;
            stored21 <= b[21] ? {11'b0, a, 21'b0} : 64'b0;
            stored22 <= b[22] ? {10'b0, a, 22'b0} : 64'b0;
            stored23 <= b[23] ? {9'b0, a, 23'b0} : 64'b0;
            stored24 <= b[24] ? {8'b0, a, 24'b0} : 64'b0;
            stored25 <= b[25] ? {7'b0, a, 25'b0} : 64'b0;
            stored26 <= b[26] ? {6'b0, a, 26'b0} : 64'b0;
            stored27 <= b[27] ? {5'b0, a, 27'b0} : 64'b0;
            stored28 <= b[28] ? {4'b0, a, 28'b0} : 64'b0;
            stored29 <= b[29] ? {3'b0, a, 29'b0} : 64'b0;
            stored30 <= b[30] ? {2'b0, a, 30'b0} : 64'b0;
            stored31 <= b[31] ? {1'b0, a, 31'b0} : 64'b0;
        end
        else if (cnt==1)
        begin
            cnt<=2;
            ready<=1;
            busy<=1;
            tmp <= stored0 + stored1 + stored2 + stored3 + stored4 + stored5 + stored6 +
                           stored7 + stored8 + stored9 + stored10 + stored11 + stored12 + stored13 +
                           stored14 + stored15 + stored16 + stored17 + stored18 + stored19 + stored20 +
                           stored21 + stored22 + stored23 + stored24 + stored25 + stored26 + stored27 +
                           stored28 + stored29 + stored30 + stored31;
        end
        else
        begin
            cnt<=0;
            ready<=0;
            busy<=0;
        end      
    end   
end
assign z = tmp;
*/

//单周期版本
wire [63:0] unsigned_A;             //扩展的无符号A
wire [63:0] unsigned_B;             //扩展的无符号B
wire [63:0] unsigned_result;        //保存无符号乘法结果

assign unsigned_A = { 32'd0, a };
assign unsigned_B = { 32'd0, b };
assign unsigned_result = unsigned_A * unsigned_B;
assign z = unsigned_result;
assign busy = 0;
assign ready = 1;


endmodule