module Pattern_Detector (
output pattern_valid,
input [31:0] pattern, 
input [7:0] byte_in,
input [7:0] n,
input rst, clk, enable
);

wire true_byte, start, equal, enable_fsm;
wire [1:0] byte_num;
wire [7:0] seq_num;

Byte_Comp U0(
	.true_byte(true_byte), 
	.start(start),
	.pattern(pattern),
	.byte_num(byte_num),
	.byte_in(byte_in),
	.clk(clk), 
	.rst(rst), 
	.enable(enable & enable_fsm)
);

Byte_Counter U1(
	.byte_num(byte_num),
	.rst(rst), 
	.clk(clk), 
	.enable(enable & enable_fsm & start)
);

Seq_Counter U2(
	.seq_num(seq_num),
	.byte_num(byte_num),
	.clk(clk), 
	.rst(rst), 
	.enable(enable & enable_fsm)
);

FSM U4(
	.pattern_valid(pattern_valid), 
	.enable(enable_fsm),
	.true_byte(true_byte), 
	.byte_num(byte_num),
	.seq_num(seq_num), 
	.n(n),
	.start(start),
	.equal(), 
	.clk(clk), 
	.rst(rst)
); 
endmodule 
