/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Creates a divider for an input clock to obtain a switching frequency 
that is slower than the original clock by a factor of num-cycles.
*/

module counter(
	input logic clk, reset,
	input logic [23:0] num_cycles,
	output logic new_clk
);

	logic [23:0] count;

	// counter
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			count <= 24'b0;
			new_clk <= 0;
		end
		else begin
			if (count == num_cycles) begin
				count <= 24'b0;
				new_clk <= ~new_clk;
			end
			else count <= count + 2'b1;
		end
	end

endmodule