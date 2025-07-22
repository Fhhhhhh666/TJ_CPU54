module DIVU(
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
reg [4:0] count;
reg [31:0] reg_q;
reg [31:0] reg_r;
reg [31:0] reg_b;
reg r_sign;
wire [32:0] sub_add = r_sign?{reg_r,q[31]}+{1'b0,reg_b}:{reg_r,q[31]}-{1'b0,reg_b};
assign r = r_sign ? reg_r+reg_b :reg_r;
assign q = reg_q;
assign z = {r,q};
always @(posedge clock,posedge reset)
begin
    if (reset==1 || ~start)
    begin
        count<=5'b0;
        busy<=0;
        ready<=0;
    end
    else
    begin
        if (start)
        begin
            if (count==5'b00000 && ~busy)
            begin
                reg_r<=32'b0;
                r_sign<=0;
                reg_q<=dividend;
                reg_b<=divisor;
                count<=5'b0;
                busy<=1'b1;
            end
            else if(busy && ~ready)
            begin
                reg_r<=sub_add[31:0];
                r_sign<=sub_add[32];
                reg_q<={reg_q[30:0],~sub_add[32]};
                count<=count+1;
                if (count==5'b11111)
                    ready<=1;
            end
            else if (busy && ready)
            begin
                busy<=0;
                ready<=0;
            end
                
        end
    end
end
endmodule