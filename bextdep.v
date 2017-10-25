/*
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

`define bextdep_butterfly_idx_a(k, i) ((2 << (k))*((i)/(1 << (k))) + (i)%(1 << (k)))
`define bextdep_butterfly_idx_b(k, i) (`bextdep_butterfly_idx_a(k, i) + (1<<(k)))

// ========================================================================

module bextdep64g3 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(64),
		.FFS(3)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64p3 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(64),
		.FFS(3)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64g2 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(64),
		.FFS(2)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64p2 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(64),
		.FFS(2)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64g1 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(64),
		.FFS(1)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64p1 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(64),
		.FFS(1)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32g3 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(32),
		.FFS(3)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32p3 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(32),
		.FFS(3)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32g2 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(32),
		.FFS(2)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32p2 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(32),
		.FFS(2)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32g1 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(1),
		.XLEN(32),
		.FFS(1)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32p1 (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_pipeline #(
		.GREV(0),
		.XLEN(32),
		.FFS(1)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep_xlen_pipeline #(
	parameter integer GREV = 1,
	parameter integer XLEN = 32,
	parameter integer FFS = 1
) (
	input                 clock,
	input                 reset,

	input                 din_valid,
	output                din_ready,
	input      [     1:0] din_mode,
	input      [XLEN-1:0] din_value,
	input      [XLEN-1:0] din_mask,

	output reg            dout_valid,
	input                 dout_ready,
	output reg [XLEN-1:0] dout_result
);
	wire [XLEN/2-1:0] decoder_s1, decoder_s2, decoder_s4;
	wire [XLEN/2-1:0] decoder_s8, decoder_s16, decoder_s32;
	wire decoder_en;

	bextdep_decoder #(
		.XLEN(XLEN),
		.FFSTAGE(FFS == 3)
	) decoder (
		.clock (clock      ),
		.enable(decoder_en ),
		.mask  (din_mask   ),
		.s1    (decoder_s1 ),
		.s2    (decoder_s2 ),
		.s4    (decoder_s4 ),
		.s8    (decoder_s8 ),
		.s16   (decoder_s16),
		.s32   (decoder_s32)
	);

	reg valid_t;
	reg [1:0] din_mode_t;
	reg [XLEN-1:0] din_value_t, din_mask_t;

	reg valid_r;
	reg [1:0] din_mode_r;
	reg [XLEN-1:0] din_value_r, din_mask_r;
	reg [XLEN/2-1:0] decoder_s1_r, decoder_s2_r, decoder_s4_r;
	reg [XLEN/2-1:0] decoder_s8_r, decoder_s16_r, decoder_s32_r;

	generate
		if (FFS == 3) begin
			assign decoder_en = !dout_valid || dout_ready || !valid_t || !valid_r;
			always @(posedge clock) begin
				if (decoder_en) begin
					valid_t <= din_valid && din_ready;
					din_mode_t <= din_mode;
					din_value_t <= din_value;
					din_mask_t <= din_mask;
				end
				if (!dout_valid || dout_ready || !valid_r) begin
					valid_r <= valid_t;
					din_mode_r <= din_mode_t;
					din_value_r <= din_value_t;
					din_mask_r <= din_mask_t;
					decoder_s1_r <= decoder_s1;
					decoder_s2_r <= decoder_s2;
					decoder_s4_r <= decoder_s4;
					decoder_s8_r <= decoder_s8;
					decoder_s16_r <= decoder_s16;
					decoder_s32_r <= decoder_s32;
				end
				if (reset) begin
					valid_t <= 0;
					valid_r <= 0;
				end
			end
		end else
		if (FFS == 2) begin
			always @(posedge clock) begin
				if (!dout_valid || dout_ready || !valid_r) begin
					valid_r <= din_valid && din_ready;
					din_mode_r <= din_mode;
					din_value_r <= din_value;
					din_mask_r <= din_mask;
					decoder_s1_r <= decoder_s1;
					decoder_s2_r <= decoder_s2;
					decoder_s4_r <= decoder_s4;
					decoder_s8_r <= decoder_s8;
					decoder_s16_r <= decoder_s16;
					decoder_s32_r <= decoder_s32;
				end
				if (reset) begin
					valid_r <= 0;
				end
			end
		end else begin
			always @* begin
				valid_r = !reset && din_valid && din_ready;
				din_mode_r = din_mode;
				din_value_r = din_value;
				din_mask_r = din_mask;
				decoder_s1_r = decoder_s1;
				decoder_s2_r = decoder_s2;
				decoder_s4_r = decoder_s4;
				decoder_s8_r = decoder_s8;
				decoder_s16_r = decoder_s16;
				decoder_s32_r = decoder_s32;
			end
		end
	endgenerate

	wire [XLEN-1:0] result_fwd;
	wire [XLEN-1:0] result_bwd;

	bextdep_butterfly_fwd #(
		.XLEN(XLEN)
	) butterfly_fwd (
		.din  (din_value_r   ),
		.s1   (~decoder_s1_r ),
		.s2   (~decoder_s2_r ),
		.s4   (~decoder_s4_r ),
		.s8   (~decoder_s8_r ),
		.s16  (~decoder_s16_r),
		.s32  (~decoder_s32_r),
		.dout (result_fwd    )
	);

	bextdep_butterfly_bwd #(
		.XLEN(XLEN)
	) butterfly_bwd (
		.din  ((GREV && din_mode_r[1]) ? din_value_r : (din_value_r & din_mask_r)),
		.s1   ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[0]}} : ~decoder_s1_r ),
		.s2   ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[1]}} : ~decoder_s2_r ),
		.s4   ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[2]}} : ~decoder_s4_r ),
		.s8   ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[3]}} : ~decoder_s8_r ),
		.s16  ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[4]}} : ~decoder_s16_r),
		.s32  ((GREV && din_mode_r[1]) ? {XLEN/2{din_mask_r[5]}} : ~decoder_s32_r),
		.dout (result_bwd)
	);

	assign din_ready = !reset && ((FFS > 2 && !valid_t) || (FFS > 1 && !valid_r) || !dout_valid || dout_ready);

	always @(posedge clock) begin
		if (reset) begin
			dout_valid <= 0;
		end else
		if (FFS > 1 && valid_r && dout_valid && !dout_ready) begin
			// stall
		end else
		if (valid_r) begin
			dout_valid <= 1;
			dout_result <= din_mode_r[0] ? (result_fwd & din_mask_r) : result_bwd;
		end else
		if (dout_ready) begin
			dout_valid <= 0;
		end
	end
endmodule

// ========================================================================

module bextdep64sh (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_seq #(
		.XLEN(64),
		.STEPS(4)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64sb (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_seq #(
		.XLEN(64),
		.STEPS(8)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep64sn (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_seq #(
		.XLEN(64),
		.STEPS(16)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32sb (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_seq #(
		.XLEN(32),
		.STEPS(4)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32sn (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_seq #(
		.XLEN(32),
		.STEPS(8)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep_xlen_seq #(
	parameter integer XLEN = 32,
	parameter integer STEPS = 2
) (
	input                 clock,
	input                 reset,

	input                 din_valid,
	output                din_ready,
	input      [     1:0] din_mode,
	input      [XLEN-1:0] din_value,
	input      [XLEN-1:0] din_mask,

	output                dout_valid,
	input                 dout_ready,
	output     [XLEN-1:0] dout_result
);
	localparam integer SUMBITS =
		XLEN/STEPS == 32 ? 6 :
		XLEN/STEPS == 16 ? 5 :
		XLEN/STEPS ==  8 ? 4 :
		XLEN/STEPS ==  4 ? 3 : 'bx;

	localparam integer STEPBITS =
		STEPS == 16 ? 5 :
		STEPS ==  8 ? 4 :
		STEPS ==  4 ? 3 :
		STEPS ==  2 ? 2 : 'bx;

	reg running;
	reg mode_bdep;
	reg [STEPBITS-1:0] stepcnt;
	reg [XLEN-1:0] buffer_a;
	reg [XLEN-1:0] buffer_b;
	reg [XLEN-1:0] buffer_c;

	wire [XLEN/STEPS-1:0] direct_value;
	wire [XLEN/STEPS-1:0] direct_mask;
	wire [XLEN/STEPS-1:0] direct_result;
	wire [SUMBITS-1:0] direct_sum;

	function [XLEN-1:0] xlen_reverse;
		input [XLEN-1:0] v;
		integer i;
		begin
			for (i = 0; i < XLEN; i = i+1)
				xlen_reverse[i] = v[XLEN-i-1];
		end
	endfunction

	function [XLEN/STEPS-1:0] step_reverse;
		input [XLEN/STEPS-1:0] v;
		integer i;
		begin
			for (i = 0; i < XLEN/STEPS; i = i+1)
				step_reverse[i] = v[XLEN/STEPS-i-1];
		end
	endfunction

	assign direct_value = mode_bdep ? step_reverse(buffer_c[XLEN-1 -: XLEN/STEPS]) : buffer_a[XLEN-1 -: XLEN/STEPS];
	assign direct_mask = mode_bdep ? step_reverse(buffer_b[XLEN-1 -: XLEN/STEPS]) : buffer_b[XLEN-1 -: XLEN/STEPS];

	bextdep_direct #(
		.XLEN(XLEN / STEPS),
		.SUMBITS(SUMBITS)
	) direct (
		.din_mode    (mode_bdep     ),
		.din_value   (direct_value  ),
		.din_mask    (direct_mask   ),
		.dout_result (direct_result ),
		.dout_sum    (direct_sum    )
	);

	always @(posedge clock) begin
		stepcnt <= stepcnt - |stepcnt;

		if (dout_valid && dout_ready) begin
			running <= 0;
		end

		if (reset) begin
			running <= 0;
		end else
		if (din_valid && din_ready) begin
			running <= 1;
			stepcnt <= STEPS;
			mode_bdep <= din_mode[0];
			if (din_mode[0]) begin
				buffer_b <= xlen_reverse(din_mask);
				buffer_c <= xlen_reverse(din_value);
			end else begin
				buffer_a <= din_value;
				buffer_b <= din_mask;
				buffer_c <= 0;
			end
		end else
		if (stepcnt) begin
			buffer_a <= {buffer_a, step_reverse(direct_result)};
			buffer_b <= buffer_b << (XLEN/STEPS);
			buffer_c <= (buffer_c << direct_sum) | direct_result;
		end
	end

	assign din_ready = !running || (dout_valid && dout_ready);
	assign dout_valid = running && !stepcnt;
	assign dout_result = mode_bdep ? xlen_reverse(buffer_a) : buffer_c;
endmodule

module bextdep_direct #(
	parameter integer XLEN = 32,
	parameter integer SUMBITS = 8
) (
	input                    din_mode,
	input      [   XLEN-1:0] din_value,
	input      [   XLEN-1:0] din_mask,
	output     [   XLEN-1:0] dout_result,
	output     [SUMBITS-1:0] dout_sum
);
	wire [XLEN/2-1:0] decoder_s1, decoder_s2, decoder_s4;
	wire [XLEN/2-1:0] decoder_s8, decoder_s16, decoder_s32;
	wire [7:0] decoder_sum;

	bextdep_decoder #(
		.XLEN(XLEN),
		.FFSTAGE(0)
	) decoder (
		.mask  (din_mask   ),
		.s1    (decoder_s1 ),
		.s2    (decoder_s2 ),
		.s4    (decoder_s4 ),
		.s8    (decoder_s8 ),
		.s16   (decoder_s16),
		.s32   (decoder_s32),
		.sum   (decoder_sum)
	);

	wire [XLEN-1:0] result_fwd;
	wire [XLEN-1:0] result_bwd;

	bextdep_butterfly_fwd #(
		.XLEN(XLEN)
	) butterfly_fwd (
		.din  (din_value   ),
		.s1   (~decoder_s1 ),
		.s2   (~decoder_s2 ),
		.s4   (~decoder_s4 ),
		.s8   (~decoder_s8 ),
		.s16  (~decoder_s16),
		.s32  (~decoder_s32),
		.dout (result_fwd  )
	);

	bextdep_butterfly_bwd #(
		.XLEN(XLEN)
	) butterfly_bwd (
		.din  (din_value & din_mask),
		.s1   (~decoder_s1 ),
		.s2   (~decoder_s2 ),
		.s4   (~decoder_s4 ),
		.s8   (~decoder_s8 ),
		.s16  (~decoder_s16),
		.s32  (~decoder_s32),
		.dout (result_bwd  )
	);

	assign dout_result = din_mode ? (result_fwd & din_mask) : result_bwd;
	assign dout_sum = decoder_sum;
endmodule

// ========================================================================

module bextdep64sx (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_sx #(
		.XLEN(64)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32sx (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_sx #(
		.XLEN(32)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep_xlen_sx #(
	parameter integer XLEN = 32
) (
	input                 clock,
	input                 reset,

	input                 din_valid,
	output                din_ready,
	input      [     1:0] din_mode,
	input      [XLEN-1:0] din_value,
	input      [XLEN-1:0] din_mask,

	output                dout_valid,
	input                 dout_ready,
	output     [XLEN-1:0] dout_result
);
	reg bdep, running, ready;
	reg [XLEN-1:0] c, m, msk, val;
	wire [XLEN-1:0] b = msk & -msk;

	assign din_ready = !running || (dout_valid && dout_ready);
	assign dout_valid = running && ready;
	assign dout_result = c;

	always @(posedge clock) begin
		if (dout_valid && dout_ready) begin
			running <= 0;
			ready <= 0;
		end

		if (reset) begin
			running <= 0;
			ready <= 0;
		end else
		if (din_valid && din_ready) begin
			c <= 0;
			m <= 1;
			running <= 1;
			ready <= 0;
			bdep <= din_mode[0];
			val <= din_value;
			msk <= din_mask;
		end else
		if (running && !ready) begin
			if (val & (bdep ? m : b))
				c <= c | (bdep ? b : m);
			msk <= msk & ~b;
			ready <= !(msk & ~b);
			m <= m << 1;
		end
	end
endmodule

// ========================================================================

module bextdep64go (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [63:0] din_value,
	input  [63:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [63:0] dout_result
);
	bextdep_xlen_go #(
		.XLEN(64),
		.MAXK(6),
		.MAXI(32)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep32go (
	input         clock,
	input         reset,

	input         din_valid,
	output        din_ready,
	input  [ 1:0] din_mode,
	input  [31:0] din_value,
	input  [31:0] din_mask,

	output        dout_valid,
	input         dout_ready,
	output [31:0] dout_result
);
	bextdep_xlen_go #(
		.XLEN(32),
		.MAXK(5),
		.MAXI(16)
	) core (
		.clock       (clock      ),
		.reset       (reset      ),
		.din_valid   (din_valid  ),
		.din_ready   (din_ready  ),
		.din_mode    (din_mode   ),
		.din_value   (din_value  ),
		.din_mask    (din_mask   ),
		.dout_valid  (dout_valid ),
		.dout_ready  (dout_ready ),
		.dout_result (dout_result)
	);
endmodule

module bextdep_xlen_go #(
	parameter integer XLEN = 32,
	parameter integer MAXK = 5,
	parameter integer MAXI = 16
) (
	input                 clock,
	input                 reset,

	input                 din_valid,
	output                din_ready,
	input      [     1:0] din_mode,
	input      [XLEN-1:0] din_value,
	input      [XLEN-1:0] din_mask,

	output reg            dout_valid,
	input                 dout_ready,
	output reg [XLEN-1:0] dout_result
);
	reg [XLEN-1:0] butterfly;

	integer k, i;
	always @* begin
		butterfly = din_value;

		for (k = 0; k < MAXK; k = k+1)
		for (i = 0; i < MAXI; i = i+1)
			if (din_mask[k]) {butterfly[`bextdep_butterfly_idx_a(k, i)], butterfly[`bextdep_butterfly_idx_b(k, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(k, i)], butterfly[`bextdep_butterfly_idx_a(k, i)]};
	end

	assign din_ready = !reset && !(dout_valid && !dout_ready);

	always @(posedge clock) begin
		if (reset) begin
			dout_valid <= 0;
		end else
		if (din_valid && din_ready) begin
			dout_valid <= din_valid;
			dout_result <= butterfly;
		end else
		if (dout_ready) begin
			dout_valid <= 0;
		end
	end
endmodule

// ========================================================================

module bextdep_lrotcz #(
	parameter integer N = 1,
	parameter integer M = 1
) (
	input [7:0] din,
	output [M-1:0] dout
);
	wire [2*M-1:0] mask = {M{1'b1}};
	assign dout = (mask << din[N-1:0]) >> M;
endmodule

module bextdep_decoder #(
	parameter integer XLEN = 32,
	parameter integer FFSTAGE = 1
) (
	input clock,
	input enable,
	input [XLEN-1:0] mask,
	output [XLEN/2-1:0] s1, s2, s4, s8, s16, s32,
	output [7:0] sum
);
	wire [8*XLEN-1:0] ppsdata;

	assign sum = ppsdata[8*(XLEN-1) +: 8];

	generate
		if (XLEN == 4 && !FFSTAGE) begin:pps4
			bextdep_pps4 pps_core (
				.din  (mask),
				.dout (ppsdata)
			);
		end
		if (XLEN == 8 && !FFSTAGE) begin:pps8
			bextdep_pps8 pps_core (
				.din  (mask),
				.dout (ppsdata)
			);
		end
		if (XLEN == 16 && !FFSTAGE) begin:pps16
			bextdep_pps16 pps_core (
				.din  (mask),
				.dout (ppsdata)
			);
		end
		if (XLEN == 32 && !FFSTAGE) begin:pps32
			bextdep_pps32 pps_core (
				.din  (mask),
				.dout (ppsdata)
			);
		end
		if (XLEN == 64 && !FFSTAGE) begin:pps64
			bextdep_pps64 pps_core (
				.din  (mask),
				.dout (ppsdata)
			);
		end
		if (XLEN == 32 && FFSTAGE) begin:pps32f
			bextdep_pps32f pps_core (
				.clock (clock),
				.enable(enable),
				.din   (mask),
				.dout  (ppsdata)
			);
		end
		if (XLEN == 64 && FFSTAGE) begin:pps64f
			bextdep_pps64f pps_core (
				.clock (clock),
				.enable(enable),
				.din   (mask),
				.dout  (ppsdata)
			);
		end
	endgenerate

	genvar i;
	generate
		for (i = 0; i < XLEN/2; i = i+1) begin:stage1
			bextdep_lrotcz #(.N(1), .M(1)) lrotc_zero (
				.din(ppsdata[8*(2*i + 1 - 1) +: 8]),
				.dout(s1[i])
			);
		end

		for (i = 0; i < XLEN/4; i = i+1) begin:stage2
			bextdep_lrotcz #(.N(2), .M(2)) lrotc_zero (
				.din(ppsdata[8*(4*i + 2 - 1) +: 8]),
				.dout(s2[2*i +: 2])
			);
		end

		for (i = 0; i < XLEN/8; i = i+1) begin:stage4
			bextdep_lrotcz #(.N(3), .M(4)) lrotc_zero (
				.din(ppsdata[8*(8*i + 4 - 1) +: 8]),
				.dout(s4[4*i +: 4])
			);
		end

		for (i = 0; i < XLEN/16; i = i+1) begin:stage8
			bextdep_lrotcz #(.N(4), .M(8)) lrotc_zero (
				.din(ppsdata[8*(16*i + 8 - 1) +: 8]),
				.dout(s8[8*i +: 8])
			);
		end

		for (i = 0; i < XLEN/32; i = i+1) begin:stage16
			bextdep_lrotcz #(.N(5), .M(16)) lrotc_zero (
				.din(ppsdata[8*(32*i + 16 - 1) +: 8]),
				.dout(s16[16*i +: 16])
			);
		end

		for (i = 0; i < XLEN/64; i = i+1) begin:stage32
			bextdep_lrotcz #(.N(6), .M(32)) lrotc_zero (
				.din(ppsdata[8*(64*i + 32 - 1) +: 8]),
				.dout(s32[32*i +: 32])
			);
		end
	endgenerate
endmodule

module bextdep_butterfly_fwd #(
	parameter integer XLEN = 32,
	parameter integer FFSTAGE = 1
) (
	input [XLEN-1:0] din,
	input [XLEN/2-1:0] s1, s2, s4, s8, s16, s32,
	output [XLEN-1:0] dout
);
	reg [XLEN-1:0] butterfly;
	assign dout = butterfly;

	integer k, i;
	always @* begin
		butterfly = din;

		if (64 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s32[i]) {butterfly[`bextdep_butterfly_idx_a(5, i)], butterfly[`bextdep_butterfly_idx_b(5, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(5, i)], butterfly[`bextdep_butterfly_idx_a(5, i)]};
		end

		if (32 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s16[i]) {butterfly[`bextdep_butterfly_idx_a(4, i)], butterfly[`bextdep_butterfly_idx_b(4, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(4, i)], butterfly[`bextdep_butterfly_idx_a(4, i)]};
		end

		if (16 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s8[i]) {butterfly[`bextdep_butterfly_idx_a(3, i)], butterfly[`bextdep_butterfly_idx_b(3, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(3, i)], butterfly[`bextdep_butterfly_idx_a(3, i)]};
		end

		for (i = 0; i < XLEN/2; i = i+1)
			if (s4[i]) {butterfly[`bextdep_butterfly_idx_a(2, i)], butterfly[`bextdep_butterfly_idx_b(2, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(2, i)], butterfly[`bextdep_butterfly_idx_a(2, i)]};

		for (i = 0; i < XLEN/2; i = i+1)
			if (s2[i]) {butterfly[`bextdep_butterfly_idx_a(1, i)], butterfly[`bextdep_butterfly_idx_b(1, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(1, i)], butterfly[`bextdep_butterfly_idx_a(1, i)]};

		for (i = 0; i < XLEN/2; i = i+1)
			if (s1[i]) {butterfly[`bextdep_butterfly_idx_a(0, i)], butterfly[`bextdep_butterfly_idx_b(0, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(0, i)], butterfly[`bextdep_butterfly_idx_a(0, i)]};
	end
endmodule

module bextdep_butterfly_bwd #(
	parameter integer XLEN = 32,
	parameter integer FFSTAGE = 1
) (
	input [XLEN-1:0] din,
	input [XLEN/2-1:0] s1, s2, s4, s8, s16, s32,
	output [XLEN-1:0] dout
);
	reg [XLEN-1:0] butterfly;
	assign dout = butterfly;

	integer k, i;
	always @* begin
		butterfly = din;

		for (i = 0; i < XLEN/2; i = i+1)
			if (s1[i]) {butterfly[`bextdep_butterfly_idx_a(0, i)], butterfly[`bextdep_butterfly_idx_b(0, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(0, i)], butterfly[`bextdep_butterfly_idx_a(0, i)]};

		for (i = 0; i < XLEN/2; i = i+1)
			if (s2[i]) {butterfly[`bextdep_butterfly_idx_a(1, i)], butterfly[`bextdep_butterfly_idx_b(1, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(1, i)], butterfly[`bextdep_butterfly_idx_a(1, i)]};

		for (i = 0; i < XLEN/2; i = i+1)
			if (s4[i]) {butterfly[`bextdep_butterfly_idx_a(2, i)], butterfly[`bextdep_butterfly_idx_b(2, i)]} =
						{butterfly[`bextdep_butterfly_idx_b(2, i)], butterfly[`bextdep_butterfly_idx_a(2, i)]};

		if (16 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s8[i]) {butterfly[`bextdep_butterfly_idx_a(3, i)], butterfly[`bextdep_butterfly_idx_b(3, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(3, i)], butterfly[`bextdep_butterfly_idx_a(3, i)]};
		end

		if (32 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s16[i]) {butterfly[`bextdep_butterfly_idx_a(4, i)], butterfly[`bextdep_butterfly_idx_b(4, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(4, i)], butterfly[`bextdep_butterfly_idx_a(4, i)]};
		end

		if (64 <= XLEN) begin
			for (i = 0; i < XLEN/2; i = i+1)
				if (s32[i]) {butterfly[`bextdep_butterfly_idx_a(5, i)], butterfly[`bextdep_butterfly_idx_b(5, i)]} =
							{butterfly[`bextdep_butterfly_idx_b(5, i)], butterfly[`bextdep_butterfly_idx_a(5, i)]};
		end
	end
endmodule

