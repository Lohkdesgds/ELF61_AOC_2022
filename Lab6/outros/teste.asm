ldi R4, #3 ; 1
ldi R5, #7 ; 2
ldi R7, #0 ; 3
add R7, R4
add R7, R5
ldi R1, #2 ; 4
sub R7, R1
rjmp #9 ; 5 (9 relativo)
nop
nop
nop
nop
nop
nop
nop
nop
nop
mov R4, R7 ; 6
mov R6, R7 ; 7
ldi R2, #3
rem R6, R2
rjmp #-20 ; 8
nop