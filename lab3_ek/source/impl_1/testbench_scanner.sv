/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/13/25
Testbench for the scanner module
*/

module testbench_scanner();
	logic clk, reset;
	tri [3:0] R;
	tri [3:0] C;
	logic [3:0] R_press;
	logic key_press, debounce_done, debounce;
	assign debounce_done = 1'b1; // don't test debouncing here
	
	scanner dut(.clk(clk), .reset(reset), .R(R), .debounce_done(debounce_done), .C(C), .R_press(R_press), .key_press(key_press), .debounce(debounce));
	// scanner dut(clk, reset, R, bounce_cycle_wait, C, R_press, key_pressed);
	
	// matrix of key presses, keys[row][col]
	logic [3:0][3:0] keys;
	pullup(R[0]);
	pullup(R[1]);
	pullup(R[2]);
	pullup(R[3]);
	
	genvar row, col;
	generate
		for (row = 0; row < 4; row++) begin : row_loop
			for (col = 0; col < 4; col++) begin : col_loop
				tranif1 key_switch(R[row], C[col], keys[row][col]);
			end
		end
	endgenerate
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
	
	// task to check expected values of R_press
	task check_key(input [3:0] exp_R_press, string msg);
		#100;
		assert (R_press == exp_R_press)
			$display("Passed: %s -- got R_press=%h expected R_press=%h at time %0t.", msg, R_press, exp_R_press, $time);
		else
			$error("FAILED!: %s -- got R_press=%h expected R_press=%h at time %0t.", msg, R_press, exp_R_press, $time);
		#50; 
	endtask

		
	initial begin
		reset = 1'b0; 
		keys = '{default:0};
		#22 
		reset = 1'b1;
		
		// press key at row = 1, col = 2
		#50 keys[1][2] = 1;
		check_key(4'h8, "Key press 1");
		// release button
		keys[1][2] = 0;
		
		// press key at row = 3, col = 1
		keys[3][1] = 1;
		check_key(4'h2, "Key press 2");
		
		// release button
		keys[3][1] = 0;
		
		// press key at row = 3, col = 3;
		keys[3][3] = 1; 
		check_key(4'hc, "Key press 3");
		// release buttons
		#100 keys = '{default:0};
		
		#100 $stop;
	end
	
	// timeout
	initial begin
		#5000; 
		$error("Simulation didn't complete in time");
		$stop;
	end
endmodule
		
		
		