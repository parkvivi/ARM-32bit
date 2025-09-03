module UnidadeDecodificacao
(	
// Entradas :: Instrução Atual
input wire [31:0] Instrucao, 

// Saídas :: Cond & Opcode
output reg [3:0] Cond, 
output reg [7:0] Opcode,

// Saídas :: Registradores
output reg [4:0] RN, RD, RM,

// Saídas :: Offset/Imediato
output reg [31:0] Imediato	
);
	
	// Parâmetros :: Tipos de Dados
	localparam 	TipoD = 2'b00, TipoB = 2'b01, 
					TipoM = 2'b10, TipoA = 2'b11;
	
	localparam	RegVazio = 5'b00000, LR = 5'b11111;

	always @ (*)
		begin
		case (Instrucao[27:26])
			TipoD:
				begin
				Cond 		= Instrucao[31:28];
				Opcode 	= Instrucao[27:20];
				RN			= Instrucao[19:15];
				RD			= Instrucao[14:10];
				RM			= Instrucao[9:5];
				Imediato	= {22'b0, Instrucao[9:0]};
				end
			TipoB:
				begin
				Cond 		= Instrucao[31:28];
				Opcode 	= {Instrucao[27:24], 4'b0};
				RN			= Instrucao[23:19];
				RD			= LR;
				RM			= RegVazio;
				Imediato	= {13'b0, Instrucao[18:0]};
				end
			TipoM:
				begin
				Cond 		= Instrucao[31:28];
				Opcode 	= {Instrucao[27:23], 3'b0};
				RN			= Instrucao[22:18];
				RD			= Instrucao[17:13];
				RM			= Instrucao[17:13];
				Imediato	= {19'b0, Instrucao[12:0]};
				end
			TipoA:
				begin
				Cond 		= Instrucao[31:28];
				Opcode 	= {Instrucao[27:22], 2'b0};
				RN			= Instrucao[21:17];
				RD			= Instrucao[21:17];
				RM			= RegVazio;
				Imediato	= 32'b0;
				end
		endcase
		end
		
endmodule 