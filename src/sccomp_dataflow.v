module sccomp_dataflow(
input clk_in,
input reset,
output [31:0] inst,
output [31:0] pc
);
wire dmem_ena;
wire WR;
wire [1:0] w;
wire [31:0] dmem_addr;
wire pc_ena;
wire reg_ena;
wire hilo_ena;
wire [31:0] cpu_dataout_32;
wire [15:0] cpu_dataout_16;
wire [7:0] cpu_dataout_8;
wire [31:0] cpu_datain_32;
wire [15:0] cpu_datain_16;
wire [7:0] cpu_datain_8;
wire [31:0] pc_in;
wire IM_R;
wire [31:0] exc_addr;
wire [31:0] rdata;
wire eret_instrc;
wire mfc0_instrc;
wire mtc0_instrc;
wire [31:0] CP0_pc;
wire [31:0] wdata;
wire [4:0] Rdc_CP0;
wire [5:0] cause;
wire exception;

assign pc_ena = 1;
assign reg_ena = 1;
assign dmem_ena = 1;
assign hilo_ena = 1;
assign pc_in = (pc-32'h00400000);
cpu sccpu(
.clk(clk_in),
.pc_ena(pc_ena),
.pc_rst(reset),
.reg_ena(reg_ena),
.reg_rst(reset),
.mult_div_rst(reset),
.hilo_ena(hilo_ena),
.hilo_rst(reset),
.inst(inst),
.dataout_32(cpu_dataout_32),
.dataout_16(cpu_dataout_16),
.dataout_8(cpu_dataout_8),
.datain_32(cpu_datain_32),
.datain_8(cpu_datain_8),
.datain_16(cpu_datain_16),
.addr_out(pc),
.ena(dmem_ena),
.WR(WR),
.w(w),
.ALUdataout(dmem_addr),
.IM_R(IM_R),
//CP0
.exc_addr(exc_addr),
.CP0_datain(rdata),
.eret_instrc(eret_instrc),
.mfc0_instrc(mfc0_instrc),
.mtc0_instrc(mtc0_instrc),
.NPC_out(CP0_pc),
.Rt(wdata),
.Rdc_CP0(Rdc_CP0),
.cause(cause),
.exception(exception)
);

wire [31:0] dmem_addr_in;
assign dmem_addr_in = (dmem_addr-32'h10010000);
DMEM dmem(
.clk(clk_in),
.ena(dmem_ena),
.WR(WR),
.w(w),
.addr(dmem_addr_in),
.datain_32(cpu_dataout_32),
.datain_16(cpu_dataout_16),
.datain_8(cpu_dataout_8),
.dataout_32(cpu_datain_32),
.dataout_16(cpu_datain_16),
.dataout_8(cpu_datain_8)
);

IMEM imem(
.IM_R(IM_R),
.addr(pc_in[12:2]),
.data_out(inst)
);

CP0 cp0(
.clk(clk_in),
.rst(reset),
.mfc0(mfc0_instrc),
.mtc0(mtc0_instrc),
.eret(eret_instrc),
.pc(CP0_pc),
.Rd(Rdc_CP0),
.wdata(wdata),
.exception(exception),
.cause(cause),
.rdata(rdata),
.exc_addr(exc_addr)
);

endmodule
