.data

spc: .asciiz ","

.text

main:
	### LAÇO 
	
	## Limite do laço
	addi $t1, $zero, 50
	## Índice do laço
	add $t2, $zero, $zero
	
	loop: beq $t2, $t1, exit
		
	### Geraçao aleatória de numeros
	
	## Chamada do sistema 41 faz a geração de um valor aleatório baseado na seed do registrador $a0
	#add $a0, $zero, 0
	#add $a0, $zero, $zero
	#addi $v0, $zero, 41
	#syscall
	
	## Chamada do sistema 42 faz a geração de um valor aleatório com base em um limite entre dois valores: $a0 é o limite
	## inferior e $a1 é o limite superiror
	add $a0, $zero, 1
	addi $a1, $zero, 1000
	addi $v0, $zero, 42
	syscall
	
	## Chamada para exibir um inteiro. O numero a ser exibido deve estar em $a0, ou seja, não é necessário passar nenhum valor
	## para $a0 pois este registrador recebe o valor aleatorio
	addi $v0, $zero, 1
	syscall
	
	la $a0, spc
	addi $v0, $zero, 4
	syscall
	
	addi $t2, $t2, 1
	
	j loop
	
	exit:
	## Encerrar o sistema
	addi $v0, $zero, 10
	syscall
