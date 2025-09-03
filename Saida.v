module Saida
(
// Entradas :: Dado
input wire [31:0] DadoEntrada,

// Entradas :: Sinais de Controle
input wire CTRLSaida, CLK,

// Saídas :: LEDs dos Displays de 7 Segmentos
output wire [27:0] Segmentos
);
	
	wire [3:0] MilharBCD, CentenaBCD, DezenaBCD, UnidadeBCD;
	reg [31:0] DadoSaida;
	
	initial
		begin
		DadoSaida = 32'd0;
		end
		
	always @ (posedge CLK)
		begin
		if (CTRLSaida == 1'b1)
			begin
			DadoSaida <= DadoEntrada;
			end
		end
	
	BinarioBCD BinarioBCD	(
									.Dado(DadoSaida[13:0]),
									.Milhar(MilharBCD),
									.Centena(CentenaBCD),
									.Dezena(DezenaBCD),
									.Unidade(UnidadeBCD)
									);
	
	BCD7Seg Milhar		(
							.BCD(MilharBCD),
							.Segmentos(Segmentos[27:21])
							);
	
	BCD7Seg Centena	(
							.BCD(CentenaBCD),
							.Segmentos(Segmentos[20:14])
							);
							
	BCD7Seg Dezena		(
							.BCD(DezenaBCD),
							.Segmentos(Segmentos[13:7])
							);
							
	BCD7Seg Unidade	(
							.BCD(UnidadeBCD),
							.Segmentos(Segmentos[6:0])
							);

endmodule 