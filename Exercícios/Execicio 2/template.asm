# Pedro Henrique da Silva Santos
# 20210087424

# Segmento de dados --------------

.data
 
msg_codificada: .word 0x00051010, 0x116A23B1, 0x21347582, 0x10061231, 0x11642467, 0x008695AB, 0x21CD6EEF, 0x00071323
                .word 0x11264517, 0x2089A2B0, 0x00E5F601, 0x212360F1, 0x11624533, 0x21676455, 0x00627089, 0x20AB8691
                .word 0x10A6CDB3, 0x21EF6C5D, 0x10E701F2, 0x00071423, 0x0162F345, 0x21677455, 0x10628971, 0x1082AB90
                .word 0x10A4CDB6, 0x016C9DEF, 0x21016031, 0x212362F3, 0x01745545, 0x10626770, 0x10868993, 0x21AB6AFB
                .word 0x00C6DDCD, 0x00E2F0EF, 0x116001E1, 0x0162F323, 0x20454754, 0x00667167, 0x20898290, 0x113AAB1B
                .word 0x113CCD0D, 0x000211EF

spc: .asciiz "\n"

#.align 2
# Segmento de texto (instruções)

.text

main:

# --------- Printing somewhat full lines

la $s2, msg_codificada

# o loop deve comecar no primeiro numero de msg_codificada e deve ir ateh o ultimo

addi $s3, $zero, 41 # Limite do loop
add $s4, $zero, $zero # Indice do loop

loop:

beq $s3, $s4, exit # avaliar o se o loop já chegou ao limite
# avaliar o nibble 1 do numero
# salvar o valor do nibble para poder fazer a condicional de avaliacao

lw $t0, ($s2)

#lui $t1, 0xFF00 # Pega 16 bits e carrega no 16 bits mais sginifcativos de outro registrador
#ori $t1, $t1, 0x0000
#and $t1, $t0, $t1

srl $t1, $t0, 24 ## $t1 terá os bits menos significativos com os dois valores do byte 3
srl $t2, $t1, 4 ## $t2 terá o bit menos significativo igual ao nibble 1 do byte 3
# $t2 terá o valor correspondente ao byte que não deve ser lido

andi $t3, $t1, 0x000F # Faz um "and" entre t1 e 0x0000000F ( fica assim por causa do comando andi )
# t3 terá o valor do bit menos significativo como o valor que define quais nibbles devem ser lidos

li $t4, 0
li $t5, 1
li $t6, 2

beq $t3, $t4, nib_eq_0
beq $t3, $t5, nib_eq_1

nib_eq_0:
# um registrador deve ter a informacao de qual nibble deve ser lido
# $s7 sera 0 se o nibble a ser lido for o 0
add $s7, $zero, $zero

# registrado $t9 deve ficar assim: 0x000F0F0F

ori $t7, $zero, 0x000F
sll $t8, $t7, 8
sll $t9, $t8, 8
or $t7, $t7, $t8
or $t9, $t9, $t7 # $t9 deve ser 0x000F0F0F nesse OR

beq $t2, $t4, case_0  # Não dever ler o byte 0
beq $t2, $t5, case_1  # Não deve ler o byte 1
beq $t2, $t6, case_2  # Não deve ler o byte 2

#j # Fim da condicional nib_eq_0

nib_eq_1:
# um registrador deve ter a informacao de qual nibble deve ser lido
# $s7 sera 1 se o nibble a ser lido for o 1
addi $s7, $zero, 1

# registrador $t9 deve ficar assim: 0x00F0F0F0

ori $t7, $zero, 0x000F
sll $t7, $t7, 4
sll $t8, $t7, 8
sll $t9, $t8, 8
or $t7, $t7, $t8
or $t9, $t9, $t7 # $t9 deve ser 0x00F0F0F0 nesse OR

beq $t2, $t4, case_0  # Não dever ler o byte 0
beq $t2, $t5, case_1  # Não deve ler o byte 1
beq $t2, $t6, case_2  # Não deve ler o byte 2

#j # Fim da condicional nib_eq_1

case_0:
# No caso 0, é necessário ler os valores do byte 2 e 1
# $t9 está com o formato 0x000F0F0F, não usa-lo

beq $s7, $zero, nib_00 # caso 0, ler nibbles 0
beq $s7, 1, nib_01 # caso 1, ler nibbles 1

nib_00:
ori $t7, $zero, 0x000F
sll $t8, $t7, 8
sll $t7, $t8, 4
or $t7, $t8, $t7
sll $t8, $t7, 8
or $t8, $t8, $t7 #$t8 deve ter o formato 0x00FFFF00

