module PC 
(
// Entradas :: Endereço da Nova Instrução
input wire [31:0] NovoEndereco,

// Entradas :: Sinais de Controle
input wire CLK, CTRLHalt, Reset,

// Saídas :: Endereço da Instrução Atual	
output reg [31:0] EnderecoAtual
);
	
	initial
		begin
		EnderecoAtual = 32'b0;
		end

	always @ (posedge CLK)
		begin
		if (CTRLHalt == 1'b0)
			begin
			EnderecoAtual <= NovoEndereco;
			end
		if (Reset == 1'b1)
			begin
			EnderecoAtual <= 32'b0;
			end
		end

endmodule 