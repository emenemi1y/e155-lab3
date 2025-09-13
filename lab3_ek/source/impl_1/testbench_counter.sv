/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the counter module
*/

module testbench_counter();

	logic clk, reset;
	logic sel;
	logic [23:0] div;
	
counter dut(clk, reset, sel, div);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end
	
initial begin
	div   = 3;
	reset = 0; #22
	reset = 1; 
end


endmodule