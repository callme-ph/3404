# Desenvolva e teste um programa escrito em assembly para arquitetura MIPS que crie um array
# de inteiros (4 bytes), com 50 elementos, e que calcule: (a) o somatório dos elementos do array;
# e (b) o valor médio dos elementos.

.data

.align 2 #.align: Align next data item on specified byte boundary (0=byte, 1=half, 2=word, 3=double)
vetor: .space 200 # alocate 20 bytes: 5 integers with 4 bytes size - 32 bits per integer

spc: .asciiz ","
quo: .asciiz "\nQuociente da divisão: "
resto: .asciiz "\nResto da divisão: "
soma: .asciiz "\nSoma dos valores aleatórios a ser dividido por "
end_msg: .asciiz ": "

count: .word 0

.text

main:

# la = load address - $s0 receives the address that points to the beginning of the memory block alocated indicated by 'vector' label
la $s0, vetor # $0 irá receber o endereço de memoria associado a vetor. Este endereco sera onde a escrita dos numeros ira comecar

#### Save 50 integers into 'vetor'

### Do a loop to generate random integers and add each of them to the array

	### LAÇO 
	## Limite do laço
	addi $t1, $zero, 50
	## Índice do laço
	add $t2, $zero, $zero
	
	la $s1, ($s0)
	
	loop: beq $t2, $t1, exit
		
	### Geraçao aleatória de numeros
	
	## Chamada do sistema 42 faz a geração de um valor aleatório com base em um limite entre dois valores: $a0 é o limite
	## inferior e $a1 é o limite superiror
	add $a0, $zero, 1
	addi $a1, $zero, 1000
	addi $v0, $zero, 42
	syscall
	
	### Fazendo a soma dos valores aleatórios gerados
	add $t5, $a0, $t5
		
	## Chamada para exibir um inteiro. O numero a ser exibido deve estar em $a0, ou seja, não é necessário passar nenhum valor
	## para $a0 pois este registrador recebe o valor aleatorio
	#addi $v0, $zero, 1
	#syscall
		
	# s0 = endereço inicial de vetor
	# s1 = endereço usado para referenciar a s0 de 4 em 4 bytes
	# inicialmente $s1 = $s0, depois $s1 = $0 + 4 - 4($s0)	
	
	# Salva no endereço inicial de $s1 em $a0
	sw $a0, 0($s1)
	
	la $s1, 4($s1)
	
	la $a0, spc
	addi $v0, $zero, 4
	syscall
	
	addi $t2, $t2, 1
	
	j loop
	
	exit:
	
	# Exibe mensagem 'soma'
	la $a0, soma
	addi $v0, $zero, 4
	syscall
	
	# Exibe o valor de $t1
	add $a0, $zero, $t1
	addi $v0, $zero, 1
	syscall
	
	# Exibe mensagem 'end_msg'
	la $a0, end_msg
	addi $v0, $zero, 4
	syscall
	
	# Exibe o valor de $t5 - soma total
	add $a0, $zero, $t5
	addi $v0, $zero, 1
	syscall
	
	
	### Fazer a média da soma dos valores. A soma foi guardada em $a0
	div $a0, $t1
	
	mflo $t1 #passa o valor resultante do quociente da divisão do registrador low para $t1
	mfhi $t2 #passa o valor resultante do resto da divisão do registrador high para $t2
	
	# Exibe mensagem 'quo'
	la $a0, quo
	addi $v0, $zero, 4
	syscall
	
	# Exibe o valor de $t1 - quoficiente resultante da divisão
	add $a0, $zero, $t1
	addi $v0, $zero, 1
	syscall
	
	# Exibe mensagem 'resto'
	la $a0, resto
	addi $v0, $zero, 4
	syscall
	
	# Exibe o valor de $t2 - resto resultante da divisão
	add $a0, $zero, $t2
	addi $v0, $zero, 1
	syscall
	
	
	## Encerrar o sistema
	addi $v0, $zero, 10
	syscall


