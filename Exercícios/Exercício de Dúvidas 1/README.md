Desenvolva e teste um programa escrito em assembly para arquitetura MIPS que crie um array de inteiros (4 bytes), com 50 elementos, e que calcule: (a) o somatório dos elementos do array; e (b) o valor médio dos elementos.

Para isso, têm-se as seguintes observações:
  ● Os elementos devem ser gerados aleatoriamente por meio da chamada de sistema (syscall) adequada;
  ● O cálculo do valor médio será uma divisão de números inteiros. Logo, será gerado um quociente e um resto da divisão. Utilize as instruções MIPS adequadas para obter esses valores;
  ● Importante que os valores gerados aleatoriamente sejam armazenados na memória. Contudo, o valor da somatória pode ser calculado na medida que ocorre essa geração de inteiros. Deste modo, será necessário manter, apenas, um único laço no programa;
  ● Os números gerados aleatoriamente não precisam ser exibidos em tela. Contudo, a saída do programa dece ser o somatório e o valor médio calculado;
