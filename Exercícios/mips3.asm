.data

# Alocar espaço de 20 bytes na memoria
vetor: .space 20

msg1: .asciiz "\nDigite um inteiro: "
msg2: .asciiz "\nVeja a memoria de dados no MARS!"
MAX: .word 5

.text

main:

# Tomando endereco base!
la $s0, vetor

# Usando $t1 como indice multiplo de 4!
# Garantindo que inicie com valor zero
add $t1, $zero, $zero

# Numero de iteracoes
lw $t2, MAX

Loop: 	sll $t3, $t1, 2 # Fazendo com que $t3 = 4 * $t1

	add $t3, $s0, $t3 # Fazendo com que $t3 fique com o valor 'deslocamento + end. base'
	
	# Exibir mensagem...
	la $a0, msg1
	addi $v0, $zero, 4
	syscall
	# Leitura do primeiro numero...
	addi $v0, $zero, 5
	syscall

	add $t0, $v0, $zero

	# Gravando primeiro numero na memoria...
	sw $t0, 0($t3)
	
	# Incrementando indice
	addi $t1, $t1, 1
	
	# Testando para manter o laco
	# BEQ $T1, $T2, EXIT <=> SE $T1 == $T2, VÁ PARA 'EXIT'
	beq $t1, $t2, Exit
	
	# J é um desvio incondicional. Nesta linha o código irá para 'Loop'
	j Loop

Exit:

# Encerrando programa...
addi $v0, $zero, 10
syscall
