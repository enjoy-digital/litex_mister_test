module cos (
	input   [9:0] x,
	output  [7:0] y
);

reg [7:0] qcos[0:255];
initial begin
	$readmemh("cos.init", qcos);
end

wire ival = ^x[9:8];
assign y = qcos[x[7:0] ^ {8{x[8]}}] ^ {~ival,{7{ival}}};

endmodule

