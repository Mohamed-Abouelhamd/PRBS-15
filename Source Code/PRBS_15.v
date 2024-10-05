module PRBS_15(
output [7:0] Byte_out,
input [31:0] bytes_in,
input [7:0] n,
input clk, rst, enable
);
wire equal;
wire [1:0] byte_num;
wire [7:0] seq_num;
wire [7:0] ser_byte, LFSR_byte;

Byte_Counter U0 (
	.byte_num(byte_num), 
	.rst(rst), 
	.clk(clk), 
	.enable(enable & ~equal)
);

Seq_Counter U1(
	.seq_num (seq_num),
	.byte_num(byte_num),
	.clk(clk), 
	.rst(rst), 
	.enable(enable & ~equal)
);

Byte_Ser U2(
	.ser_byte(ser_byte), 
	.bytes_in(bytes_in), 
	.byte_num(byte_num),
	.clk(clk), 
	.rst(rst), 
	.enable(enable & ~equal)
);

LFSR U3(
	.Byte(LFSR_byte),
	.clk(clk), 
	.rst(rst), 
	.enable(enable & equal)
);

Mux_2X1 U4(
	.mux_out(Byte_out),
	.in0(ser_byte), 
	.in1(LFSR_byte),
	.sel(equal) 
);

Comparator U5(
	.comp(equal),
	.in1(n), 
	.in2(seq_num),
	.clk(clk), 
	.rst(rst)
); 

endmodule 