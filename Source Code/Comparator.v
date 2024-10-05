module Comparator(
output reg comp,
input [7:0] in1, in2,
input clk, rst
); 

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			comp <= 0;
		else
			comp <= (in1 == in2);
	end
 
endmodule 
