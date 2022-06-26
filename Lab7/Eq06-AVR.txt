# Projeto Calculadora Programável
### Equipe: Ernesto & Ellejeane [Equipe 06]

#### Codificação das instruções:

CÓDIGO | INSTRUÇÃO INTEIRA | FORMATO ASSEMBLY | INFO
-- | -- | -- | --
000 | `0000 0000 0000 0000` | nop | No OPeration (faz nada)
001 | `1111 01KK KKKK K001` | BRNE `K` | Pula para `PC` + `K` + `1` se `Z` for zero (`K` pode ser negativo ou positivo)
010 | `0000 11RD DDDD RRRR` | add `Rd`, `Rr` | `Rd` <= `Rd` + `Rr`
011 | `0001 10RD DDDD RRRR` | sub `Rd`, `Rr` | `Rd` <= `Rd` - `Rr`
100 | `0100 00RD DDDD RRRR` | rem `Rd`, `Rr` | `Rd` <= `Rd` % `Rr`
101 | `0010 11RD DDDD RRRR` | mov `Rd`, `Rr` | `Rd` <= `Rr`
110 | `1110 KKKK DDDD KKKK` | ldi `Rd`, `K` | escreve o valor `K` em `Rd` (limitado de `R1` a `R7`; `R0` faz nada)
111 | `1100 KKKK KKKK KKKK` | RJMP `K` | Pula para `PC` + `K` + `1` (`K` pode ser negativo ou positivo)

#### Legenda:
K: Constante 
D: Destino
R: Segundo parâmetro

#### Diferenças com AVR:
1. Para as instruções com 4 bits de endereço, AVR utiliza os registradores 16..31, mas no nosso caso optamos para 1..15 (0 é sempre zero)
2. No caso dos registradores, permanecemos com o conceito do $zero no registrador zero igual no MIPS.
3. AVR só permite 2 registradores por operação, então `A1` será o mesmo que o destino.
4. A operação #3 (`"11"`) foi definida como "retornar apenas o segundo argumento" para usar com o `mov`

#### Tarefa do professor:

Programa a ser realizado na ROM:

```
1. Carrega R4 (o registrador 4) com o valor 3
2. Carrega R5 com 7
3. Soma R4 com R5 e guarda em R7
4. Subtrai 2 de R7
5. Salta para o endereço 17
6. No endereço 17, copia R7 para R4
7. No endereço 18, calcula o resto da divisão de R7 por 3 e guarda em R6
8. Salta para a terceira instrução desta lista (R7 <- R4 + R5)
```

Versão escrita (assembly & binário)

LINHA | BINÁRIO | ASSEMBLY
-- | -- | --
00 | `1110 0000 0100 0011` | `ldi R4, #3` ; 1
01 | `1110 0000 0101 0111` | `ldi R5, #7` ; 2
02 | `1110 0000 0111 0000` | `ldi R7, #0` ; 3
03 | `0000 1100 0111 0100` | `add R7, R4`
04 | `0000 1100 0111 0101` | `add R7, R5`
05 | `1110 0000 0001 0010` | `ldi R1, #2` ; 4
06 | `0001 1000 0111 0001` | `sub R7, R1`
07 | `1100 0000 0000 1000` | `rjmp #8` ; 5 (8 relativo)
08 | `0000 0000 0000 0000` | `nop`
09 | `0000 0000 0000 0000` | `nop`
10 | `0000 0000 0000 0000` | `nop`
11 | `0000 0000 0000 0000` | `nop`
12 | `0000 0000 0000 0000` | `nop`
13 | `0000 0000 0000 0000` | `nop`
14 | `0000 0000 0000 0000` | `nop`
15 | `0000 0000 0000 0000` | `nop`
16 | `0010 1100 0100 0111` | `mov R4, R7` ; 6
17 | `0010 1100 0110 0111` | `mov R6, R7` ; 7
18 | `1110 0000 0010 0011` | `ldi R2, #3`
19 | `0100 0000 0110 0010` | `rem R6, R2`
20 | `1100 1111 1110 1101` | `rjmp #-19` ; 8
21 | `0000 0000 0000 0000` | `nop`