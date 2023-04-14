`timescale 1 ps / 1 ps
module pll (
		input  wire  refclk,
		input  wire  rst,
		output wire  outclk_0,
		output wire  locked
	);

	assign outclk_0 = refclk;
	assign locked   = 1'b1;

endmodule
