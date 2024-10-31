.data 

A: .word 400
B: .word 100
C: .word 50
D: .word 10
E: .word 10

msgA: .asciiz "\nValor de A:"
msgB: .asciiz "\nValor de B:"
msgC: .asciiz "\nValor de C:"
msgD: .asciiz "\nValor de D:"
msgE: .asciiz "\nValor de E:"
spc: .asciiz "\n"

resto_mlt: .asciiz "\nResto da multiplicacao: "
resultado_mlt: .asciiz "\nResultado da multiplicacao: "
soma_CDE: .asciiz "\nResultado da soma C + (D * E): "
sub_AB: .asciiz "\nResultado da subtração A - B: "
quo: .asciiz "\nQuociente da divisão: "
resto: .asciiz "\nResto da divisão: "

dv: .asciiz "\nDivisão: "
slash: .asciiz "\\"

.text

main:

lw $t0, A
lw $t1, B
lw $t2, C
lw $t3, D
lw $t4, E

# Vendo os valores armazenados

# Exibe mensagem msgA
la $a0, msgA
addi $v0, $zero, 4
syscall

# Exibindo o valor de A usando a palavra A (rótulo)
# É necessário usar o comando lw - load word - para salvar a palavra A em $a0
# O que for registrado em $a0 será mostrado no output ao ser feito a chamada do sistema com comando 1 (exibir inteiro)
lw $a0, A
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibindo o valor armazenado em $t0 que deve ser o valor armazenado na palavra A.
# No início do código foi feito um load word do valor de A em $t0
add $a0, $zero, $t0 
addi $v0, $zero, 1
syscall

# A sáida dever ser a mesma.

#####################################

# Exibe mensagem msgB
la $a0, msgB
addi $v0, $zero, 4
syscall

# Exibindo o valor de B usando a palavra B (rótulo)
# É necessário usar o comando lw - load word - para salvar a palavra B em $a0
# O que for registrado em $a0 será mostrado no output ao ser feito a chamada do sistema com comando 1 (exibir inteiro)
lw $a0, B
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibindo o valor armazenado em $t1 que deve ser o valor armazenado na palavra B.
# No início do código foi feito um load word do valor de B em $t1
add $a0, $zero, $t1 
addi $v0, $zero, 1
syscall

# A sáida dever ser a mesma.

#####################################

# Exibe mensagem msgC
la $a0, msgC
addi $v0, $zero, 4
syscall

# Exibindo o valor de C usando a palavra C (rótulo)
# É necessário usar o comando lw - load word - para salvar a palavra C em $a0
# O que for registrado em $a0 será mostrado no output ao ser feito a chamada do sistema com comando 1 (exibir inteiro)
lw $a0, C
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibindo o valor armazenado em $t2 que deve ser o valor armazenado na palavra C.
# No início do código foi feito um load word do valor de C em $t2
add $a0, $zero, $t2 
addi $v0, $zero, 1
syscall

# A sáida dever ser a mesma.

#####################################

# Exibe mensagem msgD
la $a0, msgD
addi $v0, $zero, 4
syscall

# Exibindo o valor de D usando a palavra D (rótulo)
# É necessário usar o comando lw - load word - para salvar a palavra D em $a0
# O que for registrado em $a0 será mostrado no output ao ser feito a chamada do sistema com comando 1 (exibir inteiro)
lw $a0, D
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibindo o valor armazenado em $t3 que deve ser o valor armazenado na palavra D.
# No início do código foi feito um load word do valor de D em $t3
add $a0, $zero, $t3 
addi $v0, $zero, 1
syscall

# A sáida dever ser a mesma.

#####################################

# Exibe mensagem msgE
la $a0, msgE
addi $v0, $zero, 4
syscall

# Exibindo o valor de E usando a palavra E (rótulo)
# É necessário usar o comando lw - load word - para salvar a palavra E em $a0
# O que for registrado em $a0 será mostrado no output ao ser feito a chamada do sistema com comando 1 (exibir inteiro)
lw $a0, E
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibindo o valor armazenado em $t4 que deve ser o valor armazenado na palavra E.
# No início do código foi feito um load word do valor de E em $t4
add $a0, $zero, $t4 
addi $v0, $zero, 1
syscall

# A sáida dever ser a mesma.

#####################################

# Implementar o código para fazer a operação Y = (A - B) / ( C + (D * E))

# D * E

# Multiplicando os valores e D e E
mult $t3, $t4

# Acessando o quociente ( lo ) e resto ( hi )
mflo $t7
mfhi $t6

# Exibir a mensagem do resto da multiplicacao
la $a0, resto_mlt
addi $v0, $zero, 4
syscall

# Eibir o resto da multiplicacao
add $a0, $t6, $zero
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall  

# Exibir a mensagem do resultado da multiplicacao
la $a0, resultado_mlt
addi $v0, $zero, 4
syscall

# Eibir o resultado da multiplicacao E * D
add $a0, $t7, $zero
addi $v0, $zero, 1
syscall

# Somar C + (D*E) - $t2 + $t7 - e salvar em $t7
add $t7, $t2, $t7

la $a0, soma_CDE
addi $v0, $zero, 4
syscall

# Exibir resultado da soma
add $a0, $t7, $zero
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall

# Subtrair A - B
sub $t6, $t0, $t1

# Exibir mensagem do resultado da subtracao
la $a0, sub_AB
add $v0, $zero, 4
syscall 

# Exibir resultado da subtracao
add $a0, $t6, $zero
addi $v0, $zero, 1
syscall

# Quebra de linha
la $a0, spc
addi $v0, $zero, 4
syscall

# Divisão Y = (A - B) / ( C + (D * E)) = $t6 / $t7
div $t6, $t7

# Salva o quociente resultante. Do registrador low para $s0
mflo $s0
# Salva o resto resultante. Do registrador hi para %s1
mfhi $s1

# Exibir os valores a serem divididos:
la $a0, dv
addi $v0, $zero, 4
syscall

add $a0, $t6, $zero
addi $v0, $zero, 1
syscall

la $a0, slash
addi $v0, $zero, 4
syscall

add $a0, $t7, $zero
addi $v0, $zero, 1
syscall


# Exibe o quociente
la $a0, quo
addi $v0, $zero, 4
syscall

add $a0, $s0, $zero
addi $v0, $zero, 1
syscall

# Exibe o resto
la $a0, resto
addi $v0, $zero, 4
syscall

add $a0, $s1, $zero
addi $v0, $zero, 1
syscall



#finalizando programa: exit()
addi $v0, $zero, 10
syscall

 
