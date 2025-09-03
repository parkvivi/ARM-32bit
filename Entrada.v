module Entrada
(
// Entradas :: Chaves FPGA
input wire [7:0] Chaves,

// Saidas :: Dado
output reg [31:0] Dado
);

	always @ (*)
		begin
		Dado <= {24'b0, Chaves[7:0]};
		end

endmodule 