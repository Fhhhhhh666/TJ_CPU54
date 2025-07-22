module cpu(
input [31:0] inst,
input clk,
input [31:0] datain_32,
input [15:0] datain_16,
input [7:0] datain_8,
input pc_ena,
input pc_rst,
input reg_ena,
input reg_rst,
input mult_div_rst,
input hilo_ena,
input hilo_rst,
output [31:0] dataout_32,
output [15:0] dataout_16,
output [7:0] dataout_8,
output [31:0] addr_out,
output [31:0] ALUdataout,
output ena,
output WR,
output [1:0] w,
output IM_R,
//CP0的交互信号
input [31:0] exc_addr,
input [31:0] CP0_datain,
output eret_instrc,
output mfc0_instrc,
output mtc0_instrc,
output [31:0] NPC_out,
output [31:0] Rt,
output [4:0] Rdc_CP0,
output [5:0] cause,
output exception
);
//识别到的指令
wire add_instrc;
wire addu_instrc;
wire sub_instrc;
wire subu_instrc;
wire and_instrc;
wire or_instrc;
wire xor_instrc;
wire nor_instrc;
wire slt_instrc;
wire sltu_instrc;
wire sll_instrc;
wire srl_instrc;
wire sra_instrc;
wire sllv_instrc;
wire srlv_instrc;
wire srav_instrc;
wire jr_instrc;
wire addi_instrc;
wire addiu_instrc;
wire andi_instrc;
wire ori_instrc;
wire xori_instrc;
wire lui_instrc;
wire lw_instrc;
wire sw_instrc;
wire beq_instrc;
wire bne_instrc;
wire slti_instrc;
wire sltiu_instrc;
wire j_instrc;
wire jal_instrc;
wire mult_instrc;
wire multu_instrc;
wire div_instrc;
wire divu_instrc;
wire mflo_instrc;
wire mfhi_instrc;
wire mthi_instrc;
wire mtlo_instrc;
wire lb_instrc;
wire lbu_instrc;
wire lh_instrc;
wire lhu_instrc;
wire sb_instrc;
wire sh_instrc;
wire bgez_instrc;
wire jalr_instrc;
wire break_instrc;
wire syscall_instrc;
wire teq_instrc;
wire clz_instrc;

//指令码中读取的地址
wire [15:0] imm;
wire [4:0] shamt;
wire [4:0] Rsc;
wire [4:0] Rtc;
wire [4:0] Rdc;
wire [25:0] addr;


Decoder decoder(
.instrc(inst),
.add_instrc(add_instrc),
.addu_instrc(addu_instrc),
.sub_instrc(sub_instrc),
.subu_instrc(subu_instrc),
.and_instrc(and_instrc),
.or_instrc(or_instrc),
.xor_instrc(xor_instrc),
.nor_instrc(nor_instrc),
.slt_instrc(slt_instrc),
.sltu_instrc(sltu_instrc),
.sll_instrc(sll_instrc),
.srl_instrc(srl_instrc),
.sra_instrc(sra_instrc),
.sllv_instrc(sllv_instrc),
.srlv_instrc(srlv_instrc),
.srav_instrc(srav_instrc),
.jr_instrc(jr_instrc),
.addi_instrc(addi_instrc),
.addiu_instrc(addiu_instrc),
.andi_instrc( andi_instrc),
.ori_instrc(ori_instrc),
.xori_instrc(xori_instrc),
.lui_instrc(lui_instrc),
.lw_instrc(lw_instrc),
.sw_instrc(sw_instrc),
.beq_instrc(beq_instrc),
.bne_instrc(bne_instrc),
.slti_instrc(slti_instrc),
.sltiu_instrc(sltiu_instrc),
.j_instrc(j_instrc),
.jal_instrc(jal_instrc),
.mult_instrc(mult_instrc),
.multu_instrc(multu_instrc),
.div_instrc(div_instrc),
.divu_instrc(divu_instrc),
.mflo_instrc(mflo_instrc),
.mfhi_instrc(mfhi_instrc),
.mthi_instrc(mthi_instrc),
.mtlo_instrc(mtlo_instrc),
.lb_instrc(lb_instrc),
.lbu_instrc(lbu_instrc),
.lh_instrc(lh_instrc),
.lhu_instrc(lhu_instrc),
.sb_instrc(sb_instrc),
.sh_instrc(sh_instrc),
.bgez_instrc(bgez_instrc),
.jalr_instrc(jalr_instrc),
.break_instrc(break_instrc),
.syscall_instrc(syscall_instrc),
.teq_instrc(teq_instrc),
.eret_instrc(eret_instrc),
.mfc0_instrc(mfc0_instrc),
.mtc0_instrc(mtc0_instrc),
.clz_instrc(clz_instrc),
.imm(imm),
.shamt(shamt),
.Rsc(Rsc),
.Rtc(Rtc),
.Rdc(Rdc),
.addr(addr),
.Rdc_CP0(Rdc_CP0)
);

