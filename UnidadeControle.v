module UnidadeControle
(
// Entradas :: Opcode & Inibe
input wire [7:0] Opcode,
input wire Inibe,

// Saídas :: Sinais de Controle :: MUX
output reg [1:0] CTRLDesvio, CTRLDadoImediato, CTRLEndMem, CTRLDadoReg,

// Saídas :: Sinais de Controle :: Escrita
output reg CTRLEscritaReg, CTRLEscritaCPSR, CTRLEscritaMem, CTRLSaida,

// Saídas :: Sinais de Controle :: ULA
output reg [3:0] CTRLOpULA,

// Saídas :: Sinais de Controle :: Halt & Clock
output reg CTRLHalt, CTRLCLK,

// Saídas :: LED Instrução IN
output reg LEDIN
);
	
	// Parâmetros Auxiliares :: Tipos de Instruções
	localparam 	TipoD = 2'b00, TipoB = 2'b01, TipoM = 2'b10, TipoA = 2'b11;
	
	// Parâmetros Auxiliares :: Instruções do Tipo D
	localparam	ADD = 5'b00000, ADDS = 5'b00001, SUB  = 5'b00010, SUBS = 5'b00011, 
					RSB = 5'b00100, MUL  = 5'b00101, UDIV = 5'b00110, NOT  = 5'b00111, 
					AND = 5'b01000, ORR  = 5'b01001, EOR  = 5'b01010, MOV  = 5'b01011, 
					CMP = 5'b01100;
	
	// Parâmetros Auxiliares :: Instruções do Tipo B
	localparam	B = 2'b00, BX = 2'b01, BL = 2'b10;
	
	// Parâmetros Auxiliares :: Instruções do Tipo M
	localparam 	LDRImediato = 2'b10;
	
	// Parâmetros Auxiliares :: Instruções do Tipo A
	localparam	HLT = 4'b0001, IN = 4'b0010, OUT = 4'b0011;
	
	always @ (*)
		begin
		LEDIN <= 1'b0;
		if (Inibe == 1'b0)
			begin
			case (Opcode[7:6])
				TipoD:	begin
							case (Opcode[4:0])
								ADD:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0000;
											CTRLEscritaReg <=	1'b1;
											end
								ADDS:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b1;
											CTRLOpULA 		<= 4'b0000;
											CTRLEscritaReg <=	1'b1;
											end
								SUB:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0001;
											CTRLEscritaReg <=	1'b1;
											end
								SUBS:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b1;
											CTRLOpULA 		<= 4'b0001;
											CTRLEscritaReg <=	1'b1;
											end
								RSB:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b1;
											CTRLOpULA 		<= 4'b0010;
											CTRLEscritaReg <=	1'b1;
											end
								MUL:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0011;
											CTRLEscritaReg <=	1'b1;
											end
								UDIV:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0100;
											CTRLEscritaReg <=	1'b1;
											end
								NOT:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0101;
											CTRLEscritaReg <=	1'b1;
											end
								AND:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0110;
											CTRLEscritaReg <=	1'b1;
											end
								ORR:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0111;
											CTRLEscritaReg <=	1'b1;
											end
								EOR:		begin
											CTRLDadoReg 	<= 2'b01;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b1000;
											CTRLEscritaReg <=	1'b1;
											end
								MOV:		begin
											CTRLDadoReg 	<= 2'b10;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0000;
											CTRLEscritaReg <=	1'b1;
											end
								CMP:		begin
											CTRLDadoReg 	<= 2'b00;
											CTRLEscritaCPSR<= 1'b1;
											CTRLOpULA 		<= 4'b0001;
											CTRLEscritaReg <=	1'b0;
											end
								default:	begin
											CTRLDadoReg 	<= 2'b00;
											CTRLEscritaCPSR<= 1'b0;
											CTRLOpULA 		<= 4'b0000;
											CTRLEscritaReg <=	1'b0;
											end
							endcase
							CTRLDesvio 			<= 2'b00;
							CTRLHalt 			<=	1'b0;
							CTRLEscritaMem 	<= 1'b0;
							CTRLEndMem 			<=	2'b00;
							CTRLDadoImediato 	<=	{1'b0, Opcode[5]};
							CTRLSaida			<= 1'b0;
							CTRLCLK				<= 1'b0;
							end
				TipoB:	begin
							case (Opcode[5:4])
								B:			begin
											CTRLDesvio 		<= 2'b01;
											CTRLEscritaReg <=	1'b0;
											end
								BX:		begin
											CTRLDesvio 		<= 2'b10;
											CTRLEscritaReg <=	1'b0;
											end
								BL:		begin
											CTRLDesvio 		<= 2'b01;
											CTRLEscritaReg <=	1'b1;
											end
								default: begin
											CTRLDesvio 		<= 2'b00;
											CTRLEscritaReg <=	1'b0;
											end
							endcase
							CTRLHalt 			<=	1'b00;
							CTRLDadoReg 		<= 2'b11;
							CTRLEscritaMem 	<= 1'b0;
							CTRLEndMem 			<=	2'b00;
							CTRLEscritaCPSR 	<= 1'b0;
							CTRLOpULA 			<= 4'b0000;
							CTRLDadoImediato 	<=	2'b00;
							CTRLSaida			<= 1'b0;
							CTRLCLK				<= 1'b0;
							end
				TipoM:	begin
							if (Opcode[4:3] == LDRImediato)
								begin
								CTRLDadoReg 	<= Opcode[4:3];
								end
							else
								begin
								CTRLDadoReg 	<= 2'b00;
								end
							CTRLDesvio 			<= 2'b00;
							CTRLHalt 			<=	1'b0;
							CTRLEscritaMem 	<= Opcode[5];
							CTRLEndMem 			<=	Opcode[4:3];
							CTRLEscritaCPSR 	<= 1'b0;
							CTRLOpULA 			<= 4'b0000;
							CTRLDadoImediato 	<=	2'b01;
							CTRLEscritaReg 	<=	~Opcode[5];
							CTRLSaida			<= 1'b0;
							CTRLCLK				<= 1'b0;
							end
				TipoA:	begin
							case (Opcode[5:2])
									HLT:	begin
											CTRLHalt 		<=	1'b1;
											CTRLEscritaReg <=	1'b0;
											CTRLSaida		<= 1'b0;
											CTRLCLK			<= 1'b0;
											end
									IN:	begin
											CTRLHalt 		<=	1'b0;
											CTRLEscritaReg <=	1'b1;
											CTRLSaida		<= 1'b0;
											CTRLCLK			<= 1'b1;
											LEDIN 			<= 1'b1;
											end
									OUT:	begin
											CTRLHalt 		<=	1'b0;
											CTRLEscritaReg <=	1'b0;
											CTRLSaida		<= 1'b1;
											CTRLCLK			<= 1'b0;
											end
								default:	begin
											CTRLHalt 		<=	1'b0;
											CTRLEscritaReg <=	1'b0;
											CTRLSaida		<= 1'b0;
											CTRLCLK			<= 1'b0;
											end
							endcase
							CTRLDesvio 			<= 2'b00;
							CTRLDadoReg 		<= 2'b10;
							CTRLEscritaMem 	<= 1'b0;
							CTRLEndMem 			<=	2'b00;
							CTRLEscritaCPSR 	<= 1'b0;
							CTRLOpULA 			<= 4'b0000;
							CTRLDadoImediato 	<=	2'b10;
							end
				default:	begin
							CTRLDesvio 			<= 2'b00;
							CTRLHalt 			<=	1'b0;
							CTRLDadoReg 		<= 2'b00;
							CTRLEscritaMem 	<= 1'b0;
							CTRLEndMem 			<=	2'b00;
							CTRLEscritaCPSR 	<= 1'b0;
							CTRLOpULA 			<= 4'b0000;
							CTRLDadoImediato 	<=	2'b00;
							CTRLEscritaReg 	<=	1'b0;
							CTRLSaida			<= 1'b0;
							CTRLCLK				<= 1'b0;
							end
			endcase
			end
		else
			begin
			CTRLDesvio 			<= 2'b00;
			CTRLHalt 			<=	1'b0;
			CTRLDadoReg 		<= 2'b00;
			CTRLEscritaMem 	<= 1'b0;
			CTRLEndMem 			<=	2'b00;
			CTRLEscritaCPSR 	<= 1'b0;
			CTRLOpULA 			<= 4'b0000;
			CTRLDadoImediato 	<=	2'b00;
			CTRLEscritaReg 	<=	1'b0;
			CTRLSaida			<= 1'b0;
			CTRLCLK				<= 1'b0;
			end
		end

endmodule 