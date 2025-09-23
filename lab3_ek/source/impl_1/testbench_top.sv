/*
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/14/25
Testbench for top module
*/

module testbench_top();	

	logic clk, reset;
	logic  [3:0] R;
	logic  [3:0] C;
	logic [6:0] seg;
	logic [1:0] seg_power;
	
	top dut(.clk(clk), .reset(reset), .R(R), .C(C), .seg(seg), .seg_power(seg_power));
	
	// matrix of key presses, keys[row][col]
	// logic [3:0][3:0] keys;
	/*
	pullup(R[0]);
	pullup(R[1]); 
	pullup(R[2]);
	pullup(R[3]);
	*/
	
	/*
	genvar row, col;
	generate
		for (row = 0; row < 4; row++) begin : row_loop
			for (col = 0; col < 4; col++) begin : col_loop
				tranif1 key_switch(R[row], C[col], keys[row][col]);
			end
		end
	endgenerate
	*/
	
	// generate clock
	always
		begin
			// period = 10 ticks
			clk = 1; #5; 
			clk = 0; #5;
		end
	
	// task to check expected values of R_press
	task check_key(input [3:0] exp_seg, string msg);
		#100;
		assert (seg == exp_seg)
			$display("Passed: %s -- got seg=%h expected seg=%h at time %0t.", msg, seg, exp_seg, $time);
		else
			$error("Failed: %s -- got seg=%h expected seg=%h at time %0t.", msg, seg, exp_seg, $time);
		#50; 
	endtask

		
	initial begin
		reset = 1'b0; 
		// keys = '{default:0};
		#22 
		reset = 1'b1;
		R = 4'b1111;
		
		// press key at 
		#50 R = 4'b1011;
		check_key(7'b0000000, "Key press 1");
		// release button
		R = 4'b1111;
		#50
		// press key at 
		R = 4'b0111;
		check_key(7'b0100100, "Key press 2");
		
		// release button
		R = 4'b1111;
		#50
		// press key at 
		R = 4'b1110;
		check_key(7'b1000110, "Key press 3");
		// release buttons
		#100 R = 4'b1111;
		
		#100 $stop;
	end
	
	// timeout
	initial begin
		#5000; 
		$error("Simulation didn't complete in time");
		$stop;
	end
endmodule
