module IMEM (
input IM_R, //存储器有效信号，高电平时存储器才运行，否则输出 z 
input [10:0] addr, //输入地址，指定数据读写的地址 
output [31:0] data_out//存储器读出的数据 
);

/*
//addi->ori
imem imem_inst(
.a(addr),
.spo(data_out)
);
*/
/*
//lui
imem0 imem0_inst(
.a(addr),
.spo(data_out)
);
*/
imem1 imem1_inst(
.a(addr),
.spo(data_out)
);
/*
reg [31:0] ram [2047:0];
initial begin
$readmemh("C:\\Users\\Lenovo\\Desktop\\54条CPUtest指令示例和测试说明\\54_div.hex.txt", ram);
end
assign data_out = ram[addr];
*/
/*
10_and.result.txt
11_beq.result.txt
12_bne.result.txt
13_j.result.txt
14_jal.result.txt
15_jr.result.txt
16.26_lwsw.result.txt
16.26_lwsw2.result.txt
17_xor.result.txt
18_nor.result.txt
19_or.result.txt
1_addi.result.txt
20_sll.result.txt
21_sllv.result.txt
22_sltu.result.txt
23_sra.result.txt
24_srl.result.txt
25_subu.result.txt
27_add.result.txt
28_sub.result.txt
29_slt.result.txt
2_addiu.result.txt
30_srlv.result.txt
31_srav.result.txt
32_clz.result.txt
33_divu.result.txt
35_jalr.result.txt
36.39_lbsb.result.txt
36.39_lbsb2.result.txt
37_lbu.result.txt
37_lbu2.result.txt
38_lhu.result.txt
38_lhu2.result.txt
3_andi.result.txt
40.41_lhsh.result.txt
40.41_lhsh2.result.txt
42.45_mfc0mtc0.result.txt
43.46_mfhi.mthi.result.txt
44.47_mflo.mtlo.result.txt
48_mult.result.txt
49_multu.result.txt
4_ori.result.txt
52_bgez.result.txt
54_div.result.txt
5_sltiu.result.txt
6_lui.result.txt
7_xori.result.txt
8_slti.result.txt
9_addu.result.txt
*/
endmodule