module Top (
output [7:0] Byte_out,
output pattern_valid,
input [7:0] n,
input [31:0] bytes_in, pattern,
input clk, rst, enable 
);

PRBS_15 U0(
	.Byte_out(Byte_out),
	.bytes_in(bytes_in),
	.n(n),
	.clk(clk), 
	.rst(rst), 
	.enable(enable)
);

Pattern_Detector U1(
	.pattern_valid(pattern_valid),
	.pattern(pattern), 
	.byte_in(Byte_out),
	.n(n),
	.rst(rst), 
	.clk(clk), 
	.enable(enable)
);
endmodule 
