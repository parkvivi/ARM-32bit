# ARM-32bit
🌐 **[EN]:** This repository contains a 32-bit ARM processor developed as an activity for the Computer Systems Laboratory: Computer Architecture and Organization course, at ICT Unifesp, in 2025-1. 

🌐 **[PT-BR]:** Este repositório contém um processador ARM de 32 bits desenvolvido como atividade na disciplina Laboratório de Sistemas Computacionais: Arquitetura e Organização de Computadores, no ICT Unifesp, em 2025-1.

## Visão Geral | Overview
🌐 **[EN]:** <ins>32-bit ARM architecture monocycle processor</ins> with <ins>32 general-purpose registers</ins> and <ins>4 ways of addressing memory</ins>. An <ins>FPGA interface system</ins> was also developed, which contains input, output, debouncing and clock selection modules. 

🌐 **[PT-BR]:** Processador de <ins>arquitetura ARM</ins> <ins>monociclo</ins> de <ins>32 bits</ins>, com <ins>32 registradores de propósito geral</ins> e <ins>4 tipos de endereçamento à memória</ins>. Foi desenvolvido também um <ins>sistema de interface com FPGA</ins>, que contém módulos de entrada, saída, _debouncing_ e seleção de _clock_.

## CPU Structure | Estrutura do Processador
![ARM_Monociclo](https://github.com/user-attachments/assets/7aaaeba3-b9df-49ce-b50a-560830d5e8b5)

## Functional Units | Unidades Funcionais
### Standard Modules | Módulos Padrão
- [Program Counter (PC) | Contador de Programa](PC.v): Registrador de uso específico, guarda endereço da instrução executada
- [Instruction Memory | Memória de Instruções](MemInstrucoes.v): Memória ROM que guarda o programa sendo executado
- [Decoding Unit | Unidade de Decodificação](UnidadeDecodificacao.v): Unidade responável por decodificar instruções
- [Registers | Banco de Registradores](BancoRegistradores.v): Memória que guarda os registradores de propósito geral
- [Arithmetic Logic Unit | Unidade Lógica e Aritmética (ULA)](ULA.v): Unidade responsável pelos cálculos lógicos e aritméticos
- [Current Program Status Register (CPSR)](CPSR.v): Registrador de uso específico, utilizado na lógica de execução condicional de instruções
- [Data Memory | Memória de Dados](MemPrincipal.v): Memória principal (RAM)
- [Validation Unit | Unidade de Validação](UnidadeValidacao.v): Unidade responsável por comparar _flags_ do CPSR com o campo _cond_ da instrução
- [Control Unit | Unidade de Controle](UnidadeControle.v): Unidade gerenciadora de sinais de controle
- [Adder (ADD) | Somador](Adder.v): Unidade de soma
- [Multiplexer | Multiplexador (MUX)](MUX.v): Unidade multiplexadora de valores

### FPGA Interface System Modules | Módulos do Sistema de Interface com FPGA
- [Input | Entrada](Entrada.v): Unidade responsável por ler dados de entrada da placa FPGA
- [Output | Saída](Saida.v): Unidade responsável por fazer o display de um dado na placa FPGA, composto pelas unidades de decodificação de [número binário em código BCD](BinarioBCD.v) e de [código BCD para display de 7 segmentos](BCD7Seg.v)
- [Debouncing](Debounce.v): Unidade que trata de trepidações dos dispositivos de entrada (botões e chaves)
- [Clock Selector | Seletor de _Clock_](SeletorClock.v): Unidade que faz a troca do _clock_ interno do processador para um dispositivo de entrada mediante à execução de uma instrução IN

### Integration | Integração
- [Integration | Integração](Integracao.v): Arquivo que integra todas as unidades individuais desenvolvidas a fim de construir uma unidade de processamento funcional

## Instruction Set | Conjunto de Instruções
🌐 **[EN]:** This CPU supports an adapted instruction set based on the ARM and A32 instruction sets for ARMv5 and ARMv8/v9-A architectures, respectively. 4 types of instructions were defined.

🌐 **[PT-BR]:** Este processador tem suporte para um conjunto de instruções adaptado baseado nos conjuntos de instruções ARM e A32 das arquiteturas ARMv5 e ARMv8/v9-A, respectivamente. Foram definidos 4 tipos de instruções.

1. ⌛ **Data Processing Instructions (D-Type) | Instruções de Processamento de Dados (Tipo D)**
   - Realizam operações lógicas e aritméticas ou movimentam dados
2. 🔀 **Branch Instructions (B-Type) | Instruções de Desvio (Tipo B)**
   - Realizam saltos, a princípio incondicionais
3. 💾 **Memory Access Instructions (M-Type) | Instruções de Acesso à Memória (Tipo M)**
   - Acessam a memória de 4 maneiras diferentes (endereçamentos imediato, direto, indireto por registrador e deslocamento imediato)
4. ⚠️ **Alternative Instructions (A-Type) | Instruções Alternativas (Tipo A)**
   - Não se encaixam em outras categorias (interrompem o fluxo do programa, comunicação externa)

## More Information | Mais Informações 
[![Abrir Relatório](https://img.shields.io/badge/📄_(PT%20BR)%20Abrir%20Relatório-green?style=for-the-badge)](Relatorio.pdf)
