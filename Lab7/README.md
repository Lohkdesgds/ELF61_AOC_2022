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
