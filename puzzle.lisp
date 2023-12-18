;;; Ficheiro: puzzle.lisp
;;;
;;; Descrição: Implementação da resolução do problema
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108




;;; Tabuleiros de teste

(defun tabuleiro_teste ()
"Tabuleiro de teste sem nenhuma jogada realizada"
  '(
    (94 25 54 89 21 8 36 14 41 96) 
    (78 47 56 23 5 49 13 12 26 60) 
    (0 27 17 83 34 93 74 52 45 80) 
    (69 9 77 95 55 39 91 73 57 30) 
    (24 15 22 86 1 11 68 79 76 72) 
    (81 48 32 2 64 16 50 37 29 71) 
    (99 51 6 18 53 28 7 63 10 88) 
    (59 42 46 85 90 75 87 43 20 31) 
    (3 61 58 44 65 82 19 4 35 62) 
    (33 70 84 40 66 38 92 67 98 97)
    )
)

(defun tabuleiro_jogado ()
"Tabuleiro de teste igual ao anterior mas tendo sido colocado o cavalo na posição: i=0 e j=0"
  '(
    (T 25 54 89 21 8 36 14 41 96) 
    (78 47 56 23 5 49 13 12 26 60) 
    (0 27 17 83 34 93 74 52 45 80)
    (69 9 77 95 55 39 91 73 57 30) 
    (24 15 22 86 1 11 68 79 76 72) 
    (81 48 32 2 64 16 50 37 29 71) 
    (99 51 6 18 53 28 7 63 10 88) 
    (59 42 46 85 90 75 87 43 20 31) 
    (3 61 58 44 65 82 19 4 35 62) 
    (33 70 84 40 66 38 92 67 98 97)
    )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Seletores ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun linha (n tabuleiro)
  "Retorna a linha de um tabuleiro"
  (nth n tabuleiro)
)

(defun celula(i j tabuleiro)
  "Retorna o valor de uma celula"
  (nth j (linha i tabuleiro))
)

(defun posicao_linha (posicao)
  (car posicao)
)

(defun posicao_coluna (posicao)
  (cadr posicao)
)