and $t7, $t8, $t9 #$t7 deve ter o formato 0x000F0F00
and $t7, $t7, $t0
# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
srl $t9, $t7, 8
and $s1, $t8, $t9

sll $t8, $t8, 4
srl $t9, $t9, 4
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_0

nib_01:
ori $t7, $zero, 0x000F
sll $t8, $t7, 8
sll $t7, $t8, 4
or $t7, $t8, $t7
sll $t8, $t7, 8
or $t8, $t8, $t7 #$t8 deve ter o formato 0x00FFFF00

and $t7, $t8, $t9 #$t7 deve ter o formato 0x00F0F000
and $t7, $t7, $t0 #$t7 deve ter os valores de $t0 somente nos nibbles a serem lidos

# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
srl $t9, $t7, 12
and $s1, $t8, $t9

sll $t8, $t8, 4
srl $t9, $t9, 4
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_0


case_1:
# No caso 1, é necessário ler os valores do byte 2 e 0
# $t9 está com o formato dos nibbles a serem lidos, não usa-lo

beq $s7, $zero, nib_10 # caso 1, ler nibbles 0
beq $s7, 1, nib_11 # caso 1, ler nibbles 1

nib_10:
ori $t7, $zero, 0x000F
sll $t8, $t7, 4
or $t7, $t8, $t7
sll $t8, $t7, 16
or $t7, $t8, $t7 #$t7 deve ter o formato 0x00FF00FF 

and $t7, $t7, $t0 #$t7 recebe os bytes a serem lidos da palavra 
and $t7, $t7, $t9 #t7 recebe os nibbles a serem lidos dos bytes a serem lidos 0x000F000F
# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
and $s1, $t8, $t7

sll $t8, $t8, 4
srl $t9, $t7, 12
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_1

nib_11:
ori $t7, $zero, 0x000F
sll $t8, $t7, 4
or $t7, $t8, $t7
sll $t8, $t7, 16
or $t7, $t8, $t7 #$t7 deve ter o formato 0x00FF00FF 

and $t7, $t7, $t0 #$t7 recebe os bytes a serem lidos da palavra 
and $t7, $t7, $t9 #t7 recebe os nibbles a serem lidos dos bytes a serem lidos 0x00F000F0
# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
srl $t9, $t7, 4
and $s1, $t8, $t9

sll $t8, $t8, 4
srl $t9, $t7, 16
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_1

case_2:
# No caso 2, é necessário ler os valores do byte 1 e 0
# $t9 está com o formato dos nibbles a serem lidos, não usa-lo

beq $s7, $zero, nib_20 # caso 1, ler nibbles 0
beq $s7, 1, nib_21 # caso 1, ler nibbles 1

nib_20:
ori $t7, $zero, 0x000F
sll $t8, $t7, 4
or $t7, $t8, $t7
sll $t8, $t7, 8
or $t7, $t8, $t7 #$t7 deve ter o formato 0x0000FFFF 

and $t7, $t7, $t0 #$t7 recebe os bytes a serem lidos da palavra 
and $t7, $t7, $t9 #t7 recebe os nibbles a serem lidos dos bytes a serem lidos 0x00000F0F
# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
and $s1, $t8, $t7

sll $t8, $t8, 4
srl $t9, $t7, 4
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_1

nib_21:
ori $t7, $zero, 0x000F
sll $t8, $t7, 4
or $t7, $t8, $t7
sll $t8, $t7, 8
or $t7, $t8, $t7 #$t7 deve ter o formato 0x0000FFFF 

and $t7, $t7, $t0 #$t7 recebe os bytes a serem lidos da palavra 
and $t7, $t7, $t9 #t7 recebe os nibbles a serem lidos dos bytes a serem lidos 0x0000F0F0
# deve-se usar $s7 para formar 0x000000FF usando o shift-right e mantendo a ordem dos bits
# o menos significativo deve ser o primeiro

ori $t8, $zero, 0x000F
srl $t9, $t7, 4
and $s1, $t8, $t9

sll $t8, $t8, 4
srl $t9, $t7, 8
and $t9, $t9, $t8

or $s1, $s1, $t9

add $a0, $zero, $s1
li $v0, 11
syscall
j iteration_done # Fim da condicional case_1

iteration_done:
addi $s4, $s4, 1
la $s2, 4($s2)

j loop

exit:
li $v0, 10
syscall
