/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/14/25
Scanner FSM for debouncer. Activates when a key is pressed
and deactivates after specified amount of time.
*/

module debounce (input logic clk, reset,
				 input logic [23:0] bounce_cycle_wait,
				 input logic debounce,
				 output logic debounce_done);
	
	
	counter debounce_counter(clk, reset, bounce_cycle_wait, debounce_wait);
	
	
	always_ff @(posedge clk) begin
		if (debounce_wait == 1) debounce_done = 1;
		else debounce_done = 0;
	end
		
		
endmodule