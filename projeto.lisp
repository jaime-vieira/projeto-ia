;;; Ficheiro: projeto.lisp
;;;
;;; Descrição: Carrega os outros ficheiros de código, escreve e lê ficheiros, e trata da interação com o utilizador
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108


;Diretórios

;; C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3º ano\\1º Semestre\\IA\\projeto-ia\\ -> Diretoria Francisco
;; D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\ -> Diretoria Jaime

(defun path ()
  (let ((path "D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\")) path)
)


(defun path-solucao ()
   "Caminho da solução"
  (let ((ficheiro-path  "D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\solucao.dat")) ficheiro-path)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Menus ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun start ()
  (load (compile-file(concatenate 'string (path) "puzzle.lisp")))
  (load (compile-file(concatenate 'string (path) "procura.lisp")))
  (format t "~%Bem Vindo ao Jogo do Cavalo!~%")
  (menu_inicial)
)


(defun menu_inicial ()
  "Menu de inicio do jogo"
  (loop
    (format t "~%1 - Iniciar Jogo")
    (format t "~%2 - Sair~%")
    (format t "~%Escolha um número entre 1 e 2:~%")
    (let ((opcao (read)))
     (cond 
      ((= opcao 1) (format t "~%A começar o jogo...~%") (menu_escolha_problema))
      ((= opcao 2) (format t "~%A sair... Até à próxima!~%") (return))
      (t (format t "~%Escolha inválida. ~%"))
     )
    )
  )
)


(defun menu_escolha_problema ()
 "Menu de escolha do problema"
 (loop
    (format t "~%Escolha um Problema:~%")
    (format t "~%1 - Problema A")
    (format t "~%2 - Problema B")
    (format t "~%3 - Problema C")
    (format t "~%4 - Problema D")
    (format t "~%5 - Problema E")
    (format t "~%6 - Problema F")
    (format t "~%7 - Menu Inicial")
    (format t "~%~% Escolha uma opção de 1 a 7:")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inválida.~%"))
      ((= opcao 1) (progn (definir-objetivo 'A) (menu-escolha (problema-A) ) t))
      ((= opcao 2) (progn (definir-objetivo 'B) (menu-escolha (problema-B) ) t))
      ((= opcao 3) (progn (definir-objetivo 'C) (menu-escolha (problema-C) ) t))
      ((= opcao 4) (progn (definir-objetivo 'D) (menu-escolha (problema-D) ) t))
      ((= opcao 5) (progn (definir-objetivo 'E) (menu-escolha (problema-E) ) t))
      ((= opcao 6) (progn (definir-objetivo 'F) (menu-escolha (problema-F) ) t))
      ((= opcao 7) (menu_inicial))
      (t (format t "~%Escolha inválida.~%"))
     )
    )
 )
)


(defun menu_escolha_modo (problema)
  "Menu de escolha de tipo de jogo"
  (loop
     (format t "~%Escolha um Modo")
     (format t "~%1 - Ir para o algoritmo")
     (format t "~%2 - Configurar Tabuleiro")
     (format t "~%3 - Menu Inicial")
     (format t "~%~% Escolha uma opção de 1 a 3:")
     (let ((opcao (read)))
      (cond 
       ((not (numberp opcao)) (format t "~%Escolha inválida.~%"))
       ((= opcao 1) (menu-algoritmos problema))
       ((= opcao 2) (menu-configurar-tabuleiro problema))
       ((= opcao 3) (menu_inicial))
       (t (format t "~%Escolha inválida.~%"))
      )
     )
   )
)

;;Função tá com erro
#|
(defun menu_configurar-tabuleiro (problema)
  "Menu de escolha de posição"
  (cond
   ((equal (posicao-cavalo problema) nil )  
    (loop
       (pprint  problema)
       (format t "~%Escolha apenas uma posição com valores da primeira")      
       (format t "~%linha para o cavalo(0 para Menu Inicial).")
       (format t "~%-> ")
      (let ((opcao (read)))
       (cond 
        ((or (numberp opcao) (> opcao 10) (< opcao 0))) (format t "~%Escolha inválida.~%"))
        ((zerop opcao) (menu_inicial))
        ((= opcao 2) (menu-configurar-tabuleiro problema))
        (t (format t "~%Escolha inválida.~%"))
       ))
      )
     (cond ((not (let ((escolha (read)))
                   (cond 
                    ((and (numberp escolha) (< escolha 10) (> escolha -2)) (cond 
                                                                            ((eq ( operador-inicial-cavalo problema  escolha) Nil )  (progn nil))
                                                                            ((= escolha -1) (progn nil))
                                                                            (t              (progn (menu-algoritmos (operador-inicial-cavalo problema  escolha)) nil ))))
                    ( T (progn  (format t "~%          Invalid Choice~%~%          Index -> ")
                          (setf escolha (read)))))))
            (return)))
    ))
   (T (menu-algoritmos problema)))

|#







#| Funções do bacano


(defun menu-Configurar-tabuleiro (problema)
  "1.2- Menu para Configurar 0 Tabuleiro"
  (cond
   ((equal (posicao-cavalo problema) nil )  
    (loop
     (pprint  problema)
     (progn
       (format t "~%           ______________________________________________________")      
       (format t "~%          §                                                      §")
       (format t "~%          §                   CHOOSE HORSE POSITION              §")
       (format t "~%          §                IN THE FIRST ROW OF THE BOARD         §")            
       (format t "~%          §                                                      §")
       (format t "~%          §                                                      §")
       (format t "~%          §          choose only the position with values        §")
       (format t "~%          §            from the first row of the board           §")
       (format t "~%          §                                                      §")
       (format t "~%          §                                                      §")
       (format t "~%          §                ( OR Press  -1  TO EXIT   )           §")
       (format t "~%          § _____________________________________________________§")
       (format t "~%~%~%          Index -> ")
       )
     (cond ((not (let ((escolha (read)))
                   (cond 
                    ((and (numberp escolha) (< escolha 10) (> escolha -2)) (cond 
                                                                            ((eq ( operador-inicial-cavalo problema  escolha) Nil )  (progn nil))
                                                                            ((= escolha -1) (progn nil))
                                                                            (t              (progn (menu-algoritmos (operador-inicial-cavalo problema  escolha)) nil ))))
                    ( T (progn  (format t "~%          Invalid Choice~%~%          Index -> ")
                          (setf escolha (read)))))))
            (return)))))
   (T (menu-algoritmos  problema))))




(defun menu-algoritmos (problema)
  "1.3 Sub menu escolhe algoritmo "
  (loop
   (progn
     (format t "~%           ______________________________________________________")
     (format t "~%          §                                                      §")
     (format t "~%          §                  CHOOSE ALGORITHM                    §")
     (format t "~%          §                (search algorithm)                    §")
     (format t "~%          §                                                      §")
     (format t "~%          §                 1-Algorithm BFS                      §")
     (format t "~%          §                 2-Algorithm DFS                      §")
     (format t "~%          §                 3-Algorithm A*                       §")
     (format t "~%          §                 4-Algorithm SMA*                     §")
     (format t "~%          §                 0-Home Menu                          §")
     (format t "~%          §                                                      §")
     (format t "~%          §______________________________________________________§") 
     (format t "~%~%~%          Option -> ")
     )
   (cond ((not (let ((escolha (read))) 
                 (cond 
                  ((and (numberp escolha) (< escolha 5) (> escolha -1)) (case escolha
                                                                         (1 (definir-heuristica 'base) (run-search  'bfs (cria-no problema   (posicao-cavalo problema) 0  0 NIL)    ))
                                                                         (2 (menu-profundidade problema))
                                                                         (3 (menu-heuristic problema  'A*))
                                                                         (4 (menu-memory problema 'SMA* ))
                                                                         (0 (progn  NIL))))
                  ( T (progn  (format t "~%          Invalid Choice~%~%          Option -> ")
                        (setf escolha (read))))))) 
          (return)))))





(defun menu-profundidade (problema )
  "1.3.1-Sub-menu imprime problemas"
  (loop
   (progn
     (format t "~%           ______________________________________________________")
     (format t "~%          §                         G                            §")
     (format t "~%          §                      (DEPTH)                         §")
     (format t "~%          §                (Preview one Board)                   §")
     (format t "~%          §                                                      §")
     (format t "~%          §                     ATTENTION                        §")
     (format t "~%          §                                                      §")
     (format t "~%          §       Only numbers greater than Ø are allowed        §")     
     (format t "~%          §                   0-Home Menu                        §")
     (format t "~%          §                                                      §")
     (format t "~%          §______________________________________________________§")
     (format t "~%~%~%          Depth-> ")
     )
   (cond ((not (let ((depth (read)))
                 (cond 
                  ((and (numberp depth) (> depth -1) ) (case depth
                                                         (0 (progn nil))
                                                         (t (definir-heuristica 'base) (run-search  'dfs (cria-no problema  (posicao-cavalo problema) 0  0 NIL) :profundidade depth ))))
                  ( T (progn  (format t "~%          Invalid Choice~%~%          Depth ->  ")
                        (setf depth (read))))))) 
          (return)))))









(defun menu-path (node)
  (progn 
    (format t "~% Want to see the Path? (y/n) ")
    (format t "~%        Y- YES               ")
    (format t "~%        N- NO                ~%")
    (cond 
     ((eq (read) 'y ) (pprint (first node))(menu-tabuleiros))
     (t (menu-tabuleiros)))))
  






(defun menu-memory (problema algoritmo)
"1.3.2-Sub-menu para Escolher a Heuristica"
(loop
    (progn
      (format t "~%           ______________________________________________________")
      (format t "~%          §                     MEMORY LIMIT                     §")
      (format t "~%          §                        (SMA*)                        §")
      (format t "~%          §                                                      §")
      (format t "~%          §             Choose a value of memory                 §")
      (format t "~%          §                 (Max of Nodes)                       §")    
      (format t "~%          §                 0-Home Menu                          §")
      (format t "~%          §                                                      §")
      (format t "~%          §______________________________________________________§")
      (format t "~%~%~%          Memory -> ")
      )
    (cond ((not (let ((memory (read)))
               (cond 
                ((and (numberp memory)  (> memory -1) ) (case memory
                      (0 (progn nil))
                      (t (set-max-nos memory) (menu-heuristic  problema algoritmo))))
                ( T (progn  (format t "~%          Invalid Choice~%~          Memory -> ")
                            (setf memory (read)))))))
           (return)))))





(defun menu-heuristic (problema algoritmo)
"1.3.2-Sub-menu para Escolher a Heuristica"
(loop
    (progn
      (format t "~%           ______________________________________________________")
      (format t "~%          §                          H                           §")
      (format t "~%          §                     (HEURISTIC)                      §")
      (format t "~%          §                                                      §")
      (format t "~%          §                 1-Base (h(x)=o(x)/m(x))              §")
      (format t "~%          §                 2-Developed                          §")    
      (format t "~%          §                 0-Home Menu                          §")
      (format t "~%          §                                                      §")
      (format t "~%          §______________________________________________________§")
      (format t "~%~%~%          Heuristic -> ")
      )
    (cond ((not (let ((heuristic (read)))
               (cond 
                ((and (numberp heuristic) (< heuristic 3) (> heuristic -1) ) (case heuristic
                      (0 (progn nil))
                      (1 (definir-heuristica 'base)         (run-search algoritmo (cria-no problema (posicao-cavalo problema) 0  0 (float (/ (objetivo) (m problema)))) :heuristica 'h  ))
                      (2 (definir-heuristica 'implementada) (run-search algoritmo (cria-no problema (posicao-cavalo problema) 0  0 (float (/ (objetivo) (m1 problema)))) :heuristica 'h1  ))))
                ( T (progn  (format t "~%          Invalid Choice~%~          Heuristic -> ")
                            (setf heuristic (read)))))))
           (return)))))













(defun menu-regras ()
  "2-Menu regras com as regras do jogo"
  (format t "
________________________________________   GAME RULES   ________________________________________
                                          (Knight Game)  
                                          
     1- Esta versão do jogo consiste num tabuleiro com 10 linhas e 10 colunas (10X10)   
     2- Em que cada casa possui uma pontuação com valor entre 00 e 99 (Aleatório),
        sem repetição nas celulas do tabuleiro.                               
     3- O objectivo do jogo é acumular mais pontos que o adversário, usando um cavalo de xadrez.
        Cada jogador tem um cavalo da sua cor (branco ou preto).                        
     4- Todas as jogadas seguintes são efectuadas através de um movimento de cavalo
        (usando as regras tradicionais do Xadrez para o cavalo).
        Um cavalo não pode saltar para uma casa vazia (sem número)
        e também não pode fazê-lo para uma casa que esteja ameaçada pelo cavalo adversário.                                 
     5- O jogo termina quando não for possível movimentar qualquer um dos cavalos no tabuleiro,
        sendo o vencedor o jogador que ganhou mais pontos.           
                                                                                          
_________________________________________________________________________________________________
  ")
  )




(defun imprime-tabuleiros ()
  "3-menu imprime problemas (Tabuleiros)"
  (loop
   (progn
     (format t "~%           ______________________________________________________")
     (format t "~%          §                   LIST OF BOARDS                     §")
     (format t "~%          §                (Preview one Board)                   §")
     (format t "~%          §                                                      §")
     (format t "~%          §                   1-Problem A                        §")
     (format t "~%          §                   2-Problem B                        §")
     (format t "~%          §                   3-Problem C                        §")
     (format t "~%          §                   4-Problem D                        §")
     (format t "~%          §                   5-Problem E                        §")
     (format t "~%          §                   6-Problem F                        §")
     (format t "~%          §                   8-Home Menu                        §")
     (format t "~%          §                                                      §")
     (format t "~%          §______________________________________________________§")
     (format t "~%~%~%          Option -> ")
     )
   (cond ((not (let ((escolha (read)))
                 (cond 
                  ((and (numberp escolha) (< escolha 9) (> escolha 0) ) (case escolha
                                                                          (1 (print (pprint (problema-A))))
                                                                          (2 (print (pprint (problema-B))))
                                                                          (3 (print (pprint (problema-C))))
                                                                          (4 (print (pprint (problema-D))))
                                                                          (5 (print (pprint (problema-E))))
                                                                          (6 (print (pprint (problema-F))))
                                                                          (8 (progn nil))))
                  ( T (progn  (format t "~%          Invalid Choice          ~%~%Option -> ")(setf escolha (read))))))) 
          (return)))))

|#

(defun ler_ficheiro (nome_ficheiro)
  "Lê um ficheiro e coloca numa lista"
  (with-open-file (file nome_ficheiro :direction :input)
    (loop for line = (read file nil)
          while line
          collect line)))

;; Examplo:
;;(ler_ficheiro (concatenate 'string (path) "problems.dat"))
