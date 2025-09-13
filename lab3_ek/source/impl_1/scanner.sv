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
				input logic [23:0] bounce_cycle_wait;
				output logic [3:0] C,
				output logic [3:0] R_press,
				output logic key_press
				);
				
	// define states 
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
	statetype state, nextstate;
	
	// counter for switch debouncing 
	logic [23:0] i;
			
	always_ff @(posedge clk)
		if (~reset) state <= S9;
	    else 	   state <= nextstate;
			
	// next state logic
	always_comb
		case (state)
			S0:     if (~|R) begin
						nextstate = S1;
						key_press = 1'b0; end
					else begin 
						nextstate = S4;
						key_press = 1'b1;
						R_press   = R; 
						i <= 0; end
			S1: 	if (~|R) begin
						nextstate = S2;
						key_press = 1'b0; end
					else begin 
						nextstate = S5;
						key_press = 1'b1;
						R_press   = R; 
						i <= 0; end
			S2: 	if (~|R) begin
						nextstate = S3;
						key_press = 1'b0; end
					else begin 
						nextstate = S6;
						key_press = 1'b1;
						R_press   = R; 
						i <= 0; end
			S3:     if (~|R) begin
						nextstate = S0;
						key_press = 1'b0; end
					else begin 
						nextstate = S7;
						key_press = 1'b1;
						R_press   = R; 
						i <= 0; end
						
			S4: 	if (i < bounce_cycle_wait) begin 
						nextstate = S4;
						i = i + 1;
					end
					else begin
						if (~|R) begin
							nextstate = S1;
							key_press = 1'b0; end
						else nextstate = S4;
					end

			S5:    	if (i < bounce_cycle_wait) begin
						nextstate = S5;
						i = i + 1;
					end
					else begin
						if (~|R) begin
							nextstate = S2;
							key_press = 1'b0; end
						else nextstate = S5; 
					end
			S6:    	if (i < bounce_cycle_wait) begin
						nextstate = S6;
						i = i + 1;
					end
					else begin
						if (~|R) begin
							nextstate = S3;
							key_press = 1'b0; end
						else nextstate = S6; 
					emd
			S7: 	if (i < bounce_cycle_wait) begin
						nextstate = S7;
						i = i + 1;
					end
					else begin 
						if (~|R) begin
							nextstate = S0;
							key_press = 1'b0; end
						else nextstate = S7;
					end
						
			S9:		nextstate = S0;
						
						
											
			default:	begin  nextstate = S9;
				key_press = 1'b1; 
				R_press = 4'b0001; end
			
		endcase
	
	// output logic
	always_comb begin
		if (state == S9) begin
			C = 4'b0100; end
		else begin
			C[0] = (state == S0) || (state == S4);
			C[1] = (state == S1) || (state == S5);
			C[2] = (state == S2) || (state == S6);
			C[3] = (state == S3) || (state == S7);
		end
	end
		
		
endmodule