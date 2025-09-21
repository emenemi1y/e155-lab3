/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Testbench for the scanner module
*/

module testbench_scanner();
	logic clk, reset;
	logic [3:0] R, C, R_press;
	logic key_pressed;
	logic [23:0] bounce_cycle_wait;
	assign bounce_cycle_wait = 23'd2; // make it small for testing 
	
	scanner dut(clk, reset, R, bounce_cycle_wait, C, R_press, key_pressed);
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
		
	initial begin
		reset = 1'b0; #22
		R = 4'b0000; #5
		assert(C == 4'b0100) else $error("test 1, output C = %s, exp = 0100", C);
		assert (R_press == 4'b0001) else $error("test 1, output R_press = %s, exp = 0001", R_press); #20 
			
		reset = 1'b1; #10 // waits one clock cycle after pressing reset, should go to another state
		assert(key_pressed == 0) else $error("test 2, output key_pressed = 1, exp = 0"); #10
		
		R = 4'b1000; #40 // waiting out button debouncing 
		assert(key_pressed == 1) else $error("test 3, output key_pressed = %s, exp = 1", key_pressed);
		assert(R_press == 4'b1000) else $error("test 3, output R_press = %s, exp = 1", R_press); #30 
			
		R = 4'b1010; #30 // second button pressed after first 
		assert(key_pressed == 1) else $error("test 3, output key_pressed = %s, exp = 1", key_pressed);
		assert(R_press == 4'b1000) else $error("test 3, output R_press = %s, exp = 1000", R_press); #10
			
		R = 4'b0000; #30 // Release button
		assert(key_pressed == 0) else $error("test 5, output key_pressed = %s, exp = 0", key_pressed); #10
			
		R = 4'b0010; #50 // Press button, wait for button debouncing 
		assert(key_pressed == 1) else $error("test 6, output key_pressed = %s, exp = 1", key_pressed); 
		assert(R_press == 4'b0010) else $error("test 6, output R_press = %s, exp = 0010", R_press); #10;
	
	end
endmodule

		
		