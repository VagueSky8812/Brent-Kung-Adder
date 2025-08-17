`timescale 1 ns / 1 ns	//time unit considered are in 1nanosecond upto 1nanosecond precision

module main;
  reg CLK, RST_N;
	reg[7:0] a, b;
  reg cin;
  reg[3:0] sel;
  wire[7:0] y;
  integer idx;

  alu dut(.CLK (CLK), .RST_N(RST_N), .A(a), .B(b), .CIN(cin), .SEL(sel), .Y(y));
  
	// Test clock generation.
  always
    #5 CLK = !CLK;
	 
  initial 
  begin
    CLK = 1'b0;
		RST_N = 1'b0;
		#20
		RST_N = 1'b1;
		// a, b are fixed through out the test
    a = 8'h93;
    b = 8'hA7;
		cin = 1'b0;
		sel = 1'b0;
		#10;
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Generate sel
      sel = idx;
      // cin = 1 only for sel = 5
      if (idx == 5)
        cin = 1'b1;
      else
        cin = 1'b0;
      // Apply a 10-time unit delay; think of it as the system machine cycle
      #10
      // Display results after 10 time units $
      $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, sel=%h, y=%h", $time, RST_N, a, b, cin, sel, y);
    end 
		#20
		$finish;
  end
	
	initial
	begin
	$dumpfile("waveforms.vcd");
	$dumpvars(0,dut);
	end
endmodule 
