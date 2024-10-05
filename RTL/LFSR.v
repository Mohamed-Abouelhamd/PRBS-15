module LFSR (
output [7:0] Byte,
input clk, rst, enable
);

reg [14:0] register;
wire lsb;
assign lsb = register[13] ^ register[14];

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			register <= 15'h5B9A;
		else if(enable)
			register <= {register[13:0],lsb};
	end

assign Byte = {lsb,register[1:0],register[5],register[11:10],register[8],register[13]};
endmodule 
