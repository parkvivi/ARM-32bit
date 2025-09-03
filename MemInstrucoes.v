module MemInstrucoes
(	// Entradas :: Endereço da Instrução Atual
	input [31:0] EnderecoAtual,
	
	// Entradas :: Sinais de Controle
	input CLK, 
	
	// Saídas :: Instrução Atual
	output reg [31:0] Instrucao
);

	// Variáveis Auxiliares :: Memória ROM
	reg [31:0] rom[21:0];

	initial
		begin
		$readmemb("MemInstrDados.txt", rom);
		end

	always @ (negedge CLK)
		begin
		Instrucao <= rom[EnderecoAtual];
		end

endmodule 