//信号
wire M1;
wire M2;
wire M3;
wire M4;
wire M5;
wire M6;
wire M7;
wire M8;
wire M9;
wire [1:0] M10;
wire M11;
wire M12;
wire M13;
wire M14;
wire M15;
wire M16;
wire M17;
wire M18;
wire M19;
wire M20;
wire [1:0] cs;
wire ready;
wire ready1;
wire ready2;
wire ready2_1;
wire ready2_2;
wire ready2_3;
wire ready2_4;
wire wena2;
wire wena1;
wire [3:0] aluc;



Controller controller(
.add_instrc(add_instrc),
.addu_instrc(addu_instrc),
.sub_instrc(sub_instrc),
.subu_instrc(subu_instrc),
.and_instrc(and_instrc),
.or_instrc(or_instrc),
.xor_instrc(xor_instrc),
.nor_instrc(nor_instrc),
.slt_instrc(slt_instrc),
.sltu_instrc(sltu_instrc),
.sll_instrc(sll_instrc),
.srl_instrc(srl_instrc),
.sra_instrc(sra_instrc),
.sllv_instrc(sllv_instrc),
.srlv_instrc(srlv_instrc),
.srav_instrc(srav_instrc),
.jr_instrc(jr_instrc),
.addi_instrc(addi_instrc),
.addiu_instrc(addiu_instrc),
.andi_instrc( andi_instrc),
.ori_instrc(ori_instrc),
.xori_instrc(xori_instrc),
.lui_instrc(lui_instrc),
.lw_instrc(lw_instrc),
.sw_instrc(sw_instrc),
.beq_instrc(beq_instrc),
.bne_instrc(bne_instrc),
.slti_instrc(slti_instrc),
.sltiu_instrc(sltiu_instrc),
.j_instrc(j_instrc),
.jal_instrc(jal_instrc),
.mult_instrc(mult_instrc),
.multu_instrc(multu_instrc),
.div_instrc(div_instrc),
.divu_instrc(divu_instrc),
.mflo_instrc(mflo_instrc),
.mfhi_instrc(mfhi_instrc),
.mthi_instrc(mthi_instrc),
.mtlo_instrc(mtlo_instrc),
.lb_instrc(lb_instrc),
.lbu_instrc(lbu_instrc),
.lh_instrc(lh_instrc),
.lhu_instrc(lhu_instrc),
.sb_instrc(sb_instrc),
.sh_instrc(sh_instrc),
.bgez_instrc(bgez_instrc),
.jalr_instrc(jalr_instrc),
.break_instrc(break_instrc),
.syscall_instrc(syscall_instrc),
.teq_instrc(teq_instrc),
.eret_instrc(eret_instrc),
.mfc0_instrc(mfc0_instrc),
.mtc0_instrc(mtc0_instrc),
.clz_instrc(clz_instrc),
.M1(M1),
.M2(M2),
.M3(M3),
.M4(M4),
.M5(M5),
.M6(M6),
.M7(M7),
.M8(M8),
.M9(M9),
.M10(M10),
.M11(M11),
.M12(M12),
.M13(M13),
.M14(M14),
.M15(M15),
.M16(M16),
.M17(M17),
.M18(M18),
.M19(M19),
.M20(M20),
.cs(cs),
.ready(ready1),
.w(w),
.wena2(wena2),
.IM_R(IM_R),
.wena1(wena1),
.aluc(aluc),
.ena(ena),
.WR(WR)
);

//器件接口
wire [31:0] M1_out;
wire [31:0] M2_out;
wire [31:0] M3_out;
wire [31:0] M4_out;
wire [31:0] M5_out;
wire [31:0] M6_out;
wire [31:0] M7_out;
wire [31:0] M8_out;
wire [31:0] M9_out;
wire [31:0] M10_hi_out;
wire [31:0] M10_lo_out;
wire [31:0] M11_out;
wire [31:0] M12_out;
wire [31:0] M13_out;
wire [31:0] M14_out;
wire [31:0] M15_out;
wire [31:0] M16_out;
wire [31:0] M17_out;
wire [31:0] M18_out;
wire [31:0] M19_out;
wire [31:0] M20_out;
wire [31:0] M21_out;

