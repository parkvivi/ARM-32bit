module Debounce
(
input wire CLKFPGA, ChaveClock,
output reg CLKManual
);
	
	reg [23:0] Contador;
	
	initial
		begin
		Contador = 24'b0;
		end
	
	always @ (posedge CLKFPGA)
		begin
		if (ChaveClock == 1'b1)
			begin
			if (Contador == 24'd500000)
				begin
				CLKManual <= 1'b1;
				Contador <= 24'b0;
				end
			else
				begin
				Contador <= Contador + 1'b1;
				end
			end
		else
			begin
			CLKManual <= 1'b0;
			Contador <= 24'b0;
			end
		end
		
endmodule 