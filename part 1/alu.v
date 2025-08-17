module alu(CLK, RST_N, A, B, CIN, SEL, Y);
  input CLK, RST_N;
	input [7:0] A, B;
  input CIN;
  input [3:0] SEL;
  output reg [7:0] Y;
	reg [7:0] A_reg;
	reg [7:0] B_reg;
	reg CIN_reg;
	reg [7:0] y_int;
  reg [7:0] arithval;
  reg [7:0] logicval;
  // Arithmetic unit
  always @(A_reg or B_reg or CIN_reg or SEL) begin
    case (SEL[2:0])
      3'b000  : arithval = A_reg;
      3'b001  : arithval = A_reg + 1;
      3'b010  : arithval = A_reg - 1;
      3'b011  : arithval = B_reg;
      3'b100  : arithval = B_reg + 1;
      3'b101  : arithval = B_reg - 1;
      3'b110  : arithval = A_reg + B_reg;
      default : arithval = A_reg + B_reg + CIN_reg;
    endcase
  end
  // Logic unit
  always @(A_reg or B_reg or SEL) begin
    case (SEL[2:0])
      3'b000  : logicval =  ~A_reg;
      3'b001  : logicval =  ~B_reg;
      3'b010  : logicval = A_reg & B_reg;
      3'b011  : logicval = A_reg | B_reg;
      3'b100  : logicval =  ~((A_reg & B_reg));
      3'b101  : logicval =  ~((A_reg | B_reg));
      3'b110  : logicval = A_reg ^ B_reg;
      default : logicval =  ~(A_reg ^ B_reg);
    endcase
  end
  // Multiplexer
  always @(arithval or logicval or SEL) begin
    case (SEL[3])
      1'b0    : y_int = arithval;
      default : y_int = logicval;
    endcase
  end
	
	//Registering the data in and out on posedge of clk
	always @(posedge CLK or negedge RST_N)
	if (RST_N == 1'b0) //Active low reset because of the std cell library
	begin
		A_reg <= 8'b0;
		B_reg <= 8'b0;
		CIN_reg <= 1'b0;
		Y <= 8'b0;
	end
	else
	begin
		A_reg <= A;
		B_reg <= B;
		CIN_reg <= CIN;
	 	Y <= y_int;
	end
endmodule
