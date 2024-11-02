.data

spc: .asciiz ","

.text

main:
	### LA�O 
	
	## Limite do la�o
	addi $t1, $zero, 50
	## �ndice do la�o
	add $t2, $zero, $zero
	
	loop: beq $t2, $t1, exit
		
	### Gera�ao aleat�ria de numeros
	
	## Chamada do sistema 41 faz a gera��o de um valor aleat�rio baseado na seed do registrador $a0
	#add $a0, $zero, 0
	#add $a0, $zero, $zero
	#addi $v0, $zero, 41
	#syscall
	
	## Chamada do sistema 42 faz a gera��o de um valor aleat�rio com base em um limite entre dois valores: $a0 � o limite
	## inferior e $a1 � o limite superiror
	add $a0, $zero, 1
	addi $a1, $zero, 1000
	addi $v0, $zero, 42
	syscall
	
	## Chamada para exibir um inteiro. O numero a ser exibido deve estar em $a0, ou seja, n�o � necess�rio passar nenhum valor
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
