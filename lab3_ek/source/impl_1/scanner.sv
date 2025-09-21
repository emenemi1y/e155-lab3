/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Scanner FSM for keypad input. Powers one column at a time 
and reads each row value. If a key is pressed, keeps that 
column powered until released.
*/

module scanner (input logic clk, 
				input logic reset,
				input logic [3:0] R,
				input logic [23:0] bounce_cycle_wait,
				input logic debounce_done,
				output logic [3:0] C,
				output logic [3:0] R_press,
				output logic key_press, debounce
				);
				
	// define states 
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8} statetype;
	statetype state, nextstate;
			
	always_ff @(posedge clk)
		if (~reset) state <= S8;
	    else 	   state <= nextstate;
			
	// next state logic
	always_comb
		case (state)
			S0:     if (R == 4'b0000) begin
						nextstate = S1;
						key_press = 1'b0;
						debounce  = 1'b0;
						R_press   = R_press; end
					else begin 
						nextstate = S4;
						key_press = 1'b1;
						R_press   = R; 
						debounce  = 1'b1; end 
			S1: 	if (R == 4'b0000) begin
						nextstate = S2;
						key_press = 1'b0;
						debounce  = 1'b0;
						R_press   = R_press; end
					else begin 
						nextstate = S5;
						key_press = 1'b1;
						R_press   = R; 
						debounce  = 1'b1; end
						
			S2: 	if (R == 4'b0000) begin
						nextstate = S3;
						key_press = 1'b0; 
						debounce  = 1'b0;
						R_press   = R_press; end
					else begin 
						nextstate = S6;
						key_press = 1'b1;
						R_press   = R; 
						debounce  = 1'b1; end
						
			S3:     if (R == 4'b0000) begin
						nextstate = S0;
						key_press = 1'b0; 
						debounce  = 1'b0;
						R_press   = R_press; end
					else begin 
						nextstate = S7;
						key_press = 1'b1;
						R_press   = R; 
						debounce  = 1'b1; end
						
			S4: 	if (~debounce_done) begin nextstate = S4;
						debounce = 1'b1;
						key_press = 1'b1;
						R_press = R_press; end
					else begin
						debounce = 1'b0;
						if (R == 4'b0000) begin
							nextstate = S1;
							key_press = 1'b0; end
						else begin nextstate = S4;
							key_press = 1'b1;
							R_press = R_press;
							end
					end

			S5:    	if (~debounce_done) begin nextstate = S5;
						debounce = 1'b1;
						key_press = 1'b1;
						R_press = R_press; end
					else begin
						debounce = 1'b0;
						if (R == 4'b0000) begin
							nextstate = S2;
							key_press = 1'b0; end
						else begin nextstate = S5; 
							key_press = 1'b1;
							R_press = R_press;
							end
					end
					
			S6:    	if (~debounce_done) begin nextstate = S6;
						debounce = 1'b1;
						key_press = 1'b1;
						R_press = R_press; end
					else begin
						debounce = 1'b0;
						if (R == 4'b0000) begin
							nextstate = S3;
							key_press = 1'b0; end
						else begin nextstate = S6; 
							key_press = 1'b1;
							R_press = R_press;
							end
					end
					
			S7: 	if (~debounce_done) begin nextstate = S7;
						debounce = 1'b1;
						key_press = 1'b1;
						R_press = R_press; end
					else begin 
						debounce = 1'b0;
						if (R == 4'b0000) begin
							nextstate = S0;
							key_press = 1'b0; end
						else begin nextstate = S7;
							key_press = 1'b1;
							R_press = R_press;
							end
					end
						
			S8:		begin nextstate = S0;
					key_press = 1'b0;
					R_press = R_press;
					debounce = 1'b0; end
						
						
											
			default:	begin  nextstate = S8;
				key_press = 1'b1; 
				R_press = 4'b0001; 
				debounce = 1'b0; end
				
			
		endcase
	
	// output logic
	always_comb begin
		if (state == S8) begin
			C = 4'b0100; end
		else begin
			C[0] = (state == S0) || (state == S4);
			C[1] = (state == S1) || (state == S5);
			C[2] = (state == S2) || (state == S6);
			C[3] = (state == S3) || (state == S7);
		end
	end
		
		
endmodule