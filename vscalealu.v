module vscalealu64 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 3:0] din_mode,
	input  [63:0] din_arg1,
	input  [63:0] din_arg2,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	vscalealu_xlen #(
		.XPR_LEN(64),
		.SHAMT_WIDTH(6)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_arg1    (din_arg1   ),
		.din_arg2    (din_arg2   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module vscalealu32 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 3:0] din_mode,
	input  [31:0] din_arg1,
	input  [31:0] din_arg2,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	vscalealu_xlen #(
		.XPR_LEN(32),
		.SHAMT_WIDTH(5)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_arg1    (din_arg1   ),
		.din_arg2    (din_arg2   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module vscalealu_xlen #(
	parameter integer XPR_LEN = 32,
	parameter integer SHAMT_WIDTH = 5
) (
	input                    clock,
	input                    reset,

	input                    din_valid,
	output                   din_ready,
	input      [        3:0] din_mode,
	input      [XPR_LEN-1:0] din_arg1,
	input      [XPR_LEN-1:0] din_arg2,

	output reg               dout_valid,
	input                    dout_ready,
	output reg [XPR_LEN-1:0] dout_result
);
	wire [XPR_LEN-1:0] result;

	vscale_alu #(
		.XPR_LEN(XPR_LEN),
		.SHAMT_WIDTH(SHAMT_WIDTH)
	) core (
		.op    (din_mode ),
		.in1   (din_arg1 ),
		.in2   (din_arg2 ),
		.out   (result   )
	);

	assign din_ready = !reset && !(dout_valid && !dout_ready);

	always @(posedge clock) begin
		if (reset) begin
			dout_valid <= 0;
		end else
		if (din_valid && din_ready) begin
			dout_valid <= din_valid;
			dout_result <= result;
		end else
		if (dout_ready) begin
			dout_valid <= 0;
		end
	end
endmodule


// ==============================================================================
// V-Scale ALU implementation from
// https://github.com/ucb-bar/vscale/blob/master/src/main/verilog/vscale_alu.v

`define XPR_LEN      XPR_LEN
`define SHAMT_WIDTH  SHAMT_WIDTH

`define ALU_OP_WIDTH 4
`define ALU_OP_ADD  `ALU_OP_WIDTH'd0
`define ALU_OP_SLL  `ALU_OP_WIDTH'd1
`define ALU_OP_XOR  `ALU_OP_WIDTH'd4
`define ALU_OP_OR   `ALU_OP_WIDTH'd6
`define ALU_OP_AND  `ALU_OP_WIDTH'd7
`define ALU_OP_SRL  `ALU_OP_WIDTH'd5
`define ALU_OP_SEQ  `ALU_OP_WIDTH'd8
`define ALU_OP_SNE  `ALU_OP_WIDTH'd9
`define ALU_OP_SUB  `ALU_OP_WIDTH'd10
`define ALU_OP_SRA  `ALU_OP_WIDTH'd11
`define ALU_OP_SLT  `ALU_OP_WIDTH'd12
`define ALU_OP_SGE  `ALU_OP_WIDTH'd13
`define ALU_OP_SLTU `ALU_OP_WIDTH'd14
`define ALU_OP_SGEU `ALU_OP_WIDTH'd15

module vscale_alu #(
	parameter integer XPR_LEN = 32,
	parameter integer SHAMT_WIDTH = 6
) (
	input [`ALU_OP_WIDTH-1:0] op,
	input [`XPR_LEN-1:0]      in1,
	input [`XPR_LEN-1:0]      in2,
	output reg [`XPR_LEN-1:0] out
);
	wire [`SHAMT_WIDTH-1:0] shamt;

	assign shamt = in2[`SHAMT_WIDTH-1:0];

	always @(*) begin
		case (op)
			`ALU_OP_ADD : out = in1 + in2;
			`ALU_OP_SLL : out = in1 << shamt;
			`ALU_OP_XOR : out = in1 ^ in2;
			`ALU_OP_OR : out = in1 | in2;
			`ALU_OP_AND : out = in1 & in2;
			`ALU_OP_SRL : out = in1 >> shamt;
			`ALU_OP_SEQ : out = {31'b0, in1 == in2};
			`ALU_OP_SNE : out = {31'b0, in1 != in2};
			`ALU_OP_SUB : out = in1 - in2;
			`ALU_OP_SRA : out = $signed(in1) >>> shamt;
			`ALU_OP_SLT : out = {31'b0, $signed(in1) < $signed(in2)};
			`ALU_OP_SGE : out = {31'b0, $signed(in1) >= $signed(in2)};
			`ALU_OP_SLTU : out = {31'b0, in1 < in2};
			`ALU_OP_SGEU : out = {31'b0, in1 >= in2};
			default : out = 0;
		endcase // case op
	end
endmodule // vscale_alu

