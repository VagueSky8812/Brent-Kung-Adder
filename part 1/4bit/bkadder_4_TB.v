`timescale 1 ns / 1 ns	//time unit considered are in 1nanosecond upto 1nanosecond precision

module main;
  reg CLK, RST_N;
	reg[3:0] a, b;
  reg cin;
  wire[3:0] s;
  wire cout;
  integer idx;

  bkadder_4 dut(.CLK (CLK), .RST_N(RST_N), .A(a), .B(b), .CIN(cin), .S(s), .COUT(cout));
  
	// Test clock generation.
	CLK = 1'b0;
  always
    #50 CLK = !CLK;
	 
  initial 
  begin
    CLK = 1'b0;
		RST_N = 1'b0;
		#200
		RST_N = 1'b1;
		// a, b are fixed through out the test
    a = 4'hf;
    b = 4'h1;
		cin = 1'b0;
		#100;
	// Display results after 10 time units $
    $display("%t: RST_N=%b, a=%b, b=%b, cin=%b, cout=%b, s=%b", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 3;  idx = idx + 1) 
    begin
      // Apply a 10-time unit delay; think of it as the system machine cycle
	  a = 4'hf;
	  b = 2*b;
	  cin = 1'b0;
	  // Apply a 10-time unit delay; think of it as the system machine cycle
      #100
      // Display results after 10 time units $
      $display("%t: RST_N=%b, a=%b, b=%b, cin=%b, cout=%b, s=%b", $time, RST_N, a, b, cin, cout, s);
    end
	a = 4'hf;
    b = 4'h1;
		cin = 1'b1;
		#100;
	// Display results after 10 time units $
    $display("%t: RST_N=%b, a=%b, b=%b, cin=%b, cout=%b, s=%b", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 3;  idx = idx + 1) 
    begin
      // Apply a 10-time unit delay; think of it as the system machine cycle
	  a = 4'hf;
	  b = 2*b;
	  cin = 1'b1;
	  // Apply a 10-time unit delay; think of it as the system machine cycle
      #100
      // Display results after 10 time units $
      $display("%t: RST_N=%b, a=%b, b=%b, cin=%b, cout=%b, s=%b", $time, RST_N, a, b, cin, cout, s);
    end
		#200
		$finish;
  end
	
	initial
	begin
	$dumpfile("waveforms.vcd");
	$dumpvars(0,dut);
	end
endmodule 
