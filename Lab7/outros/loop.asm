ldi R5, #10
ldi R3, #1
ldi R4, #5 ; 5x
ldi R2, #0 ; salvar em R2 <= 10 * 5
add R2, R5
sub R4, R3
brne #1 ; se R4 == 0, pula 1 linha
rjmp #-4 ; se não pulou, volta pro add
rjmp #-1 ; senão trava loop infinito