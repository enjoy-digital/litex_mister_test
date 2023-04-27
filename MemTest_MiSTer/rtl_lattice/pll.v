`timescale 1 ps / 1 ps
module pll (
		input  wire  refclk,
		input  wire  rst,
		output reg   outclk_0,
		output wire  locked
	);

	reg [1:0] refclk_div;

	always @(posedge refclk)
	begin
 		refclk_div = refclk_div + 1'b1;
	end

	assign outclk_0 = refclk_div[1];
	assign locked   = 1'b1;

endmodule
