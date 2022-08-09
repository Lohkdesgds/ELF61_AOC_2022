ldi R6, #0 ; Contagem de primos [0]
ldi R7, #1 ; Ultimo primo valido
ldi R4, #1 ; constante
ldi R1, #1 ; Teste do primo em si
add R1, R4 ; LOOP: avança R1
brne #12 ; Se R1 deu 0, pula FINALIZE
ldi R2, #2 ; Inicia teste com 2
mov R3, R1 ; INNERLOOP:
sub R3, R2
brne #5 ; Se R3 der zero, PRIMO, goto GOOD
mov R3, R1
rem R3, R2
brne #-9 ; Volta para LOOP
add R2, R4
rjmp #-8 ; Volta para INNERLOOP
mov R7, R1 ; GOOD: copia R1 para R7
add R6, R4 ; incrementa contagem de primo
rjmp #-14 ; volta para LOOP
nop
rjmp #-1 ; FINALIZE: morre