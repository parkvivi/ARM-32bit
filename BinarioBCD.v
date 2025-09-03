module BinarioBCD
(
// Entradas :: Dado de 8 Bits
input wire [13:0] Dado,

// Saídas :: BCD
output reg [3:0] Milhar, Centena, Dezena, Unidade
);

	always @ (*) 
		begin
		Milhar  <= Dado / 1000;
		Centena <= (Dado % 1000) / 100;
		Dezena  <= ((Dado % 1000) % 100) / 10;
		Unidade <= ((Dado % 1000) % 100) % 10;
		end

endmodule 