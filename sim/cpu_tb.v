module cpu_tb;
reg clk;            //时钟信号
reg rst;            //复位信号
wire [31:0] inst;   //要执行的指令
wire [31:0] pc;     //下一条指令的地址
initial 
begin
    clk = 1'b0;
    rst = 1'b1;
    #25 rst = 1'b0;
end
always  #50 clk = ~clk;
/*
always @ (posedge clk) begin
    last_pc<=pc;
    last_inst<=inst;
    file_open = $fopen("C:\\Users\\Lenovo\\Desktop\\result\\_246tb_ex10_result.txt", "a+");
    $fdisplay(file_open, "pc: %h", last_pc);
    $fdisplay(file_open, "instr: %h", last_inst);
    $fdisplay(file_open, "regfile0: %h", sc_inst.sccpu.cpu_ref.array_reg[0]);   
    $fdisplay(file_open, "regfile1: %h", sc_inst.sccpu.cpu_ref.array_reg[1]);
    $fdisplay(file_open, "regfile2: %h", sc_inst.sccpu.cpu_ref.array_reg[2]);
    $fdisplay(file_open, "regfile3: %h", sc_inst.sccpu.cpu_ref.array_reg[3]);
    $fdisplay(file_open, "regfile4: %h", sc_inst.sccpu.cpu_ref.array_reg[4]);
    $fdisplay(file_open, "regfile5: %h", sc_inst.sccpu.cpu_ref.array_reg[5]);
    $fdisplay(file_open, "regfile6: %h", sc_inst.sccpu.cpu_ref.array_reg[6]);
    $fdisplay(file_open, "regfile7: %h", sc_inst.sccpu.cpu_ref.array_reg[7]);
    $fdisplay(file_open, "regfile8: %h", sc_inst.sccpu.cpu_ref.array_reg[8]);
    $fdisplay(file_open, "regfile9: %h", sc_inst.sccpu.cpu_ref.array_reg[9]);
    $fdisplay(file_open, "regfile10: %h", sc_inst.sccpu.cpu_ref.array_reg[10]);
    $fdisplay(file_open, "regfile11: %h", sc_inst.sccpu.cpu_ref.array_reg[11]);
    $fdisplay(file_open, "regfile12: %h", sc_inst.sccpu.cpu_ref.array_reg[12]);
    $fdisplay(file_open, "regfile13: %h", sc_inst.sccpu.cpu_ref.array_reg[13]);
    $fdisplay(file_open, "regfile14: %h", sc_inst.sccpu.cpu_ref.array_reg[14]);
    $fdisplay(file_open, "regfile15: %h", sc_inst.sccpu.cpu_ref.array_reg[15]);
    $fdisplay(file_open, "regfile16: %h", sc_inst.sccpu.cpu_ref.array_reg[16]);
    $fdisplay(file_open, "regfile17: %h", sc_inst.sccpu.cpu_ref.array_reg[17]);
    $fdisplay(file_open, "regfile18: %h", sc_inst.sccpu.cpu_ref.array_reg[18]);
    $fdisplay(file_open, "regfile19: %h", sc_inst.sccpu.cpu_ref.array_reg[19]);
    $fdisplay(file_open, "regfile20: %h", sc_inst.sccpu.cpu_ref.array_reg[20]);
    $fdisplay(file_open, "regfile21: %h", sc_inst.sccpu.cpu_ref.array_reg[21]);
    $fdisplay(file_open, "regfile22: %h", sc_inst.sccpu.cpu_ref.array_reg[22]);
    $fdisplay(file_open, "regfile23: %h", sc_inst.sccpu.cpu_ref.array_reg[23]);
    $fdisplay(file_open, "regfile24: %h", sc_inst.sccpu.cpu_ref.array_reg[24]);
    $fdisplay(file_open, "regfile25: %h", sc_inst.sccpu.cpu_ref.array_reg[25]);
    $fdisplay(file_open, "regfile26: %h", sc_inst.sccpu.cpu_ref.array_reg[26]);
    $fdisplay(file_open, "regfile27: %h", sc_inst.sccpu.cpu_ref.array_reg[27]);
    $fdisplay(file_open, "regfile28: %h", sc_inst.sccpu.cpu_ref.array_reg[28]);
    $fdisplay(file_open, "regfile29: %h", sc_inst.sccpu.cpu_ref.array_reg[29]);
    $fdisplay(file_open, "regfile30: %h", sc_inst.sccpu.cpu_ref.array_reg[30]);
    $fdisplay(file_open, "regfile31: %h", sc_inst.sccpu.cpu_ref.array_reg[31]);        
    $fclose(file_open);
end
*/
sccomp_dataflow sc_inst(
    .clk_in(clk),
    .reset(rst),
    .inst(inst),
    .pc(pc)
);
endmodule

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

/*
$fdisplay(file_open, "HI: %h", sc_inst.sccpu.hilo.HI_reg);   
$fdisplay(file_open, "LO: %h", sc_inst.sccpu.hilo.LO_reg);  
$fdisplay(file_open, "cs: %h", sc_inst.sccpu.cs);
$fdisplay(file_open, "file0: %h", sc_inst.dmem.file[0]);
$fdisplay(file_open, "file1: %h", sc_inst.dmem.file[1]);
$fdisplay(file_open, "file2: %h", sc_inst.dmem.file[2]);
$fdisplay(file_open, "file3: %h", sc_inst.dmem.file[3]);
$fdisplay(file_open, "file4: %h", sc_inst.dmem.file[4]);
$fdisplay(file_open, "file5: %h", sc_inst.dmem.file[5]);
$fdisplay(file_open, "file6: %h", sc_inst.dmem.file[6]);
$fdisplay(file_open, "file7: %h", sc_inst.dmem.file[7]);
$fdisplay(file_open, "file8: %h", sc_inst.dmem.file[8]);
$fdisplay(file_open, "file9: %h", sc_inst.dmem.file[9]);
$fdisplay(file_open, "file10: %h", sc_inst.dmem.file[10]);
$fdisplay(file_open, "file11: %h", sc_inst.dmem.file[11]);
$fdisplay(file_open, "file12: %h", sc_inst.dmem.file[12]);
$fdisplay(file_open, "file13: %h", sc_inst.dmem.file[13]);
$fdisplay(file_open, "file14: %h", sc_inst.dmem.file[14]);
$fdisplay(file_open, "file15: %h", sc_inst.dmem.file[15]);
$fdisplay(file_open, "dataout_16: %h", sc_inst.dmem.dataout_16);
*/