wire [31:0] add_out;
wire [31:0] cat_out;
wire [31:0] shift16_out;
wire [31:0] unExt5_out;
wire [31:0] unExt16_1_out;
wire [31:0] Ext16_1_out;
wire [31:0] Ext18_out;
wire [31:0] clz_out;
wire [15:0] least_significant_16_out;
wire [7:0] least_significant_8_out;
wire [31:0] Ext8_out;
wire [31:0] unExt8_out;
wire [31:0] Ext16_2_out;
wire [31:0] unExt16_2_out;
wire [63:0] mult_out;
wire [63:0] multu_out;
wire [63:0] div_out;
wire [63:0] divu_out;
wire zero;
wire carry;
wire negative;
wire overflow;
wire busy;
wire busy_1;
wire busy_2;
wire busy_3;
wire busy_4;
wire [31:0] Rs;
wire [31:0] hilo_dataout;
wire [31:0] exception_addr;
assign exception_addr = 32'h00400004;
assign M1_out = M1 ? Rs:unExt5_out;
assign M2_out = M2 ? Rt:M3_out;
assign M3_out = M3 ? Ext16_1_out:unExt16_1_out;
assign M4_out = M4 ? M19_out:M20_out;
assign M5_out = M5 ? ALUdataout:M17_out;
assign M6_out = M6 ? NPC_out :((beq_instrc && zero || bne_instrc && !zero || bgez_instrc && !negative) ? add_out:NPC_out);
assign M7_out = M7 ? M18_out:M6_out;
assign M8_out = M8 ? shift16_out:NPC_out;
assign M9_out = M9 ? M7_out:Rs;
assign M10_hi_out = (M10==2'b00)?mult_out[63:32]:(
                    (M10==2'b01)?multu_out[63:32]:(
                    (M10==2'b10)?div_out[63:32]:divu_out[63:32]));
assign M10_lo_out = (M10==2'b00)?mult_out[31:0]:(
                    (M10==2'b01)?multu_out[31:0]:(
                    (M10==2'b10)?div_out[31:0]:divu_out[31:0]));
assign M11_out = M11 ? hilo_dataout:M5_out;
assign M12_out = M12 ? Rs:M10_hi_out;
assign M13_out = M13 ? Rs:M10_lo_out;
assign M14_out = M14 ? Ext8_out:unExt8_out;
assign M15_out = M15 ? Ext16_2_out:unExt16_2_out;
assign M16_out = M16 ? M15_out:M14_out;
assign M17_out = M17 ? M16_out:datain_32;
assign M18_out = M18 ? exc_addr:cat_out;
assign M19_out = M19 ? CP0_datain:M8_out;
assign M20_out = M20 ? clz_out:M11_out;
assign M21_out = exception ? exception_addr : M9_out;
assign NPC_out = addr_out+4;
assign add_out = Ext18_out + NPC_out;
assign cat_out = {{NPC_out[31:28]},addr,2'b00};
assign shift16_out = {imm,16'b0};
assign unExt5_out = {27'b0,shamt};
assign unExt16_1_out = {16'b0,imm};
assign Ext16_1_out = {{16{imm[15]}},imm};
assign Ext18_out = {{14{imm[15]}},imm,2'b0};
assign Ext8_out = {{24{datain_8[7]}},datain_8};
assign unExt8_out = {24'b0,datain_8};
assign Ext16_2_out = {{16{datain_16[15]}},datain_16};
assign unExt16_2_out = {16'b0,datain_16};
assign dataout_32 = Rt;
assign dataout_16 = Rt[15:0];
assign dataout_8 = Rt[7:0];

assign exception = (break_instrc || syscall_instrc || (teq_instrc && zero))?1:0;
assign cause = break_instrc?5'b01001:(
               syscall_instrc?5'b01000:(
               (teq_instrc && zero) ?5'b01101:5'b00000));
assign busy = busy_1 || busy_2 || busy_3 || busy_4 ;
assign ready2 = ready2_1 || ready2_2 || ready2_3 || ready2_4;
assign ready = (mult_instrc || multu_instrc || div_instrc || divu_instrc) ? ready2:ready1;

ALU alu(
.a(M1_out),
.b(M2_out),
.aluc(aluc),
.r(ALUdataout),
.zero(zero),
.carry(carry),
.negative(negative),
.overflow(overflow)
);

PC pc(
.clk(clk),
.rst(pc_rst),
.ena(pc_ena),
.busy(busy),
.addr_in(M21_out),
.addr_out(addr_out)
);

regfile cpu_ref(
.clk(clk),
.ena(reg_ena),
.rst(reg_rst),
.wena(wena1),
.datain(M4_out),
.Rsc(Rsc),
.Rtc(Rtc),
.Rdc(Rdc),
.Rs(Rs),
.Rt(Rt)
);

CLZ clz(
.datain(Rs),
.dataout(clz_out)
);

MULT mult(
.clk(clk),
.reset(mult_div_rst),
.mult_instrc(mult_instrc),
.a(Rs),
.b(Rt),
.ready(ready2_1),
.busy(busy_1),
.z(mult_out)
);

MULTU multu(
.clk(clk),
.reset(mult_div_rst),
.multu_instrc(multu_instrc),
.a(Rs),
.b(Rt),
.ready(ready2_2),
.busy(busy_2),
.z(multu_out)
);

DIV div(
.dividend(Rs),
.divisor(Rt),
.start(div_instrc),
.clock(clk),
.reset(mult_div_rst),
.busy(busy_3),
.z(div_out),
.ready(ready2_3)
);

DIVU divu(
.dividend(Rs),
.divisor(Rt),
.start(divu_instrc),
.clock(clk),
.reset(mult_div_rst),
.z(divu_out),
.busy(busy_4),
.ready(ready2_4)
);

HILO hilo(
.clk(clk),
.ena(hilo_ena),
.rst(hilo_rst),
.hi_datain(M12_out),
.lo_datain(M13_out),
.cs(cs),
.wena(wena2),
.ready(ready),
.dataout(hilo_dataout)
);

endmodule
