module Controller(
input add_instrc,
input addu_instrc,
input sub_instrc,
input subu_instrc,
input and_instrc,
input or_instrc,
input xor_instrc,
input nor_instrc,
input slt_instrc,
input sltu_instrc,
input sll_instrc,
input srl_instrc,
input sra_instrc,
input sllv_instrc,
input srlv_instrc,
input srav_instrc,
input jr_instrc,
input addi_instrc,
input addiu_instrc,
input andi_instrc,
input ori_instrc,
input xori_instrc,
input lui_instrc,
input lw_instrc,
input sw_instrc,
input beq_instrc,
input bne_instrc,
input slti_instrc,
input sltiu_instrc,
input j_instrc,
input jal_instrc,
input mult_instrc,
input multu_instrc,
input div_instrc,
input divu_instrc,
input mflo_instrc,
input mfhi_instrc,
input mthi_instrc,
input mtlo_instrc,
input lb_instrc,
input lbu_instrc,
input lh_instrc,
input lhu_instrc,
input sb_instrc,
input sh_instrc,
input bgez_instrc,
input jalr_instrc,
input break_instrc,                                  
input syscall_instrc,
input teq_instrc,
input eret_instrc,
input mfc0_instrc,
input mtc0_instrc,
input clz_instrc,

output M1,
output M2,
output M3,
output M4,
output M5,
output M6,
output M7,
output M8,
output M9,
output [1:0] M10,
output M11,
output M12,
output M13,
output M14,
output M15,
output M16,
output M17,
output M18,
output M19,
output M20,
output [1:0] cs,
output ready,
output [1:0] w,
output IM_R,
output wena1,
output wena2,
output [3:0] aluc,
output ena,
output WR
);

assign M1 = (sll_instrc || srl_instrc || sra_instrc)?0:1;
assign M2 = (addi_instrc || addiu_instrc || andi_instrc || ori_instrc || xori_instrc || lw_instrc || sw_instrc || slti_instrc || sltiu_instrc
             || lb_instrc || lbu_instrc || lh_instrc || lhu_instrc || sb_instrc || sh_instrc)?0:1;
assign M3 = (addi_instrc || lw_instrc || sw_instrc || slti_instrc || sltiu_instrc || addiu_instrc
             || lb_instrc || lbu_instrc || lh_instrc || lhu_instrc || sb_instrc || sh_instrc)?1:0;
assign M4 = (lui_instrc || jal_instrc || jalr_instrc || mfc0_instrc)?1:0;
assign M5 = (lw_instrc || lb_instrc || lbu_instrc || lh_instrc || lhu_instrc)?0:1;
assign M6 = (beq_instrc || bne_instrc || bgez_instrc)?0:1;
assign M7 = (j_instrc || jal_instrc || eret_instrc)?1:0;
assign M8 = (jal_instrc || jalr_instrc)?0:1;
assign M9 = (jr_instrc || jalr_instrc)?0:1;
assign M10 = (mult_instrc)?2'b00:(
              multu_instrc?2'b01:(
              div_instrc?2'b10:2'b11));
assign M11 =  (mflo_instrc || mfhi_instrc)?1:0;
assign M12 = mthi_instrc?1:0;
assign M13 = mtlo_instrc?1:0;
assign M14 = lb_instrc?1:0;
assign M15 = lh_instrc?1:0;
assign M16 = (lh_instrc || lhu_instrc)?1:0;
assign M17 = lw_instrc?0:1;
assign M18 = eret_instrc?1:0;
assign M19 = mfc0_instrc?1:0;
assign M20 = clz_instrc?1:0;


assign cs = (mfhi_instrc || mthi_instrc)? 2'b11:(
            (mtlo_instrc || mflo_instrc)? 2'b00:2'b01);
assign ready = (mthi_instrc || mtlo_instrc)?1:0;
assign w = sw_instrc?2'b00:(
           sb_instrc?2'b10:2'b01);

assign wena2 = (mult_instrc || multu_instrc || div_instrc || divu_instrc || mthi_instrc || mtlo_instrc)?1:0;                   
assign IM_R = 1;
assign wena1 = (jr_instrc || sw_instrc || beq_instrc || bne_instrc || j_instrc || mult_instrc || multu_instrc || div_instrc || divu_instrc || mthi_instrc || mtlo_instrc
                || sb_instrc || sh_instrc || bgez_instrc || break_instrc || syscall_instrc || teq_instrc || eret_instrc || mtc0_instrc )?0:1;
assign ena = (lw_instrc || sw_instrc || lb_instrc || lbu_instrc || lh_instrc || lhu_instrc || sb_instrc || sh_instrc )?1:0;
assign WR = (sw_instrc || sb_instrc || sh_instrc)?1:0;

assign aluc[0] = (sub_instrc || subu_instrc || or_instrc || nor_instrc || slt_instrc || srl_instrc || srlv_instrc || ori_instrc || beq_instrc || bne_instrc || slti_instrc || bgez_instrc || teq_instrc )?1:0;
assign aluc[1] = (addu_instrc || subu_instrc || and_instrc || or_instrc || srl_instrc || sra_instrc || srlv_instrc || srav_instrc || addiu_instrc || andi_instrc || ori_instrc)?0:1;
assign aluc[2] = (and_instrc || or_instrc || xor_instrc || nor_instrc || sll_instrc || srl_instrc || sra_instrc || sllv_instrc || srlv_instrc || srav_instrc || andi_instrc || ori_instrc || xori_instrc )?1:0;
assign aluc[3] = (slt_instrc || sltu_instrc || sll_instrc || srl_instrc || sra_instrc || sllv_instrc || srlv_instrc || srav_instrc || slti_instrc || sltiu_instrc)?1:0;

endmodule
