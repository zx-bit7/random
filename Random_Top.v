module Random_Top (
	input i_Clk,
	input i_Switch_1,
	output o_Segment2_A,
	output o_Segment2_B,
	output o_Segment2_C,
	output o_Segment2_D,
	output o_Segment2_E,
	output o_Segment2_F,
	output o_Segment2_G,
	output o_Segment1_A,
	output o_Segment1_B,
	output o_Segment1_C,
	output o_Segment1_D,
	output o_Segment1_E,
	output o_Segment1_F,
	output o_Segment1_G,
	output o_LED_1,
	output o_LED_2,
	output o_LED_3,
	output o_LED_4
	);

	wire w_Switch_1;
	reg r_Switch_1 = 1'b0;
	reg [31:0] r_Value = 32'h42424242;
	reg [31:0] r_OutValue;

	reg r_led = 1'b0;
	reg r_led2 = 1'b0;

	Debounce_Switch debouncer1 (
		.i_Clk(i_Clk),
		.i_Switch(i_Switch_1),
		.o_Switch(w_Switch_1)
		);

	// always @(posedge i_Clk)
	// begin
	// 	r_Switch_1 <= w_Switch_1;

	// 	if (w_Switch_1 == 1'b1) r_led <= 1'b1;

	// 	if (w_Switch_1 == 1'b1 &&
	// 		r_Switch_1 == 1'b0)
	// 	begin
	// 		//r_Value <= 8'h3e;
	// 	end
	// end

	always @(*) begin
		if ((w_Switch_1 == 1'b1) && (r_Switch_1 == 1'b0)) begin
			r_OutValue = r_Value;
			r_OutValue = r_OutValue ^ (r_OutValue << 13);
			r_OutValue = r_OutValue ^ (r_OutValue >> 17);
			r_OutValue = r_OutValue ^ (r_OutValue << 5);
		end
		else begin
			r_OutValue = r_Value;			
		end
	end

	always @(posedge i_Clk) begin
		r_Switch_1 	<= w_Switch_1;
		r_Value <= r_OutValue;
	end

	Binary_To_7Segment converter1 (
		.i_Clk(i_Clk),
		.i_Binary_Num(r_Value[3:0]),
		.o_Segment_A(o_Segment2_A),
		.o_Segment_B(o_Segment2_B),
		.o_Segment_C(o_Segment2_C),
		.o_Segment_D(o_Segment2_D),
		.o_Segment_E(o_Segment2_E),
		.o_Segment_F(o_Segment2_F),
		.o_Segment_G(o_Segment2_G)
		);

	Binary_To_7Segment converter2 (
		.i_Clk(i_Clk),
		.i_Binary_Num(r_Value[7:4]),
		.o_Segment_A(o_Segment1_A),
		.o_Segment_B(o_Segment1_B),
		.o_Segment_C(o_Segment1_C),
		.o_Segment_D(o_Segment1_D),
		.o_Segment_E(o_Segment1_E),
		.o_Segment_F(o_Segment1_F),
		.o_Segment_G(o_Segment1_G)
		);

	assign o_LED_1 = r_led;

endmodule
