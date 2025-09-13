/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Testbench for the scanner module
*/

module testbench_scanner();
	
	logic clk, reset;
	logic [3:0] R, C, R_press;
	logic key_press;
	logic [23:0] bounce_cycle wait;
	assign bounce_cycle_wait = 23'd3; // make it small for testing 
	
	scanner dut(clk, reset, R, bounce_cycle_wait, C, R_press, key_press);
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
		
	initial begin
		reset = 1'b0; #22
		reset = 1'b1; #10
		R = 4'b0000; #30
		R = 4'b1000; #10;
	end
endmodule

		
		