.data

# Alocar espaco de 20 bytes na memoria
vetor: .space 20

# Rótulo msg1 e msg2 são variáveis que apontam para o inicio do bloco de memoria em que a string estah. 
msg1: .asciiz "\nDigite um inteiro: "
msg2: .asciiz "\nVeja a memoria de dados no MARS!"

.text

main:

# Load address: Carrega as informações do bloco de memória alocada em 'vetor' para o registrador $s0
la $s0, vetor

# Mensagem...
# Salva/Carrega a string do rótulo msg1 no registrador $a0 
# Adiciona o valor zero no registrador $v0 que sera lido ao fazer a chamda do sistema
# Faz a chamada do sistema - syscall - e o valor 4 no registrador $v0 indica que o sistema deve fazer a exibicao da msg1 que esta em $a0 
la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do primeiro numero...
# Add immediate ( addi ) faz a adição de 5 em $v0 fazendo uma soma com 0
# Outra chamada do sistema. Desta vez o valor 5 indica que o sistema deve receber um input 
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando primeiro numero na memoria...
sw $t0, 0($s0)

# Mensagem...
# la $a0, msg1 [nao eh necessario fazer o load address da string em $a0 pois ja estao com o valor correto!]
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
sw $t0, 4($s0)

# Mensagem...
# la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do quarto numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando quarto numro na memoria...
sw $t0, 4($s0)

# Mensagem...
# la $a0, msg1
addi $v0, $zero, 4
syscall

# Leitura do quinto e ultimo numero...
addi $v0, $zero, 5
syscall
add $t0, $v0, $zero

# Gravando quinto e ultimo numero na memoria...
sw $t0, 4($s0)

# Encerrando programa...
addi $v0, $zero, 10
syscall

# Devisao entre t0 e t1 - t0/t1
div $t0, $t1
# Os valores sao salvos nos registradores hi e lo. 
# Não eh possivel operar com os registradores hi e lo mas podem ser acessados

mflo $t1 # Carrega o valor salvo no registrador lo em $t1
