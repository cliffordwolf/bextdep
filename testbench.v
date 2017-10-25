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

module testbench;
	reg clock;

	reg reset = 1;
	initial @(posedge clock) reset <= 0;

	wire                din_valid;
	wire                din_ready;
	wire [         1:0] din_mode;
	wire [`TB_XLEN-1:0] din_value;
	wire [`TB_XLEN-1:0] din_mask;
	wire                dout_valid;
	wire                dout_ready;
	wire [`TB_XLEN-1:0] dout_result;

	`TB_UUT uut (
		.clock      (clock      ),
		.reset      (reset      ),
		.din_valid  (din_valid  ),
		.din_ready  (din_ready  ),
		.din_mode   (din_mode   ),
		.din_value  (din_value  ),
		.din_mask   (din_mask   ),
		.dout_valid (dout_valid ),
		.dout_ready (dout_ready ),
		.dout_result(dout_result)
	);

	reg [3*`TB_XLEN+4-1:0] testdata [0:1023];

	initial begin
		$dumpfile("testbench.vcd");
		$dumpvars(0, testbench);
		$readmemh(`TB_TESTDATA, testdata);
		#5 clock = 0;
		forever #5 clock = !clock;
	end

	integer din_count = 0;
	integer dout_count = 0;

	reg rand_din_valid = 0;
	reg rand_dout_ready = 0;

	assign din_valid = din_count < 1024 && (din_count < 128 || rand_din_valid);
	assign dout_ready = dout_count < 1024 && (dout_count < 128 || rand_dout_ready);

	assign din_value = testdata[din_count][0 +: `TB_XLEN];
	assign din_mask = testdata[din_count][`TB_XLEN +: `TB_XLEN];
	wire [`TB_XLEN-1:0] dout_expected = testdata[dout_count][2*`TB_XLEN +: `TB_XLEN];
	assign din_mode = testdata[din_count][3*`TB_XLEN +: 4];

	integer depth_state = 0;
	integer depth = 0;

	integer current_ii = 0;
	integer max_ii = 0;
	integer sum_ii = 0;

	always @(posedge clock) begin
		rand_din_valid <= ($random >> 20) & 1;
		rand_dout_ready <= ($random >> 20) & 1;
		if (!reset && !din_ready) begin
			current_ii <= current_ii + 1;
		end
		if (!reset && din_valid && din_ready && depth_state == 0) begin
			depth_state <= 1;
		end
		if (!reset && depth_state == 1) begin
			depth <= depth + 1;
		end
		if (!reset && dout_valid && dout_ready) begin
			depth_state <= 2;
		end
		if (!reset && din_valid && din_ready) begin
			if (0 < din_count && din_count <= 100) begin
				if (current_ii > max_ii)
					max_ii <= current_ii;
				sum_ii <= sum_ii + current_ii;
			end
			current_ii <= 1;
			din_count <= din_count + 1;
		end
		if (!reset && dout_valid && dout_ready) begin
			if (dout_result == dout_expected) begin
				if (dout_count % 64 == 63) begin
					$display(".");
				end else begin
					$write(".");
					$fflush;
				end
				// $display("%4d: %x OK", dout_count, dout_result);
			end else begin
				$display("%4d: %x ERROR (expected %x)", dout_count, dout_result, dout_expected);
				$stop;
			end
			dout_count <= dout_count + 1;
		end
		if (din_count == 1024 && dout_count == 1024) begin
			$display("PASSED (Max II=%1d, Avg II=%.2f, Depth=%1d)", max_ii, sum_ii / 100.0, depth);
			$finish;
		end
	end
endmodule
