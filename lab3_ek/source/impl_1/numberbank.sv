/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Keeps track of numbers pressed and updates numbers
when a number key is pressed. 
*/

module numberbank(
	input logic clk, 
	input logic [3:0] R_val, C_val,
	input logic key_pressed,
	output logic [3:0] s1, s2
	);
	
	logic [3:0] new_number;
	always_comb
		case ({R_val, C_val})
			8'b0001_0001:   new_number = 4'b0001;
			8'b0001_0010:   new_number = 4'b0010;
			8'b0001_0100:   new_number = 4'b0011;
			8'b0001_1000:   new_number = 4'b1010;
			
			8'b0010_0001:   new_number = 4'b0100;
			8'b0010_0010:   new_number = 4'b0101;
			8'b0010_0100:   new_number = 4'b0110;
			8'b0010_1000:   new_number = 4'b1011;
			
			8'b0100_0001:   new_number = 4'b0111;
			8'b0100_0010:   new_number = 4'b1000;
			8'b0100_0100:   new_number = 4'b1001;
			8'b0100_1000:   new_number = 4'b1100;
			
			8'b1000_0001:   new_number = 4'b1110;
			8'b1000_0010:   new_number = 4'b0000;
			8'b1000_0100:   new_number = 4'b1111;
			8'b1000_0100:   new_number = 4'b1101;
		endcase
		
	
	always_ff @(posedge clk) begin
		if (key_pressed) begin
			s2 <= s1;
			s1 <= new_number;
		end
		else begin
			s2 <= s2;
			s1 <= s1;
		end
	end

endmodule