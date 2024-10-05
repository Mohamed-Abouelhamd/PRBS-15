`timescale 1ns/100ps
module Top_TB;

wire [7:0] Byte_out;
wire pattern_valid;
reg [7:0] n;
reg [31:0] bytes_in, pattern;
reg clk, rst, enable; 

localparam  T = 20,
	   		N = 2,
	   		Pattern1 = 32'h3ACF491E,
			Pattern2 = 32'h4DF1A98B;

Top Top_uut (
	.Byte_out(Byte_out),
	.pattern_valid(pattern_valid),
	.n(n),
	.bytes_in(bytes_in),
	.pattern(pattern),
	.clk(clk), 
	.rst(rst), 
	.enable(enable) 
);

always #(T/2) clk = ~clk; 

initial 
	begin
		clk = 0;
		rst = 0;
		enable = 1;
		n = N;
		pattern = Pattern1;
		bytes_in = Pattern1;	
		#T;
		rst = 1;
		$display("Checking the pattern %h",Pattern1);
		repeat(N)
			begin
				#(4*T);
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(4*T);
		rst = 0;
		#T;
		rst =1;
		bytes_in = Pattern2;
		$display("Checking the pattern %h",Pattern2);
		repeat(N)
			begin
				#(4*T);
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(4*T);
		$stop;
	end

endmodule 