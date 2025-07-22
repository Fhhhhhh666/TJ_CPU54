module Decoder(
input [31:0] instrc,
output add_instrc,
output addu_instrc,
output sub_instrc,
output subu_instrc,
output and_instrc,
output or_instrc,
output xor_instrc,
output nor_instrc,
output slt_instrc,
output sltu_instrc,
output sll_instrc,
output srl_instrc,
output sra_instrc,
output sllv_instrc,
output srlv_instrc,
output srav_instrc,
output jr_instrc,
output addi_instrc,
output addiu_instrc,
output andi_instrc,
output ori_instrc,
output xori_instrc,
output lui_instrc,
output lw_instrc,
output sw_instrc,
output beq_instrc,
output bne_instrc,
output slti_instrc,
output sltiu_instrc,
output j_instrc,
output jal_instrc,
output mult_instrc,
output multu_instrc,
output div_instrc,
output divu_instrc,
output mflo_instrc,
output mfhi_instrc,
output mthi_instrc,
output mtlo_instrc,
output lb_instrc,
output lbu_instrc,
output lh_instrc,
output lhu_instrc,
output sb_instrc,
output sh_instrc,
output bgez_instrc,
output jalr_instrc,
output break_instrc,                                     
output syscall_instrc,
output teq_instrc,
output eret_instrc,
output mfc0_instrc,
output mtc0_instrc,
output clz_instrc,

output [15:0] imm,
output [4:0] shamt,
output [4:0] Rsc,
output [4:0] Rtc,
output [4:0] Rdc,
output [25:0] addr,
output [4:0] Rdc_CP0
);


assign imm = instrc[15:0];
assign shamt = instrc[10:6];
assign addr = instrc[25:0];
assign Rsc = instrc[25:21];
assign Rtc = (bgez_instrc)?5'b00000:instrc[20:16];
assign Rdc = (add_instrc|| addu_instrc ||sub_instrc||subu_instrc||and_instrc||or_instrc||xor_instrc
            ||nor_instrc||slt_instrc||sltu_instrc||sll_instrc|| srl_instrc ||sra_instrc||sllv_instrc||srlv_instrc
            ||srav_instrc||jr_instrc|| mflo_instrc||mfhi_instrc||clz_instrc || jalr_instrc )?instrc[15:11]:(jal_instrc)?5'b11111:instrc[20:16];
assign Rdc_CP0 = instrc[15:11];

assign add_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100000)?1:0;
assign addu_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100001)?1:0;
assign sub_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100010)?1:0;
assign subu_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100011)?1:0;
assign and_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100100)?1:0;
assign or_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100101)?1:0;
assign xor_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100110)?1:0;
assign nor_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100111)?1:0;
assign slt_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b101010)?1:0;
assign sltu_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b101011)?1:0;
assign sll_instrc = (instrc[31:26]==6'b0 && instrc[25:21]==5'b00000 && instrc[5:0]==6'b000000)?1:0;
assign srl_instrc = (instrc[31:26]==6'b0 && instrc[25:21]==5'b00000 && instrc[5:0]==6'b000010)?1:0;
assign sra_instrc = (instrc[31:26]==6'b0 && instrc[25:21]==5'b00000 && instrc[5:0]==6'b000011)?1:0;
assign sllv_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b000100)?1:0;
assign srlv_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b000110)?1:0;
assign srav_instrc = (instrc[31:26]==6'b0 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b000111)?1:0;
assign jr_instrc = (instrc[31:26]==6'b0 && instrc[20:16]==5'b00000 && instrc[15:11]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b001000)?1:0;

assign addi_instrc = (instrc[31:26]==6'b001000)?1:0;
assign addiu_instrc = (instrc[31:26]==6'b001001)?1:0;
assign andi_instrc = (instrc[31:26]==6'b001100)?1:0;
assign ori_instrc = (instrc[31:26]==6'b001101)?1:0;
assign xori_instrc = (instrc[31:26]==6'b001110)?1:0;
assign lui_instrc = (instrc[31:26]==6'b001111 && instrc[25:21]==5'b00000)?1:0;
assign lw_instrc = (instrc[31:26]==6'b100011)?1:0;
assign sw_instrc = (instrc[31:26]==6'b101011)?1:0;
assign beq_instrc = (instrc[31:26]==6'b000100)?1:0;
assign bne_instrc = (instrc[31:26]==6'b000101)?1:0;
assign slti_instrc = (instrc[31:26]==6'b001010)?1:0;
assign sltiu_instrc = (instrc[31:26]==6'b001011)?1:0;

assign j_instrc = (instrc[31:26]==6'b000010)?1:0;
assign jal_instrc = (instrc[31:26]==6'b000011)?1:0;

assign mult_instrc = (instrc[31:26]==6'b000000 && instrc[15:11]==5'b00000 && instrc[5:0]==6'b011000)?1:0;
assign multu_instrc = (instrc[31:26]==6'b000000 && instrc[15:11]==5'b00000 && instrc[5:0]==6'b011001)?1:0;
assign div_instrc = (instrc[31:26]==6'b000000 && instrc[15:11]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b011010)?1:0;
assign divu_instrc = (instrc[31:26]==6'b000000 && instrc[15:11]==5'b00000 && instrc[5:0]==6'b011011)?1:0;
assign mflo_instrc = (instrc[31:26]==6'b000000 && instrc[25:21]==5'b00000 && instrc[20:16]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b010010)?1:0;
assign mfhi_instrc = (instrc[31:26]==6'b000000 && instrc[25:21]==5'b00000 && instrc[20:16]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b010000)?1:0;
assign mtlo_instrc = (instrc[31:26]==6'b000000 && instrc[20:16]==5'b00000 && instrc[15:11]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b010011)?1:0;
assign mthi_instrc = (instrc[31:26]==6'b000000 && instrc[20:16]==5'b00000 && instrc[15:11]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b010001)?1:0;
assign lb_instrc = (instrc[31:26]==6'b100000)?1:0;
assign lbu_instrc = (instrc[31:26]==6'b100100)?1:0;
assign lh_instrc = (instrc[31:26]==6'b100001)?1:0;
assign lhu_instrc = (instrc[31:26]==6'b100101)?1:0;
assign sb_instrc = (instrc[31:26]==6'b101000)?1:0;
assign sh_instrc = (instrc[31:26]==6'b101001)?1:0;
assign bgez_instrc = (instrc[31:26]==6'b000001 && instrc[20:16]==5'b00001)?1:0;
assign jalr_instrc = (instrc[31:26]==6'b000000 && instrc[20:16]==5'b00000 && instrc[5:0]==6'b001001)?1:0;
assign break_instrc = (instrc[31:26]==6'b000000 && instrc[5:0]==6'b001101)?1:0;
assign syscall_instrc = (instrc[31:26]==6'b000000 && instrc[5:0]==6'b001100)?1:0;
assign teq_instrc = (instrc[31:26]==6'b000000 && instrc[5:0]==6'b110100)?1:0;
assign eret_instrc = (instrc[31:26]==6'b010000 && instrc[25:21]==5'b10000 && instrc[20:16]==5'b00000 && instrc[15:11]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b011000)?1:0;
assign mfc0_instrc = (instrc[31:26]==6'b010000 && instrc[25:21]==5'b00000 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b000000)?1:0;
assign mtc0_instrc = (instrc[31:26]==6'b010000 && instrc[25:21]==5'b00100 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b000000)?1:0;
assign clz_instrc = (instrc[31:26]==6'b011100 && instrc[10:6]==5'b00000 && instrc[5:0]==6'b100000)?1:0;

endmodule
