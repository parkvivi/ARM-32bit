module MUX
(
// Entradas :: Dados
input wire [31:0] Dado1, Dado2, Dado3, Dado4,

// Entradas :: Entrada de Seleção
input wire [1:0] Selecao,

// Saídas :: Dado de Saída
output reg [31:0] DadoSaida
);

	always @ (*)
		begin
		case (Selecao[1:0])
			2'b00:	DadoSaida <= Dado1;
			2'b01:	DadoSaida <= Dado2;
			2'b10:	DadoSaida <= Dado3;
			2'b11:	DadoSaida <= Dado4;
		endcase
		end
					
endmodule 