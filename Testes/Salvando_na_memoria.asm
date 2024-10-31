.data

# Alocar espaco de 20 bytes na memoria
.align 2 #
vetor: .space 20 # 5 nº de 4 bytes - 32 bits

msg1: .asciiz "\nDigite um inteiro: "
msg2: .asciiz "\nVeja a memoria de dados no MARS!"

.text

main:

# la = load address - $s0 recebe o endereço de início do bloco de memória representado pelo rótulo vetor
la $s0, vetor # $0 irá receber o endereço de memoria associado a vetor. Este endereco sera onde a escrita dos numeros ira comecar

# Exibir mensagem msg1
la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do primeiro numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando primeiro numero na memoria...
# sw [ registrador "fonte" ] , [ n_inteiro($endereco do registrador base) ]
# O indice que esta ao lado do registrador base deve ser um valor que represente o deslocamento igual ao tamanho da palavra
# para palavras de 4 bytes, o numero deve ser de quatro em quatro: 0,4,8,12...
sw $t0, 0($s0)

# Mensagem...
# la $a0, msg1 [ja esta com o valor correto!]
addi $v0, $zero, 4
syscall

# Leitura do segundo numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando segundo numero na memoria...
sw $t0, 4($s0)

# Mensagem...
# la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do terceiro numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando terceiro numero na memoria...
sw $t0, 8($s0)

# Mensagem...
# la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do quarto numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando quarto numero na memoria...
sw $t0, 12($s0)

# Mensagem...
# la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do quinto e ultimo numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando quinto e ultimo numero na memoria...
sw $t0, 16($s0)

# Encerrando programa...
addi $v0, $zero, 10
syscall
