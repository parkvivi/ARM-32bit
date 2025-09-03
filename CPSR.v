module CPSR
(
// Entradas :: Novas Flags Calculadas 
input wire [3:0] NovasFlags,

// Entradas :: Sinais de Controle
input wire CTRLEscritaCPSR,
input wire CLK,

// Saídas :: Flags NZCV
output reg [3:0] FlagsNZCV
);
					
	always @ (posedge CLK)
		begin
		if (CTRLEscritaCPSR == 1'b1)
			begin
			FlagsNZCV <= NovasFlags;
			end
		end
		
endmodule 