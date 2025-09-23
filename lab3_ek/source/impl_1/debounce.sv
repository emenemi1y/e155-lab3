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
	

	typedef enum logic [1:0] {S0, S1} statetype;
	logic counter_reset;
	statetype state, nextstate;
	
	counter db_counter(clk, counter_reset, bounce_cycle_wait, debounce_wait);
	
	always_ff @(posedge clk)
		if(~reset) state <= S0;
		else	   state <= nextstate;
	
	always_comb 
		case(state)
			S0: begin
				if (debounce) begin
					counter_reset = 1'b1;
					nextstate = S1;
				end
				else begin 
					nextstate = S0;
					counter_reset = 1'b0;
				end
			end
			S1: begin
				if (~debounce_wait) begin
					counter_reset = 1'b1;
					nextstate = S1;
				end
				else begin
					counter_reset = 1'b0;
					nextstate = S0;
				end
				end
			default: begin
				nextstate = S0;
				counter_reset = 1'b0;
			end
		endcase
				
		
	always_comb begin
		debounce_done = (state == S0);
	end
	/*
	always_ff @(posedge clk) begin
		if (debounce_wait == 1) debounce_done <= 1;
		else debounce_done <= 0;
	end
	*/
		
endmodule