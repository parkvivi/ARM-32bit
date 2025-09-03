module ULA
(
// Entradas :: Dados
input wire [31:0] Dado1, Dado2,

// Entradas :: Sinais de Controle
input wire [3:0] CTRLOpULA, 

// Saídas
output wire [31:0] SaidaULA, 
output wire [3:0] NovasFlags
);
	
	// Variáveis e Parâmetros Auxiliares
	reg [32:0] AuxiliarCV;
	reg [31:0] SaidaAuxiliar;
	reg [1:0] FlagsAuxiliar;
	localparam Zero = 32'b0;
	
	// Parâmetros :: CTRLOpULA
	localparam 	Soma = 4'b0000, Sub1 = 4'b0001, Sub2 = 4'b0010, Mul  = 4'b0011,
					Div  = 4'b0100, Not = 4'b0101, And  = 4'b0110, Or   = 4'b0111, Xor  = 4'b1000;
	
	// Operações da ULA					
	always @ (CTRLOpULA or Dado1 or Dado2)
		begin
		FlagsAuxiliar[1:0] = 2'b0;
		case(CTRLOpULA[3:0])
			Soma: begin
					AuxiliarCV = {1'b0, Dado1} + {1'b0, Dado2};	
					SaidaAuxiliar = AuxiliarCV[31:0];
					FlagsAuxiliar[1] = AuxiliarCV[32];
					FlagsAuxiliar[0] = (Dado1[31] == Dado2[31]) && (SaidaAuxiliar[31] != Dado1[31]);
					end
			Sub1: begin	
					AuxiliarCV = {1'b0, Dado1} - {1'b0, Dado2};	
					SaidaAuxiliar = AuxiliarCV[31:0];
					FlagsAuxiliar[1] = ~AuxiliarCV[32];
					FlagsAuxiliar[0] = (Dado1[31] != Dado2[31]) && (SaidaAuxiliar[31] == Dado2[31]);
					end
			Sub2: begin	
					AuxiliarCV = {1'b0, Dado2} - {1'b0, Dado1};	
					SaidaAuxiliar = AuxiliarCV[31:0];
					FlagsAuxiliar[1] = ~AuxiliarCV[32];
					FlagsAuxiliar[0] = (Dado1[31] != Dado2[31]) && (SaidaAuxiliar[31] == Dado1[31]);
					end
			Mul: 	SaidaAuxiliar = Dado1 * Dado2;
			Div: 	SaidaAuxiliar = Dado1 / Dado2;
			Not:	SaidaAuxiliar = ~Dado2;
			And: 	SaidaAuxiliar = Dado1 & Dado2;
			Or: 	SaidaAuxiliar = Dado1 | Dado2;
			Xor: 	SaidaAuxiliar = Dado1 ^ Dado2;
			default: SaidaAuxiliar = Zero;
		endcase
		end
	
	// Atribuição de Valores às Saídas
	assign SaidaULA = SaidaAuxiliar;
	assign NovasFlags = {SaidaAuxiliar[31], (SaidaAuxiliar == Zero), FlagsAuxiliar[1:0]};
	
endmodule 