`timescale 1ns/100ps
module PRBS_TB;

wire [7:0] Byte_out;
reg [31:0] bytes_in;
reg [7:0] n;
reg clk, rst, enable;

localparam  T = 20,
			N = 2,
	  		Pattern1 = 32'h3ACF491E,
			Pattern2 = 32'h4DF1A98B;


PRBS_15 PRBS_uut(
	.Byte_out(Byte_out),
	.bytes_in(bytes_in),
	.n(n),
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
		bytes_in = Pattern1;	
		#(T/4);
		rst = 1;
		#(T/4);
		// Generate the output pattern n times
		$display("Checking the pattern %h",bytes_in);
		repeat(n)
			begin
				#T;
				if(Byte_out == bytes_in[7:0])
					$display("The output is correct = %h",Byte_out);
				#T;
				if(Byte_out == bytes_in[15:8])
					$display("The output is correct = %h",Byte_out);
				#T;
				if(Byte_out == bytes_in[23:16])
					$display("The output is correct = %h",Byte_out);
				#T;
				if(Byte_out == bytes_in[31:24])
					$display("The output is correct = %h",Byte_out);
			end
		$display("Some random outputs");
		// Generate random samples
		repeat(4) 
			#T $display("The output is %h",Byte_out);
		// Change bytes_in through the process of randomization
		bytes_in = Pattern2;
		repeat(n) 
			begin
				#T;
				$display("The output is %h",Byte_out);
				if(Byte_out == bytes_in[7:0])
					$display("The output is not correct = %h",Byte_out);
				#T;
				$display("The output is %h",Byte_out);
				if(Byte_out == bytes_in[15:8])
					$display("The output is not correct = %h",Byte_out);
				#T;
				$display("The output is %h",Byte_out);
				if(Byte_out == bytes_in[23:16])
					$display("The output is not correct = %h",Byte_out);
				#T;
				$display("The output is %h",Byte_out);
				if(Byte_out == bytes_in[31:24])
					$display("The output is not correct = %h",Byte_out);
			end
		$stop;
	end
endmodule 
