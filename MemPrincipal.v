module MemPrincipal
(	// Entradas :: Endereços para Leitura e Escrita
	input [7:0] EndLeitura, EndEscrita,	

	// Entradas :: Dado para Escrita
	input [31:0] DadoMemEscrita,
	
	// Entradas :: Sinais de Controle
	input CTRLEscritaMem, CLK,
	
	// Saída :: Dado Lido
	output reg [31:0] DadoMemoria
);
	
	// Variáveis Auxiliares :: Memória
	reg [31:0] ram[7:0];
	
	always @ (*)
		begin
		DadoMemoria = ram[EndLeitura];
		end
		
	always @ (posedge CLK)
		begin
		if (CTRLEscritaMem == 1'b1)
			ram[EndEscrita] <= DadoMemEscrita;
		end
	
endmodule 