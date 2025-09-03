module UnidadeValidacao
(
// Entradas
input wire [3:0] Cond, FlagsNZCV,

// Saídas
output reg Inibe
);
	
	localparam	EQ = 4'b0000, NE = 4'b0001, CS = 4'b0010, CC = 4'b0011, MI = 4'b0100,
					PL = 4'b0101, VS = 4'b0110, VC = 4'b0111, HI = 4'b1000, LS = 4'b1001,
					GE = 4'b1010, LT = 4'b1011, GT = 4'b1100, LE = 4'b1101;
	
	always @ (*)
		begin
		case(Cond[3:0])
			EQ:	begin
					if (FlagsNZCV[2] == 1'b1)												// Z == 1				
						begin Inibe <= 1'b0; end
					else
						begin Inibe <= 1'b1; end
					end
			NE:	begin
					if (FlagsNZCV[2] == 1'b0)												// Z == 0
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			CS:	begin
					if (FlagsNZCV[1] == 1'b1)												// C == 1
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			CC:	begin
					if (FlagsNZCV[1] == 1'b0)												// C == 0
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			MI:	begin
					if (FlagsNZCV[3] == 1'b1)												// N == 1
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			PL:	begin
					if (FlagsNZCV[3] == 1'b0)												// N == 0
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			VS:	begin
					if (FlagsNZCV[0] == 1'b1)												// V == 1
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			VC:	begin
					if (FlagsNZCV[0] == 1'b0)												// V == 0
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			HI:	begin
					if (FlagsNZCV[1] == 1'b1 && FlagsNZCV[2] == 1'b0)				// C == 1 && Z == 0
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			LS:	begin
					if (FlagsNZCV[1] == 1'b0 || FlagsNZCV[2] == 1'b1)				// C == 0 || Z == 1
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			GE:	begin
					if (FlagsNZCV[3] == FlagsNZCV[0])									// N == V
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			LT:	begin
					if (FlagsNZCV[3] != FlagsNZCV[0])									// N != V
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			GT:	begin																	
					if (FlagsNZCV[2] == 1'b0 && FlagsNZCV[3] == FlagsNZCV[0])	// Z == 0 && N == V
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			LE:	begin																	
					if (FlagsNZCV[2] == 1'b1 || FlagsNZCV[3] != FlagsNZCV[0])	// Z == 1 || N != V
						begin Inibe <= 1'b0;	end
					else
						begin Inibe <= 1'b1;	end
					end
			default:	begin Inibe <= 1'b0; end
		endcase
		end
		
endmodule 