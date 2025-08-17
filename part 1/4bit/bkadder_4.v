module bkadder_4(CLK, RST_N, A, B, CIN, Ain, Bin, G, P, COUT, S);//4 brent kung adder
  //inputs
  input CLK, RST_N;
	input [3:0] A, B;
  input CIN;
  //outputs
  output reg [3:0] G;
  output reg [3:0] P;
  output reg [3:0] S;
  output reg [4:0] COUT;
	//intermediate values
	reg [3:0] A_reg;
	reg [3:0] B_reg;
	reg CIN_reg;
	//start level
	reg [3:0] g;
	reg [3:0] p;
	//-------------------------------------------------------------------------------
	//level 1 outputs
	reg G3_2;
	reg G1_0;
	
	reg P3_2;
	reg P1_0;
	//-------------------------------------------------------------------------------
	//level 2 outputs
	reg G3_0;
	
	reg P3_0;
	//-------------------------------------------------------------------------------
	//level 3 outputs
	reg G2_0;
	
	reg P2_0;
	//-------------------------------------------------------------------------------
	//carry level
	reg [4:0] C;
	//-------------------------------------------------------------------------------
	//output level
	reg [3:0] S_int;
	//-------------------------------------------------------------------------------
  
  always @(A_reg or B_reg or CIN_reg) begin
	//starting level
	g = A_reg & B_reg;
	p = A_reg | B_reg;
	//-------------------------------------------------------------------------------
	//level 1
	//generates
	G3_2   = g[3]  | (p[3]  & g[2] );
	G1_0   = g[1]  | (p[1]  & g[0] );
	//propagates
	P3_2   = p[3]  & p[2] ;
	P1_0   = p[1]  & p[0] ;
	//-------------------------------------------------------------------------------
	//level 2
	//generates
	G3_0   = G3_2   | (P3_2   & G1_0);
	//propagates
	P3_0   = P3_2   & P1_0;
	//-------------------------------------------------------------------------------
	//level 3
	//generates
	G2_0  = g[2]   | (p[4]   & G1_0);
	
	P2_0  = p[2]   & P1_0;
	//-------------------------------------------------------------------------------
	//carry level
	C[0]  = CIN_reg;
	C[1]  = g[0]   | (p[0]   & CIN_reg);
	C[2]  = G1_0   | (P1_0   & CIN_reg);
	C[3]  = G2_0   | (P2_0   & CIN_reg);
	C[4]  = G3_0   | (P3_0   & CIN_reg);
	//-------------------------------------------------------------------------------
    //output level
	S_int = (A_reg ^ B_reg) ^ C[3:0];
	//COUT = C[16];
  end
 
	//Registering the data in and out on posedge of clk
	always @(posedge CLK or negedge RST_N)
	if (RST_N == 1'b0) //Active low reset because of the std cell library
	begin
		A_reg <= 4'b0;
		B_reg <= 4'b0;
		CIN_reg <= 1'b0;
		S <= 4'b0;
		COUT <= 5'b0;
		G <= 4'b0;
		P <= 4'b0;
	end
	else
	begin
		A_reg <= A;
		B_reg <= B;
		CIN_reg <= CIN;
		G <= g;
		P <= p;
	 	S <= S_int;
		COUT <= C;
	end
endmodule
