module BCD7Seg	
(
// Entradas :: BCD
input wire [3:0] BCD,

// Saídas :: LEDs do Display de 7 Segmentos
output reg [6:0] Segmentos
);

	always @ (*) 
		begin
		case(BCD[3:0])
			4'b0000: Segmentos = 7'b1000000;
			4'b0001: Segmentos = 7'b1111001;
			4'b0010: Segmentos = 7'b0100100;
			4'b0011: Segmentos = 7'b0110000;
			4'b0100: Segmentos = 7'b0011001;
			4'b0101: Segmentos = 7'b0010010;
			4'b0110: Segmentos = 7'b0000010;
			4'b0111: Segmentos = 7'b1111000;
			4'b1000: Segmentos = 7'b0000000;
			4'b1001: Segmentos = 7'b0011000;
			default: Segmentos = 7'b1111111;
		endcase
		end

endmodule 