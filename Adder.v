module Adder
(
// Entradas :: Dados
input wire [31:0] Dado1, Dado2,

// Saída :: Soma
output reg [31:0] Soma
);

	always @ (*)
		begin
		Soma <= Dado1 + Dado2;
		end
						
endmodule 