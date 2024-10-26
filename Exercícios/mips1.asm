.data # Itens s�o escritos em sequ�ncia no segmento de dados.

# Vari�veis - s�mbolos/r�tulos - g, h, i e j recebem as palavras - 32 bits, 4 bytes. Dados armazenados na mem�ria de dados
g: .word 135
h: .word 276
i: .word -657
j: .word 250

printHelloWorld: .ascii "Hello World!"

.text # 
la $a0, printHelloWorld
li $v0, 4
syscall

# do-while
loop: 
addi $v0, $v0, 1;
beq $t0, 10, fimLoop:
j loop

fimLoop:

# while / for 
loop: 
beq $t0, 10, fimLoop:
addi $v0, $v0, 1;
j loop

fimLoop:



# fun��o 'main' (sempre deve estar presente)
main:

# leitura da mem�ria
lw $s1, g
lw $s2, h
lw $s3, i
lw $s4, j

# opera��es aritm�ticas
add $t0, $s1, $s2
add $t1, $s3, $s4
sub $s0, $t0, $t1





# finalizando programa: exit()
addi $v0, $zero, 10
syscall
