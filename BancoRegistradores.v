module BancoRegistradores
(
// Entradas :: Registradores de Leitura
input wire [4:0] RN, RM,

// Entradas :: Dados para Escrita
input wire [4:0] RD, 
input wire [31:0] DadoRegEscrita,

// Entradas :: Sinais de Controle
input wire CTRLEscritaReg, CLK, 

// Saídas :: Dados Lidos
output reg [31:0] DadoRegLeitura1, DadoRegLeitura2
);

	// Variáveis Auxiliares :: Banco de Registradores
	reg [31:0] Registradores[31:0];
	
	always @ (*)
		begin
		DadoRegLeitura1 <= Registradores[RN];
		DadoRegLeitura2 <= Registradores[RM];
		end
		
	always @ (posedge CLK)
		begin
		if (CTRLEscritaReg == 1'b1)
			begin
			Registradores[RD] <= DadoRegEscrita;
			end
		end
		
endmodule 