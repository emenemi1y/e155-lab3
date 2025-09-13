/* 
Name: Emily Kendrick
Email: ekendrick@hmc.edu
Date created: 9/6/25
Testbench for the sevseg module
*/

module testbench_sevseg();

	logic clk;
	logic [3:0] s;
	logic [6:0] seg;
	
sevseg dut(s, seg);

// generate clock
always 
	begin
		// period = 10 ticks
		clk = 1; #5;
		clk = 0; #5;
	end

initial begin 
	s = 4'b0000; #5; assert (seg == 7'b1000000) else $error("input=0000, output=%s, exp=1000000",seg); #20
	s = 4'b0001; #5; assert (seg == 7'b1111001) else $error("input=0001, output=%s, exp=1111001",seg); #20
	s = 4'b0010; #5; assert (seg == 7'b0100100) else $error("input=0010, output=%s, exp=0100100",seg); #20
	s = 4'b0011; #5; assert (seg == 7'b0110000) else $error("input=0011, output=%s, exp=0110000",seg); #20
	s = 4'b0100; #5; assert (seg == 7'b0011001) else $error("input=0100, output=%s, exp=0011001",seg); #20
	s = 4'b0101; #5; assert (seg == 7'b0010010) else $error("input=0101, output=%s, exp=0010010",seg); #20
	s = 4'b0110; #5; assert (seg == 7'b0000010) else $error("input=0110, output=%s, exp=0000010",seg); #20
	s = 4'b0111; #5; assert (seg == 7'b1111000) else $error("input=0111, output=%s, exp=1111000",seg); #20
	s = 4'b1000; #5; assert (seg == 7'b0000000) else $error("input=1000, output=%s, exp=0000000",seg); #20
	s = 4'b1001; #5; assert (seg == 7'b0011000) else $error("input=1001, output=%s, exp=0011000",seg); #20
	s = 4'b1010; #5; assert (seg == 7'b0001000) else $error("input=1010, output=%s, exp=0001000",seg); #20
	s = 4'b1011; #5; assert (seg == 7'b0000011) else $error("input=1011, output=%s, exp=0000011",seg); #20
	s = 4'b1100; #5; assert (seg == 7'b1000110) else $error("input=1100, output=%s, exp=1000110",seg); #20
	s = 4'b1101; #5; assert (seg == 7'b0100001) else $error("input=1101, output=%s, exp=0100001",seg); #20
	s = 4'b1110; #5; assert (seg == 7'b0000110) else $error("input=1110, output=%s, exp=0000110",seg); #20
	s = 4'b1111; #5; assert (seg == 7'b0001110) else $error("input=1111, output=%s, exp=0001110",seg); #20;
end

endmodule