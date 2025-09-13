/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/12/25
Top-level module for E155 Lab 3.
Description
*/

module top(input logic reset, 
		   input logic [3:0] R,
		   output logic [6:0] seg,
		   output logic [1:0] seg_power
);

	// instantiate clock
	logic clk, sel;
	HSOSC #(.CLKHF_DIV(2'b01))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// mux to determine which number is currently displayed on seven-segment display
	assign s = sel ? s1 : s2;
	// instantiate modules 
	sevseg sevseg_logic(s, seg);
	counter counter1(clk, reset, clk_scan, SCANNER_F);
	counter counter2(clk, reset, sel, SEVSEG_F);
	// scanner fsm module
	// number bank module
	
	// apply power to correct seven-segement display
	assign seg_power[0] = sel;
	assign seg_power[1] = ~sel; 
	
endmodule

