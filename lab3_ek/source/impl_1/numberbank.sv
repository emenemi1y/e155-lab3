/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Keeps track of numbers pressed and updates numbers
when a number key is pressed. 
*/

module numberbank(
	input logic clk, reset,
	input logic [3:0] R_val, C,
	input logic key_press,
	output logic [3:0] s1, s2
	);
	
	
	// define states
	typedef enum logic [1:0] {hold, update, stall} statetype;
	statetype state, nextstate;
	
	
	logic [3:0] new_number;
	always_comb begin
		case ({R_val, C})
			{4'b0001, 4'b0001}:   new_number = 4'b0001;
			{4'b0001, 4'b0010}:   new_number = 4'b0010;
			{4'b0001, 4'b0100}:   new_number = 4'b0011;
			{4'b0001, 4'b1000}:   new_number = 4'b1010;
			
			{4'b0010, 4'b0001}:   new_number = 4'b0100;
			{4'b0010, 4'b0010}:   new_number = 4'b0101;
			{4'b0010, 4'b0100}:   new_number = 4'b0110;
			{4'b0010, 4'b1000}:   new_number = 4'b1011;
			
			{4'b0100, 4'b0001}:   new_number = 4'b0111;
			{4'b0100, 4'b0010}:   new_number = 4'b1000;
			{4'b0100, 4'b0100}:   new_number = 4'b1001;
			{4'b0100, 4'b1000}:   new_number = 4'b1100;
			
			{4'b1000, 4'b0001}:   new_number = 4'b1110;
			{4'b1000, 4'b0010}:   new_number = 4'b0000;
			{4'b1000, 4'b0100}:   new_number = 4'b1111;
			{4'b1000, 4'b0100}:   new_number = 4'b1101;
		endcase
	end
	
	// update state 
	always_ff @(posedge clk)
	if (~reset) state <= hold;
	else 	   state <= nextstate;
		
	// next state logic 
	always_comb begin
		case(state)
			hold:	if (key_press) nextstate = update;
					else             nextstate = hold;
			update:                  nextstate = stall;
			stall: 	if (key_press) nextstate = stall;
					else             nextstate = hold;
			
			default:                 nextstate = hold;
		endcase
	end
	
	always_comb begin
		if ((state == hold) || (state == stall)) begin
			s2 = s2;
			s1 = s1;
		end
		if (state == update) begin
			s2 = s1;
			s1 = new_number;
		end
	end
			

endmodule