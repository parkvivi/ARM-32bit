module Integracao
(
// Entradas
input wire [7:0] ChaveDado,
input wire CLKFPGA, ChaveClock, ChaveReset,

// Saídas
output wire [27:0] Segmentos,
output wire LEDIN
);
	
	// Conexões Intermediárias
	wire [31:0] NovoEndereco, EnderecoAtual, ProximoEndereco, Instrucao;
	wire [31:0] DadoEntrada, DadoRegLeitura1, DadoRegLeitura2, DadoSelecionado, DadoRegEscrita, SaidaULA, DadoMemoria;
	wire [31:0] EndSelecionado;
	wire [31:0] Imediato;
	wire [7:0] Opcode;
	wire [4:0] RN, RM, RD;
	wire [3:0] Cond, NovasFlags, FlagsNZCV;
	wire Inibe;
	
	// Conexões Intermediárias :: Sinais de Controle
	wire [3:0] CTRLOpULA;
	wire [1:0] CTRLDesvio, CTRLDadoImediato, CTRLEndMem, CTRLDadoReg;
	wire CTRLEscritaReg, CTRLEscritaCPSR, CTRLEscritaMem, CTRLHalt, CTRLSaida, CTRLCLK;
	
	// Conexões Intermediárias :: Clock
	wire CLK, CLKManual;
	
	// Parâmetros
	localparam Zero = 32'b0, Um = 32'b00000000000000000000000000000001;
		
	PC PC	(
			.CTRLHalt(CTRLHalt),
			.CLK(CLK),
			.Reset(ChaveReset),
			.NovoEndereco(NovoEndereco),
			.EnderecoAtual(EnderecoAtual)
			);
			
	Adder ADD	(
					.Dado1(EnderecoAtual),
					.Dado2(Um),
					.Soma(ProximoEndereco)
					);
					
	MUX MUX1	(
				.Dado1(ProximoEndereco),
				.Dado2(Imediato),
				.Dado3(DadoRegLeitura1),
				.Dado4(Zero),
				.Selecao(CTRLDesvio),
				.DadoSaida(NovoEndereco)
				);
	
	MemInstrucoes MemInstrucoes	(	
											.EnderecoAtual(EnderecoAtual), 
											.CLK(CLK), 
											.Instrucao(Instrucao)
											);
											
	UnidadeDecodificacao UnidadeDecodificacao	(	
															.Instrucao(Instrucao),
															.Cond(Cond),
															.Opcode(Opcode),
															.RN(RN),
															.RM(RM),
															.RD(RD),
															.Imediato(Imediato)
															);
	
	BancoRegistradores BancoRegistradores	(	
														.RN(RN),
														.RM(RM),
														.RD(RD),
														.DadoRegEscrita(DadoRegEscrita),	
														.CTRLEscritaReg(CTRLEscritaReg),
														.CLK(CLK),					
														.DadoRegLeitura1(DadoRegLeitura1),
														.DadoRegLeitura2(DadoRegLeitura2)
														);
	
	Entrada Entrada	(
							.Chaves(ChaveDado),
							.Dado(DadoEntrada)
							);
	
	MUX MUX2	(	
				.Dado1(DadoRegLeitura2),
				.Dado2(Imediato),
				.Dado3(DadoEntrada),
				.Dado4(Zero),
				.Selecao(CTRLDadoImediato),
				.DadoSaida(DadoSelecionado)
				);
				
	Saida Saida	(
					.DadoEntrada(DadoRegLeitura1),
					.CTRLSaida(CTRLSaida),
					.CLK(CLK),
					.Segmentos(Segmentos)
					);
	
	ULA ULA	(	
				.Dado1(DadoRegLeitura1),
				.Dado2(DadoSelecionado),
				.CTRLOpULA(CTRLOpULA),
				.SaidaULA(SaidaULA),
				.NovasFlags(NovasFlags)
				);
	
	CPSR CPSR	(	
					.NovasFlags(NovasFlags),
					.CTRLEscritaCPSR(CTRLEscritaCPSR),
					.CLK(CLK),
					.FlagsNZCV(FlagsNZCV)
					);
	
	MUX MUX3	(
				.Dado1(Imediato),
				.Dado2(DadoRegLeitura1),
				.Dado3(Zero),
				.Dado4(SaidaULA),
				.Selecao(CTRLEndMem),
				.DadoSaida(EndSelecionado)
				);
				
	MemPrincipal MemPrincipal	(
										.EndLeitura(EndSelecionado),
										.EndEscrita(EndSelecionado),
										.DadoMemEscrita(DadoRegLeitura2),
										.CTRLEscritaMem(CTRLEscritaMem),
										.CLK(CLK),
										.DadoMemoria(DadoMemoria)
										);
										
	MUX MUX4	(
				.Dado1(DadoMemoria),
				.Dado2(SaidaULA),
				.Dado3(DadoSelecionado),
				.Dado4(ProximoEndereco),
				.Selecao(CTRLDadoReg),
				.DadoSaida(DadoRegEscrita)
				);
				
	UnidadeValidacao UnidadeValidacao	(
													.Cond(Cond),
													.FlagsNZCV(FlagsNZCV),
													.Inibe(Inibe)
													);
	
	UnidadeControle UnidadeControle	(
												.Opcode(Opcode),
												.Inibe(Inibe),
												.CTRLDesvio(CTRLDesvio),
												.CTRLDadoImediato(CTRLDadoImediato),
												.CTRLEndMem(CTRLEndMem),
												.CTRLDadoReg(CTRLDadoReg),
												.CTRLEscritaReg(CTRLEscritaReg),
												.CTRLEscritaCPSR(CTRLEscritaCPSR),
												.CTRLEscritaMem(CTRLEscritaMem),
												.CTRLOpULA(CTRLOpULA),
												.CTRLHalt(CTRLHalt),
												.CTRLSaida(CTRLSaida),
												.CTRLCLK(CTRLCLK),
												.LEDIN(LEDIN)
												);
												
	SeletorClock SeletorClock	(
										.CLKFPGA(CLKFPGA),
										.CLKManual(CLKManual),
										.CTRLCLK(CTRLCLK),
										.CLK(CLK)
										);
	
	Debounce Debounce	(
							.CLKFPGA(CLKFPGA),
							.ChaveClock(ChaveClock),
							.CLKManual(CLKManual)
							);

endmodule 