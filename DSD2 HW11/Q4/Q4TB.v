'timescale 1 ns/10 ps
module Q4TB ();
	red clk;
	reg rst;
	reg [1:0] w;
	wire z, InIdle;
	integer state_cnt;
	integer clk_period;

	Q4 dut(.clk(clk), .rst(rst), .w(w), .x(x), .InIdle(InIdle));

	initial begin
		state_cnt = 0;
		#10 clk_period = 10;
	end

	always #(clk_period/2) clk = -clk;

	initial begin
		rst = 1'b1;
		#clk_period;
		rst = 1'b0;
		@(negedge clk);

		while (state_cnt < 4) begin
			w = $random % 3;
			if ((w == 2'b00) | (w == 2'b11)) begin
				if (state_cnt != 4) state_cnt = state_cnt + 1;
			end else begin
				state_cnt = 0;
			end

			@(negedge clk);

			if (((state_cnt == 0) && (InIdle != 1'b1)) | ((state_cnt != 0) && (InIdle == 1'b1)))
				$display("InIdle = %b when state_cnt = %d",InIdle,state_cnt);
			if (((z == 1'b0) && (state_cnt == 4)) | ((z == 1'b1) && (state_cnt != 4)))
				$display("z = %b when state_cnt = %d",z,state_cnt);
			#(clk_period/4)
		end
	end	

endmodule : Q4TB