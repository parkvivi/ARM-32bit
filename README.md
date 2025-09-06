# Unifesp-LabAOC
Este repositório contém os códigos em Verilog das unidades funcionais individuais e integradas de um processador ARM desenvolvido como atividade da disciplina Laboratório de Sistemas Computacionais: Arquitetura e Organização de Computadores em 2025-1.

## Características Gerais
Processador de <ins>arquitetura ARM</ins> <ins>monociclo</ins> de <ins>32 bits</ins>, com <ins>32 registradores de propósito geral</ins> e <ins>4 tipos de endereçamento à memória</ins>. Foi desenvolvido também um <ins>sistema de interface com FPGA</ins>, que contém módulos de entrada, saída, _debouncing_ e seleção de _clock_. Característico da arquitetura ARM, foi também implementada a <ins>execução condicional de instruções</ins>.

## Estrutura do Processador
![ARM_Monociclo](https://github.com/user-attachments/assets/7aaaeba3-b9df-49ce-b50a-560830d5e8b5)

## Unidades Funcionais
### Unidades de Processamento Clássicas
- [Contador de Programa (PC)](PC.v): Registrador de uso específico, guarda endereço da instrução executada
- [Memória de Instruções](MemInstrucoes.v): Memória ROM que guarda o programa sendo executado
- [Unidade de Decodificação](UnidadeDecodificacao.v): Unidade responável por decodificar instruções
- [Banco de Registradores](BancoRegistradores.v): Memória que guarda os registradores de propósito geral
- [Unidade Lógica e Aritmética (ULA)](ULA.v): Unidade responsável pelos cálculos lógicos e aritméticos
- [Current Program Status Register (CPSR)](CPSR.v): Registrador de uso específico, utilizado na lógica de execução condicional de instruções
- [Memória de Dados](MemPrincipal.v): Memória principal (RAM)
- [Unidade de Validação](UnidadeValidacao.v): Unidade responsável por comparar _flags_ do CPSR com o campo _cond_ da instrução
- [Unidade de Controle](UnidadeControle.v): Unidade gerenciadora de sinais de controle
- [Adder (ADD)](Adder.v): Unidade de soma
- [Multiplexador (MUX)](MUX.v): Unidade multiplexadora de valores

### Sistema de Interface com FPGA
- [Entrada](Entrada.v): Unidade responsável por ler dados de entrada da placa FPGA
- [Saída](Saida.v): Unidade responsável por fazer o display de um dado na placa FPGA, composto pelas unidades de decodificação de [número binário em código BCD](BinarioBCD.v) e de [código BCD para display de 7 segmentos](BCD7Seg.v)
- [_Debouncing_](Debounce.v): Unidade que trata de trepidações dos dispositivos de entrada (botões e chaves)
- [Seletor de _Clock_](SeletorClock.v): Unidade que faz a troca do _clock_ interno do processador para um dispositivo de entrada mediante à execução de uma instrução IN

### Unidades Integradas
- [Integração](Integracao.v): Arquivo que integra todas as unidades indivivuais desenvolvidas a fim de construir uma unidade de processamento funcional

## Conjunto de Instruções
O processador desenvolvido tem suporte para um conjunto de instruções adaptado, que contém 4 tipos de instruções.

1. **Instruções de Processamento de Dados - Tipo D**
   - Realizam operações lógicas e aritméticas ou movimentam dados
2. **Instruções de Desvio - Tipo B**
   - Realizam saltos, a princípio incondicionais
3. **Instruções de Acesso à Memória - Tipo M**
   - Acessam a memória de 4 maneiras diferentes (endereçamentos imediato, direto, indireto por registrador e deslocamento imediato)
4. **Instruções Alternativas - Tipo A**
   - Não se encaixam em outras categorias (interrompem o fluxo do programa, comunicação externa)

## Mais Informações 
[![Abrir Relatório](https://img.shields.io/badge/📄_Abrir%20Relatório-green?style=for-the-badge)](Relatorio.pdf)
