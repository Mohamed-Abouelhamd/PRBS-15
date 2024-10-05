`timescale 1ns/100ps
module Pattern_Detector_TB;

wire pattern_valid;
reg [31:0] pattern;
reg [7:0] byte_in;
reg [7:0] n;
reg rst, clk, enable;

localparam  T = 20,
	   		N = 4,
	   		Pattern = 32'h3ACF491E;

Pattern_Detector Pattern_Detector_uut(
	.pattern_valid(pattern_valid),
	.pattern(pattern), 
	.byte_in(byte_in),
	.n(n),
	.rst(rst), 
	.clk(clk), 
	.enable(enable)
);

always #(T/2) clk = ~clk;

initial 
	begin
		clk = 0;
		rst = 0;
		enable = 1;
		byte_in = 0;
		n = N;
		pattern = Pattern;	
		#T;
		rst = 1;
		repeat(N)
			begin
				#T;
				byte_in = Pattern[7:0];
				#T;
				byte_in = Pattern[15:8];
				#T;
				byte_in = Pattern[23:16];
				#T;
				byte_in = Pattern[31:24];
				
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(2*T);
		rst = 0;
		#T;
		rst = 1;
		// Testing the First Byte
		repeat(N)
			begin
				#T;
				byte_in = 8'hAA;
				#T;
				byte_in = Pattern[15:8];
				#T;
				byte_in = Pattern[23:16];
				#T;
				byte_in = Pattern[31:24];
				
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(2*T);
		rst = 0;
		#T;
		rst = 1;
		// Testing the Second Byte
		repeat(N)
			begin
				#T;
				byte_in = Pattern[7:0];
				#T;
				byte_in = 8'hAA;
				#T;
				byte_in = Pattern[23:16];
				#T;
				byte_in = Pattern[31:24];
				
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(2*T);
		rst = 0;
		#T;
		rst = 1;
		// Testing the Third Byte
		repeat(N)
			begin
				#T;
				byte_in = Pattern[7:0];
				#T;
				byte_in = Pattern[15:8];
				#T;
				byte_in = 8'hAA;
				#T;
				byte_in = Pattern[31:24];
				
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(2*T);
		rst = 0;
		#T;
		rst = 1;
		// Testing the Fourth Byte
		repeat(N)
			begin
				#T;
				byte_in = Pattern[7:0];
				#T;
				byte_in = Pattern[15:8];
				#T;
				byte_in = Pattern[23:16];
				#T;
				byte_in = 8'hAA;
				
			end
		#T;
		if(pattern_valid == 1'b1)
			$display("Pattern is correct");
		else
			$display("Pattern is not correct");
		#(2*T);
		$stop;
	end
endmodule 