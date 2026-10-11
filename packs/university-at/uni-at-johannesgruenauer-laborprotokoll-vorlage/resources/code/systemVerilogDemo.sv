'timescale 1ns / 1ps

module PWM (
	input [15:0] i_duty,
	input [15:0] i_limit,
	input [7:0] i_n,
	input i_mode,
	input i_trig,
	input clk,
	input rst, 
	output logic o_pwm
);

logic [15:0] c_value;
logic s;
logic s1;
logic ResetA;
logic ResetB; 
logic [15:0] d_value;
logic [7:0]dout;

//main pwm counter
always_ff @(posedge clk)
begin 
	if (ResetA)
		c_value <= 0;
	else
		c_value <= c_value + 1;
end

//detect count limit
always_comb
begin 
	if (c_value >= i_limit)
		s = 1;
	else 
		s = 0;
end

//reset main counter 
//on global reset, if cnt limt reached, or if all pulses generated
assign ResetA = rst | s | s1;

//threshold comparator for duty generation
always_comb 
begin
	if (c_value >= i_duty)
		o_pwm = 0;
	else
		o_pwm = 1 & ~s1; 
end

endmodule