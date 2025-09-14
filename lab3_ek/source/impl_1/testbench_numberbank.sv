/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Testbench for the numberbank module
*/

module testbench_numberbank();
	
	logic clk;
	logic [3:0] R_val, C_val;
	logic key_pressed;
	logic [3:0] s1, s2;
	
	numberbank dut(clk, R_val, C_val, key_pressed, s1, s2);
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
		
	initial begin
		#2
		key_pressed = 0; #10
		R_val = 0100; C_val = 0010; key_pressed = 1; #10
		assert(s1 == 4'b1000) else $error("test 1 output s1 = %b, exp = 1000 (8), input = %b, %b", s1, R_val, C_val); #10
		
		key_pressed = 0; #10
		R_val = 0010; C_val = 0100; key_pressed = 1; #20 
		assert(s1 == 4'b0110) else $error("test 2 output s1 = %b, exp = 0110 (6), input = %b, %b", s1, R_val, C_val);
		assert(s2 == 4'b1000) else $error("test 2 output s2 = %b, exp = 1000 (8)", s2); #10
			
		key_pressed = 0; R_val = 0001; C_val = 1000; #120
		assert(s1 == 4'b0110) else $error("test 3 output s1 = %b, exp = 0110 (6)", s1);
		assert(s2 == 4'b1000) else $error("test 3 output s2 = %b, exp = 1000 (8)", s2); #10
			
		R_val = 1000; C_val = 0001; key_pressed = 1; #20
		assert(s1 == 4'b1101) else $error("test 4 output s1 = %b, exp = 1101 (13, D)", s1);
		assert(s2 == 4'b0110) else $error("test 4 output s2 = %b, exp = 0110 (6)", s1); #10
			
		key_pressed = 0; R_val = 0101; C_val = 1000; #20
		assert(s1 == 4'b1101) else $error("test 4 output s1 = %b, exp = 1101 (13, D)", s1);
		assert(s2 == 4'b0110) else $error("test 4 output s2 = %b, exp = 0110 (6)", s1); #10;
		
	end

endmodule
		