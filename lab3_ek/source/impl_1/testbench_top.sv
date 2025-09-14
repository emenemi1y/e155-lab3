/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/14/25
Testbench for top module
*/

module testbench_top();	
	logic clk, reset;
	logic [3:0] R, C;
	logic [6:0] seg;
	logic [1:0] seg_power;
	
	top dut(clk, reset, R, C, seg, seg_power);
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
		
	// test with bounce_cycle wait of 3 clock cycles
	// test with sevseg_cycles at 3 and scanner_cycles at 1
		
	initial begin
		reset = 1'b0; R = 4'b0000; #22;
		reset = 1'b1; #10;
		
		#50 // wait five more clock cycles
		
		// both seven segment displays should be displaying zero initially: 
		assert(seg == 7'b1000000') else $error("test 0: not displaying zero to start"); #10
		
		R = 4'b0001; #30
		// read C and assert that sevseg outputs either 0 or the number corresponding to the button push
		
		
		
		
		key_pressed = 1'b0; #10
		R_val = 4'b0100; C_val = 4'b0010; key_pressed = 1'b1; #10
		assert(s1 == 4'b1000) else $error("test 1 output s1 = %b, exp = 1000 (8), input = %b, %b", s1, R_val, C_val); #10
		
		key_pressed = 1'b0; #10
		R_val = 4'b0010; C_val = 4'b0100; key_pressed = 1'b1; #20 
		assert(s1 == 4'b0110) else $error("test 2 output s1 = %b, exp = 0110 (6), input = %b, %b", s1, R_val, C_val);
		assert(s2 == 4'b1000) else $error("test 2 output s2 = %b, exp = 1000 (8)", s2); #10
			
		key_pressed = 1'b0; R_val = 4'b0001; C_val = 4'b1000; #120
		assert(s1 == 4'b0110) else $error("test 3 output s1 = %b, exp = 0110 (6)", s1);
		assert(s2 == 4'b1000) else $error("test 3 output s2 = %b, exp = 1000 (8)", s2); #10
			
		R_val = 4'b1000; C_val = 4'b0001; key_pressed = 1'b1; #20
		assert(s1 == 4'b1110) else $error("test 4 output s1 = %b, exp = 1110 (14, E)", s1);
		assert(s2 == 4'b0110) else $error("test 4 output s2 = %b, exp = 0110 (6)", s1); #10
			
		key_pressed = 1'b0; R_val = 4'b0101; C_val = 4'b1000; #20
		assert(s1 == 4'b1110) else $error("test 5 output s1 = %b, exp = 1101 (14, E)", s1);
		assert(s2 == 4'b0110) else $error("test 5 output s2 = %b, exp = 0110 (6)", s1); #10;
		
	end

endmodule
