module Byte_Comp(
output reg true_byte, start,
input [31:0] pattern,
input [1:0] byte_num,
input [7:0] byte_in,
input clk, rst, enable
);

always @(posedge clk, negedge rst)
	begin
		if(~rst) begin
			true_byte <= 0;
			start <= 0;
		end
		else if(enable) begin
			start <= 1;
			case(byte_num)
				2'b00: true_byte <= byte_in == pattern[7:0];
				2'b01: true_byte <= byte_in == pattern[15:8];
				2'b10: true_byte <= byte_in == pattern[23:16];
				2'b11: true_byte <= byte_in == pattern[31:24];
			endcase
		end
	end

endmodule 