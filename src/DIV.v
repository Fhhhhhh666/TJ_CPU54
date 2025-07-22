module DIV(
input [31:0] dividend,
input [31:0] divisor,
input start,
input clock,
input reset,
output [63:0] z,
output reg busy,
output reg ready
);
wire [31:0] q;
wire [31:0] r;
reg judge = 1;
reg [4:0] count;
reg [31:0] reg_q;
reg [31:0] reg_r;
reg [31:0] reg_b;
reg r_sign;
wire [32:0] sub_add = r_sign?{reg_r,reg_q[31]}+{1'b0,reg_b}:{reg_r,reg_q[31]}-{1'b0,reg_b};
assign r = dividend[31]?~reg_r+1:reg_r;
assign q = (dividend[31] == divisor[31])?reg_q:(~reg_q+1);
assign z = {r,q};
always @(posedge clock,posedge reset)
begin
    if (reset==1||~start)
    begin
        ready<=0;
        count<=5'b0;
        judge<=1;
        busy<=0;
    end
    else
    begin
        if (start)
        begin
            if (count==5'b00000 && ~busy)
            begin
            reg_r<=32'b0;
            r_sign<=0;
            reg_q<=((dividend[31]==1)?(~dividend+1):dividend);
            reg_b<=((divisor[31]==1)?(~divisor+1):divisor);
            judge<=1;
            busy<=1'b1;
            end
            else if(busy && judge)
            begin
                reg_r<=sub_add[31:0];
                r_sign<=sub_add[32];
                reg_q<={reg_q[30:0],~sub_add[32]};
                count<=count+1;
                    if (count==5'b11111)
                    begin
                        judge<=0;
                    end
            end
            else if (busy && !judge)
            begin
                if (~ready)
                begin
                    reg_r <= r_sign ? reg_r + reg_b:reg_r;
                    ready<=1;
                end
                else
                begin
                    busy<=0;
                end      
            end
        end
    end
end
endmodule