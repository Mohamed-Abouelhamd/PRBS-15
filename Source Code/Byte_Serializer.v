module Byte_Ser (
output reg [7:0] ser_byte, 
input [31:0] bytes_in, 
input [1:0] byte_num,
input clk, rst, enable
);

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			ser_byte <= 0;
		else if(enable) begin
			case(byte_num)
				2'b00: ser_byte <= bytes_in [7:0];
				2'b01: ser_byte <= bytes_in [15:8];
				2'b10: ser_byte <= bytes_in [23:16];
				2'b11: ser_byte <= bytes_in [31:24];	
			endcase
		end			
	end
endmodule 
