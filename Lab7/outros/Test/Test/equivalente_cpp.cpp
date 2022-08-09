#include <iostream>
#include <stdio.h>
#include <stdlib.h>

int main() {
    uint16_t R0, R1, R2, R3, R4, R5, R6, R7;
    R0 = R1 = R2 = R3 = R4 = R5 = R6 = R7 = 0;

    R6 = 0; // contagem de números primos
    R7 = 2; // último número primo
    R4 = 1; // constante de apoio

    R1 = 1; // atual primo test
loop:
    R1 = R1 + R4; // avança R1
    if (R1 == 0) goto finalize; // se o avanço der loop, fim

    R2 = 2; // somador (divisor ++)
innerloop:
    R3 = R1;
    R3 = R3 - R2;
    if (R3 == 0) goto good; // são o mesmo -> é primo
    R3 = R1;
    R3 = R3 % R2;
    if (R3 == 0) goto loop; // resto deu zero -> não é primo, avançar
    R2 = R2 + R4;
    goto innerloop; // continuar
good:
    R7 = R1; // salva o último primo
    R6 = R6 + R4; // avança R6, contagem de primos
    goto loop;
finalize:
    std::cout << "Got " << R6 << " primos, last: " << R7 << std::endl;
    return 0;
}