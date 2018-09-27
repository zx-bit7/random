module Debounce_Switch (
	input i_Clk,
	input i_Switch,
	output o_Switch);

	parameter k_DEBOUNCE_LIMIT = 250000;		// 10ms @ 25Mhz

	reg r_State = 1'b0;
	reg [17:0] r_Count = 0;

	always @(posedge i_Clk) 
	begin
		if (i_Switch !== r_State && r_Count < k_DEBOUNCE_LIMIT)
		begin
			r_Count <= r_Count + 1;		// COUNTER!
		end
		else if (r_Count == k_DEBOUNCE_LIMIT)
		begin
			r_Count <= 0;
			r_State <= i_Switch;
		end
		else begin
			r_Count <= 0;
		end
	end

	assign o_Switch = r_State;

endmodule