(defun lista_numeros (&optional (n 100))
  (cond 
   ((<= n 0) '())
   (t (cons (- n 1) (lista_numeros (- n 1))))
  )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Funções ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun remover_se (predicado lista)
  (cond 
   ((null lista) nil)
   ((funcall predicado (car lista)) (remover_se predicado (cdr lista)))
   (t (cons (car lista) (remover_se predicado (cdr lista))))
  )
)

(defun baralhar (lista)
  (cond 
   ((null lista) nil)
   (t (let* ((indice (random (length lista)))
      (elemento (nth indice lista)))
      (cons elemento (baralhar (remover_se #'(lambda (x) (equal x elemento)) lista))))
   )
  )
)

(defun tabuleiro_aleatorio (&optional (lista (baralhar (lista_numeros))) (n 10))
 (cond
  ((null lista) nil)
  (t (cons (subseq lista 0 n) (tabuleiro_aleatorio (subseq lista n) n)))
 )
)


(defun substituir_posicao (indice lista &optional (valor NIL))
  (cond 
   ((< indice 0) lista)  ;;retorna a lista original caso o indice seja negativo
   ((null lista) lista)  ;;retorna a lista original caso a lista esteja vazia
   ((= indice 0) (cons (cond (valor valor) (t 'NIL)) (cdr lista))) ;;substitui o valor no indice 0
   (t (cons (car lista) (substituir_posicao (- indice 1) (cdr lista) valor)))
  )
)

(defun substituir (indice1 indice2 tabuleiro &optional (valor NIL))
  (substituir_posicao indice1 tabuleiro (substituir_posicao indice2 (nth indice1 tabuleiro) valor))
)


(defun posicao_cavalo_rec (tabuleiro i j)
  (cond 
   ((>= i (length tabuleiro)) nil)  
   ((>= j (length (nth i tabuleiro))) (posicao_cavalo_rec tabuleiro (+ i 1) 0))
   ((eq (celula i j tabuleiro) 'T) (list i j))
   (t (posicao_cavalo_rec tabuleiro i (+ j 1)))
  )
)  

(defun posicao_cavalo (tabuleiro)
  (posicao_cavalo_rec tabuleiro 0 0)
)



(defun regra_simetrico(n)
  (let ((unidades (mod n 10))
       (dezenas (floor n 10)))
    (+ (* unidades 10) dezenas)
  )
)


(defun movimento_valido_p (i j tabuleiro)
  (let ((n_linhas (length tabuleiro))
        (n_colunas (length (car tabuleiro))))
    (and (>= i 0) (< i n_linhas)
         (>= j 0) (< j n_colunas)
         (not (null (celula i j tabuleiro)))
    )
  )
)

(defun cavalo_no_tabuleiro_p (tabuleiro)
  (cond 
   ((eq (posicao_cavalo tabuleiro) 'NIL) NIL)
   (t T)
  )
)

(defun colocar_cavalo(i j tabuleiro)
  (substituir i j tabuleiro T)
)


(defun regra_duplo (numero)
  (cond
   ((not (numberp numero)) nil)
   ((= numero 0) nil)
   ((and (= (floor numero 10) (mod numero 10)) (numberp numero)) t)
   (t nil)
  )
)

(defun lista_duplos (tabuleiro)
  (cond 
   ((null tabuleiro) '())
   ((listp (car tabuleiro)) 
    (append (lista_duplos (car tabuleiro)) (lista_duplos (cdr tabuleiro))))
   ((regra_duplo (car tabuleiro)) 
    (cons (car tabuleiro) (lista_duplos (cdr tabuleiro))))
   (t (lista_duplos (cdr tabuleiro)))
  )
)

(defun posicoes_duplos (tabuleiro)
  "Localização dos duplos"
  (labels ((posicao_duplo_rec (tabuleiro i j contador)
             (cond 
              ((>= i (length tabuleiro)) contador)
              ((>= j (length (nth i tabuleiro)))
                  (posicao_duplo_rec tabuleiro (+ i 1) 0 contador))
              ((regra_duplo (celula i j tabuleiro))
                  (posicao_duplo_rec tabuleiro i (+ j 1) (cons (list i j) contador)))
              (t (posicao_duplo_rec tabuleiro i (+ j 1) contador))
             )))
    (posicao_duplo_rec tabuleiro 0 0 '())
  )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Operador Geral  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun criar_estado (pontos tabuleiro)
  (cons pontos tabuleiro)
)

(defun tabuleiro_do_estado (estado)
  (cdr estado)
)

(defun pontos_do_estado (estado)
  (car  estado)
)


(defun verificar_nos_repetidos (estado fechados)
  "Verifica se o tabuleiro do estado já existe na lista de nós fechados."
  (cond 
    ((null fechados) estado)
        (t (let* ((tabuleiro-estado (tabuleiro_do_estado estado))
                   (tabuleiro-no (tabuleiro_do_estado (estado_no (first fechados)))))
             (cond ((equal tabuleiro-estado tabuleiro-no) nil)
                   (t (verificar_nos_repetidos estado (rest fechados)))
             ))
         )
  )
)


(defun operador (estado salto)
  (let* ((pontos (pontos_do_estado estado))
         (tabuleiro (tabuleiro_do_estado estado))
         (posicao (posicao_cavalo tabuleiro))
         (i (posicao_linha posicao))
         (j (posicao_coluna posicao)))
    (cond ((and (cavalo_no_tabuleiro_p tabuleiro) (movimento_valido_p (+ i (posicao_linha salto)) (+ j (posicao_coluna salto)) tabuleiro))
           (let* ((novo_tabuleiro (substituir i j tabuleiro NIL))  ; Remover cavalo da posição atual
                  (novo_i (+ i (posicao_linha salto)))
                  (novo_j (+ j (posicao_coluna salto))))
             (cond ((movimento_valido_p novo_i novo_j tabuleiro)
                    (criar_estado (+ pontos (celula novo_i novo_j tabuleiro)) (substituir novo_i novo_j novo_tabuleiro T))
                   )
                   (t nil)))) ; Se a nova posição for inválida, retorna o estado original
          (t nil)
    )
  )
)