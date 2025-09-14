/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/12/25
Top-level module for E155 Lab 3.
Description
*/

module top(input logic reset, 
		   input logic [3:0] R,
		   output logic [3:0] C,
		   output logic [6:0] seg,
		   output logic [1:0] seg_power
);

   

	// instantiate clock
	logic clk, sel;
	HSOSC #(.CLKHF_DIV(2'b01))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
		
	logic [23:0] BOUNCE_CYCLE_WAIT;
	assign BOUNCE_CYCLE_WAIT = 7'd150000;
		
	logic [3:0] sync_R;
		
	// synchronize R input to clock
	always_ff @(posedge clk)
		if(~reset) sync_R <= 4'b0;
		else	  sync_R <= R;
	
	// number of cycles for seven segment display and scanner
	logic [23:0] SCANNER_CYCLES;
	assign SCANNER_CYCLES = 24'd15;
	logic [23:0] SEVSEG_CYCLES;
	assign SEVSEG_CYCLES = 24'd10000;
	
	// instantiate modules 
	sevseg sevseg_logic(s, seg);
	counter counter1(clk, reset, SCANNER_CYCLES, clk_scan, SCANNER_F);
	counter counter2(clk, reset, SEVSEG_CYCLES, sel);
	
	number_bank bank(key_press, R_press, C_val, s1, s2);
	scanner scanner1(clk, sync_R, BOUNCE_CYCLE_WAIT, C, R_press, key_press);
	
	// apply power to correct seven-segement display
	assign seg_power[0] = sel;
	assign seg_power[1] = ~sel; 
	
	// mux to determine which number is currently displayed on seven-segment display
	assign s = sel ? s1 : s2;
	
endmodule

