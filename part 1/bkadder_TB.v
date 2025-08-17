`timescale 1 ns / 1 ns	//time unit considered are in 1nanosecond upto 1nanosecond precision

module main;
  reg CLK, RST_N;
	reg[15:0] a, b;
  reg cin;
  wire[15:0] s;
  wire cout;
  integer idx;

  bkadder dut(.CLK (CLK), .RST_N(RST_N), .A(a), .B(b), .CIN(cin), .S(s), .COUT(cout));
  
	// Test clock generation.
  always
    #5 CLK = !CLK;
	 
  initial 
  begin
    CLK = 1'b0;
		RST_N = 1'b0;
		#20
		RST_N = 1'b1;
    a = 16'hffff;
    b = 16'h0001;
		cin = 1'b0;
		#20;
    // Display results after 20 time units $
    $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Apply a 20-time unit delay; think of it as the system machine cycle; 2 clock cycles are needed due to registering data in final S at posedge only
	  a = 16'hffff;
	  b = 2*b;
	  cin = 1'b0;
	  // Apply a 20-time unit delay; think of it as the system machine cycle
      #20
      // Display results after 20 time units $
      $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    end
    
    a = 16'hffff;
    b = 16'h0001;
		cin = 1'b1;
		#20;
    // Display results after 20 time units $
    $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Apply a 20-time unit delay; think of it as the system machine cycle
	  a = 16'hffff;
	  b = 2*b;
	  cin = 1'b1;
	  // Apply a 20-time unit delay; think of it as the system machine cycle
      #20
      // Display results after 20 time units $
      $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    end
    a = 16'h0001;
    b = 16'hffff;
		cin = 1'b0;
		#20;
    // Display results after 20 time units $
    $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Apply a 20-time unit delay; think of it as the system machine cycle
	  b = 16'hffff;
	  a = 2*a;
	  cin = 1'b0;
	  // Apply a 20-time unit delay; think of it as the system machine cycle
      #20
      // Display results after 20 time units $
      $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    end
    
    b = 16'hffff;
    a = 16'h0001;
		cin = 1'b1;
		#20;
    // Display results after 20 time units $
    $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Apply a 20-time unit delay; think of it as the system machine cycle
	  b = 16'hffff;
	  a = 2*a;
	  cin = 1'b1;
	  // Apply a 20-time unit delay; think of it as the system machine cycle
      #20
      // Display results after 20 time units $
      $display("%t: RST_N=%b, a=%h, b=%h, cin=%b, cout=%b, s=%h", $time, RST_N, a, b, cin, cout, s);
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
