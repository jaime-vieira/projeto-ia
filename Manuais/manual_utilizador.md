
<h1 style="text-align: center;">Projeto Época Normal - Fase 1</h1>

<div style="text-align: center;">

<img src="ips_logo.png" alt="Logo de IPS" width="500" heigth=""/>

<h2>2023/2024</h2>

<h2>Inteligência Artificial</h2>

<h2>Docente: Joaquim Filipe</h2>


<h2>Realizado por:</h2>
<h3>Francisco Vaz Nº 202100217</h3>
<h3>Jaime Vieira&nbsp&nbsp&nbsp Nº 202100108</h3>
<br>
<br>
<h2>Jogo do Cavalo - Manual de Utilizador</h2>

<br>
</div>

## Índice


### 1. Acrónimos e Convençoões Usadas

Ao longo deste relatório, foram utilizadas algumas abreviaturas e convenções específicas para garantir clareza e consistência na apresentação do projeto em LISP. Abaixo estão as principais convenções adotadas:

#### 1.1 Convenções de Formatação de Código

- Código-fonte LISP: Trechos de código LISP são apresentados em fonte monoespaçada para facilitar a distinção entre o texto regular e o código.

```
(defun exemplo_funcao (parametro)
(format t "Olá, ~a!" parametro))
```

#### 1.2 Terminologia Específica do Jogo do Cavalo

- Cavalo Branco: Refere-se ao cavalo controlado pelo jogador único no contexto do Problema do Cavalo.

#### 1.3 Acrónimos

AI: Inteligência Artificial

DFS: Busca em Profundidade

BFS: Busca em Largura

#### 1.4 Comentários no Código

Comentários no código são precedidos por um ponto e espaço.

```
; Isto é um comentário
```

### 2. Introdução

Este manual tem como objetivo servir de guia para os utilizadores do projeto “Jogo do Cavalo” e proporcionar ao utilizador uma descrição de como instalar e interagir com o jogo. O projeto baseia-se no problema matemático conhecido como “Passeio do Cavalo” e foi desenvolvido no âmbito da unidade curricular de Inteligência Artificial.

O “Jogo do Cavalo” simula o movimento do cavalo num tabuleiro semelhante ao de xadrez. Esta
versão decorrerá num tabuleiro de 10 linhas e 10 colunas (10x10), em que cada casa possui uma pontuação.

Com base na descrição fornecida, o programa a ser desenvolvido em LISP para resolver o Problema do Cavalo deve atender aos seguintes requisitos gerais:

1. Tabuleiro e Inicialização:

- O programa deve criar um tabuleiro de xadrez de dimensões 10x10.

- Os valores de cada casa devem ser aleatórios e únicos, variando de 00 a 99.

- O cavalo branco deve ser colocado pelo jogador em uma casa da 1ª linha.

2. Regras do Jogo:

- Ao posicionar o cavalo branco, se a casa escolhida tiver um número de dois dígitos diferentes, o número simétrico deve ser removido do tabuleiro.
  
- Se o cavalo for colocado em uma casa com um número "duplo," o jogador deve escolher qual número remover, geralmente removendo o de maior valor.

- Após a primeira jogada, o cavalo preto é posicionado na 10ª linha, seguindo as mesmas regras de remoção de números simétricos ou duplos.
  
3. Movimentação do Cavalo:

- O programa deve implementar as regras tradicionais do Xadrez para o movimento do cavalo.

- O cavalo não pode saltar para uma casa vazia ou para uma casa ameaçada pelo cavalo adversário.
  
4. Pontuação:

- Os jogadores ganham pontos por cada casa visitada pelo seu cavalo (igual ao valor da casa).

- A pontuação é contabilizada apenas para as casas visitadas, não pelos números simétricos ou duplos removidos.

5. Objetivo do Jogo:

- O jogo termina quando não é possível movimentar qualquer um dos cavalos no tabuleiro.

- O vencedor é o jogador que acumula mais pontos.

- O programa também deve permitir definir um objetivo específico de pontuação para a versão simplificada do jogo.

6. Resolução do Problema:

- O programa deve resolver o Problema do Cavalo como uma versão simplificada, considerando apenas o cavalo branco.

- O objetivo é atingir uma pontuação definida no menor número possível de jogadas.

- O programa deve informar se não for possível atingir o objetivo.

7. Algoritmos de Procura:

- Utilizar algoritmos de procura em Espaço de Estados para encontrar a solução ótima.

- Aplicar um operador especial de colocação do cavalo na primeira linha para gerar os sucessores do nível 1 a partir do nó raiz do grafo.

- Aplicar operadores de movimentação do cavalo para explorar o espaço de estados.

8. Objetivos Específicos:

- Resolver os problemas A-F, com objetivos específicos de pontuação.

- Apresentar a sequência de estados ou jogadas que conduzem da posição inicial à posição final para cada problema.

9. Interatividade e Feedback:

- O programa deve interagir com o usuário, fornecendo informações sobre o andamento do jogo, pontuação acumulada e se o objetivo foi alcançado.

10.  Optimização:

- A solução ótima é aquela que proporciona o caminho com o menor número de jogadas entre o estado inicial e o estado final.


### 3. Instalação e Utilização



<div style="text-align: center;">

<img src="lispworks.png" alt="Logo do LispWorks" width="600" heigth=""/>

</div>