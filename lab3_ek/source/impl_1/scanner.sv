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
				input logic debounce_done,
				output logic [3:0] C,
				output logic [3:0] R_press,
				output logic key_press, debounce
				); 
				
	// define states 
	typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, up0, up1, up2, up3} statetype;
	statetype state, nextstate;
	logic update;
			
	always_ff @(posedge clk)
		if (~reset) state <= S8;
	    else 	   state <= nextstate;
			
	// next state logic
	always_comb
		case (state)
			S0:     if (R == 4'b1111) begin
						nextstate = S1;
						debounce  = 1'b0;
						end
					else begin 
						nextstate = up0;
						debounce  = 1'b1; 
						end 
						
			
			S1: 	if (R == 4'b1111) begin
						nextstate = S2;
						debounce  = 1'b0;
						end
					else begin 
						nextstate = up1;
						debounce  = 1'b1; 
						end
											
			S2: 	if (R == 4'b1111) begin
						nextstate = S3;
						debounce  = 1'b0;
						end
					else begin 
						nextstate = up2; 
						debounce  = 1'b1; 
						end
						
			S3:     if (R == 4'b1111) begin
						nextstate = S0; 
						debounce  = 1'b0;
						end
					else begin 
						nextstate = up3;
						debounce  = 1'b1; 
						end
			
			
			S4: 	if (~debounce_done) begin nextstate = S4;
						debounce = 1'b1;
						end
					else begin
						debounce = 1'b0;
						if (R == 4'b1111) begin
							nextstate = S1;
							end
						else begin 
							nextstate = S4;
							end
					end
					
			

			S5:    	if (~debounce_done) begin nextstate = S5;
						debounce = 1'b1;
						end
					else begin
						debounce = 1'b0;
						if (R == 4'b1111) begin
							nextstate = S2; 
							end
						else begin 
							nextstate = S5; 
							end
					end
					
				
			S6:    	if (~debounce_done) begin nextstate = S6;
						debounce = 1'b1;
						end
					else begin
						debounce = 1'b0;
						if (R == 4'b1111) begin
							nextstate = S3; 
							end
						else begin 
							nextstate = S6; 
							end
					end
					
			S7: 	if (~debounce_done) begin nextstate = S7;
						debounce = 1'b1;
						end
					else begin 
						debounce = 1'b0;
						if (R == 4'b1111) begin
							nextstate = S0; 
							end
						else begin 
							nextstate = S7;
							end
					end
				
			S8:		begin 
					nextstate = S0;
					debounce = 1'b0; 
					end
					
			up0:    begin:
					nextstate = S4;
					debounce = 1'b0;
					end
			
			up1:    begin:
					nextstate = S5;
					debounce = 1'b0;
					end
			up2: 	begin:
					nextstate = S6;
					debounce = 1'b0;
					end
			up3:    begin: 
					nextstate = S7;
					debounce = 1'b0;
					end
					
			
											
			default:	
				begin  nextstate = S8;
					debounce = 1'b0; 
					end
			
		endcase
	
	// output logic
	always_comb begin
		if (state == S8) begin
			C = 4'b1011; 
			key_press = 1'b1; 
			update = 1'b1;
			end
		else begin
			C[0] = ~(state == S0) || (state == S4);
			C[1] = ~(state == S1) || (state == S5);
			C[2] = ~(state == S2) || (state == S6);
			C[3] = ~(state == S3) || (state == S7);
			key_press = ((state == S4) || (state == S5) || (state == S6) || (state == S7));
			update = ((state == up1) || (state == up2) || (state == up3) || (state == up0));
		end
	end
	
	always_ff @(posedge clk) begin
		if (update) begin
			R_press <= R;
		end
		else begin
			R_press <= R_press;
		end
	end
		
endmodule