module Q4 (
	input clk,    // Clock
	input [1:0] w, // Clock Enable
	input rst,  // Asynchronous reset active low
	output reg x,
	output reg InIdle
);

parameter [4:0]
	idle = 5'b00001,
	s1 	 = 5'b00010,
	s2 	 = 5'b00100,
	s3 	 = 5'b01000,
	s4 	 = 5'b10000;
reg [4:0] state, next_state;

always @(posedge clk) begin
 	if(rst == 1'b1) begin
 		state = idle;
 	end else begin
 		state = next_state;
 	end
 end 

always @(w, state) begin
	case (state)
		idle:
			if ((w == 2'b00) | (w == 2'b11)) begin
				next_state = s1;
			end else begin
				next_state = idle;
			end
		s1:
			if ((w == 2'b00) | (w == 2'b11)) begin
				next_state = s2;
			end else begin
				next_state = idle;
			end
		s2:
			if ((w == 2'b00) | (w == 2'b11)) begin
				next_state = s3;
			end else begin
				next_state = idle;
			end
		s3:
			if ((w == 2'b00) | (w == 2'b11)) begin
				next_state = s4;
			end else begin
				next_state = idle;
			end
		s4:
			if ((w == 2'b00) | (w == 2'b11)) begin
				next_state = s4;
			end else begin
				next_state = idle;
			end
		default: 
			next_state = idle;
	endcase
end

always @(posedge clk) begin
	case (next_state)
		idle 	: InIdle <= 1'b1;
		default : InIdle <= 1'b0;
	endcase
end

always @(posedge clk) begin : proc_
	case (next_state)
		s4 : z <= 1'b1;
		default : z <= 1'b0;
	endcase
end
endmodule : Q4
