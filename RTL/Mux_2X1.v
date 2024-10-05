module Mux_2X1 (
output [7:0] mux_out,
input [7:0] in0, in1,
input sel 
);

assign mux_out = sel ? in1 : in0;

endmodule 