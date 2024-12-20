###########################################
#                                         #
#  Aluno: Pedro Henrique da Silva Santos  #
#  Matrícula : 20210087424                #
#                                         #
###########################################

.data

.align 2 #.align: Align next data item on specified byte boundary (0=byte, 1=half, 2=word, 3=double)
vetor: .space 40 # alocate 40 bytes: 10 integers with 4 bytes size - 32 bits per integer

spc: .asciiz " "
generated_n: .asciiz "Array: "
ordered_arr: .asciiz "\nOrdered array: "
ordering: .asciiz "\nOrdering array..."

.text
.globl main

# la = load address - $s0 receives the address that points to the beginning of the memory block alocated indicated by 'vector' label
la $s0, vetor # $s0 receives the memory address associated to 'vetor'. This address  will be where the number will be written from.

### Loop to generate random number to add to 'vetor'
## Loop's limit: 10 is saved in t1
addi $t1, $zero, 10
## Loop's index started in 0, saved to t2
add $t2, $zero, $zero
	
# $s1 recebe o endereço inicial de vetor que está armazenado em $s0
la $s1, ($s0)

la $a0, generated_n
addi $v0, $zero, 4
syscall


loop: beq $t2, $t1, main
		
	### Random number generator
	
	## Syscall 42 does a random number generation based in the upper limit set to $a1 and lower limit set to $s0
	add $a0, $zero, 1
	addi $a1, $zero, 255
	addi $v0, $zero, 42
	syscall
		
	## Syscall 1 to output an integer. The number generated is stored in $a0 which is the same register used to store an value to
	##  be shown, so there is no necessity to save the number generated to it.
	addi $v0, $zero, 1
	syscall
	
	# SW saves the initial address from $s1 to $a0
	sw $a0, 0($s1)
	# LA updates de $s1 address to next number's address, 4 bytes ahead from $s1 previous address
	la $s1, 4($s1)
	
	# prints space to output numbers organized
	la $a0, spc
	addi $v0, $zero, 4
	syscall
	
	# increment loop's index
	addi $t2, $t2, 1
	
	# return to loop's begin
	j loop

main:

# Print message 
la $a0, ordering
addi $v0, $zero, 4
syscall

# Print message
la $a0, ordered_arr
addi $v0, $zero, 4
syscall

  #lui $s0, 0x1001                   #arr[0]
  li $t0, 0                         #i = 0
  li $t1, 0                         #j = 0
  li $s1, 10                        #n = 10 -> tamanho do vetor
  li $s2, 10                        #n-i for inner loop
  add $t2, $zero, $s0               #for iterating addr by i
  add $t3, $zero, $s0               #for iterating addr by j

  addi $s1, $s1, -1

outer_loop:
  li  $t1, 0                        #j = 0
  addi $s2, $s2, -1                 #decreasing size for inner_loop
  add $t3, $zero, $s0               #resetting addr itr j

  inner_loop:
    lw $s3, 0($t3)                  #arr[j]
    addi $t3, $t3, 4                #addr itr j += 4
    lw $s4, 0($t3)                  #arr[j+1]
    addi $t1, $t1, 1                #j++

    slt $t4, $s3, $s4               #set $t4 = 1 if $s3 < $s4
    bne $t4, $zero, cond            #goes to block of code label as 'cond' if $t content is zero.
    swap:
      sw $s3, 0($t3)
      sw $s4, -4($t3)
      lw $s4, 0($t3)

    cond:
      bne $t1, $s2, inner_loop      #if j != n-i -> permanece no for interno

    addi $t0, $t0, 1                  #i++
  bne $t0, $s1, outer_loop           #i != n

  li $t0, 0
  addi $s1, $s1, 1
  
print_loop:
  li $v0, 1
  lw $a0, 0($t2)
  
  syscall
  li $v0, 4
  la $a0, spc
  syscall

  addi $t2, $t2, 4                  #addr itr i += 4
  addi $t0, $t0, 1                  #i++
  bne $t0, $s1, print_loop          #i != n -> verifica a condição de parada do print

exit:

# encerra sistema.
  li $v0, 10
  syscall
