module Seq_Counter(
output reg [7:0] seq_num,
input [1:0] byte_num,
input clk, rst, enable
);

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			seq_num <= 0;
		else if(enable && byte_num == 2'b11)
			seq_num <= seq_num + 1;
	end

endmodule 