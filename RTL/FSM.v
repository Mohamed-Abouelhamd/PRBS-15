module FSM (
output reg pattern_valid, enable,
input [1:0] byte_num,
input [7:0] seq_num, n,
input true_byte, start,
input equal, clk, rst
);

reg [1:0] State_Current, State_Next;

localparam START = 2'b00,
	   CHECK = 2'b01,
	   FAIL  = 2'b10,
	   SUCCESS = 2'b11;

always @(posedge clk, negedge rst)
	begin
		if(~rst)
			State_Current <= START;
		else
			State_Current <= State_Next;
	end 

always @*
	begin
		case(State_Current)
			START: begin
				if(start)
					State_Next <= CHECK;
				else
					State_Next <= START;
			end
			CHECK: begin
				if(~true_byte)
					State_Next <= FAIL;
				else if(true_byte && (byte_num == 3) && (seq_num == n-1))
					State_Next <= SUCCESS;
				else
					State_Next <= CHECK;
			end
			SUCCESS: begin
				State_Next <= SUCCESS;
			end
			FAIL: begin
				State_Next <= FAIL;
			end
		endcase
	end

always @*
	begin
		case(State_Current)
			START: begin
				pattern_valid <= 0;
				enable <= 1;	
			end
			CHECK: begin
				pattern_valid <= 0;
				enable <= 1;	
			end
			SUCCESS: begin
				pattern_valid <= 1;
				enable <= 0;	
			end
			FAIL: begin
				pattern_valid <= 0;
				enable <= 0;		
			end
		endcase
	end
endmodule 