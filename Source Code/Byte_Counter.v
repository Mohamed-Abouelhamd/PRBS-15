module Byte_Counter (
output reg [1:0] byte_num,
input rst, clk, enable
);

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			byte_num <= 0;
		else if(enable)
			byte_num <= byte_num + 1;
	end
endmodule 
