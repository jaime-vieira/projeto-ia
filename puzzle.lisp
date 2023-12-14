;;; Ficheiro: puzzle.lisp
;;;
;;; Descrição: Implementação da resolução do problema
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108

;;;; laboratorio7.lisp
;;;; Ficha de Laboratório nº7 - Apoio ao 1º projeto
;;;; Autor: 


;;; Tabuleiros


(defun tabuleiro-teste ()
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

(defun tabuleiro-jogado ()
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


#|
----------------------------------------------- Seletores ------------------------------------------------------------
|# 

(defun linha (n tabuleiro)
  (nth n tabuleiro)
)

(defun celula(i1 i2 tabuleiro)
  (nth i2 (linha i1 tabuleiro))
)

(defun posicao-linha (posicao)
  (car posicao)
)

(defun posicao-coluna (posicao)
  (cadr posicao)
)

(defun lista-numeros (&optional (n 100))
  (cond ((<= n 0) '())
        (t (cons (- n 1) (lista-numeros (- n 1))))
  )
)

#|
----------------------------------------------- FUNÇÕES AUXILIARES ------------------------------------------------------------
|# 

(defun remover-se (predicado lista)
  (cond ((null lista) nil)
        ((funcall predicado (car lista)) (remover-se predicado (cdr lista)))
        (t (cons (car lista) (remover-se predicado (cdr lista))))
  )
)

(defun baralhar (lista)
  (cond ((null lista) nil)
        (t (let* ((indice (random (length lista)))
                  (elemento (nth indice lista)))
             (cons elemento (baralhar (remover-se #'(lambda (x) (equal x elemento)) lista))))
        )
  )
)

(defun tabuleiro-aleatorio (&optional (lista (baralhar (lista-numeros))) (n 10))
 (cond
 ((null lista) nil)
 (t (cons (subseq lista 0 n) (tabuleiro-aleatorio (subseq lista n) n)))
 )
)



(defun substituir-posicao (indice lista &optional (valor NIL))
  (cond ((< indice 0) lista)  ;;índice negativo -> lista original
        ((null lista) lista)  ;;lista vazia -> lista original
        ((= indice 0) (cons (cond (valor valor) (t 'NIL)) (cdr lista))) ;;substituir valor no indice 0
        (t (cons (car lista) (substituir-posicao (- indice 1) (cdr lista) valor)))
  )
)

(defun substituir (indice1 indice2 tabuleiro &optional (valor NIL))
  (substituir-posicao indice1 tabuleiro
                      (substituir-posicao indice2 (nth indice1 tabuleiro) valor))
)


(defun posicao-cavalo-rec (tabuleiro i j)
  (cond ((>= i (length tabuleiro)) nil)  
        ((>= j (length (nth i tabuleiro)))  
         (posicao-cavalo-rec tabuleiro (+ i 1) 0))
        ((eq (celula i j tabuleiro) 'T)  
         (list i j))
        (t (posicao-cavalo-rec tabuleiro i (+ j 1)))
  )
)  

(defun posicao-cavalo (tabuleiro)
  (posicao-cavalo-rec tabuleiro 0 0))


#|
---------------------------------------------------- Operadores -------------------------------------------------------
|#

(defun simetrico(n)
  (let ((unidades (mod n 10))
       (dezenas (floor n 10)))
    (+ (* unidades 10) dezenas))
)


(defun movimento-valido-p (i j tabuleiro)
  (let ((nlinhas (length tabuleiro))
        (ncolunas (length (car tabuleiro))))
    (and (>= i 0) (< i nlinhas)
         (>= j 0) (< j ncolunas)
         (not (null (celula i j tabuleiro)))
         )
    )
  )

(defun cavalo-no-tabuleiro-p (tabuleiro)
  (cond ((eq (posicao-cavalo tabuleiro) 'NIL) NIL)
        (t T)
   )
)

(defun colocar-cavalo(i j tabuleiro)
  (substituir i j tabuleiro T)
)


(defun regra-duplo (numero)
  (cond
   ((not (numberp numero)) nil)
   ((= numero 0) nil)
   ((and (= (floor numero 10) (mod numero 10)) (numberp numero)) t)
   (t nil)
   )
)

(defun lista-duplos (tabuleiro)
  (cond 
   ((null tabuleiro) '())
   ((listp (car tabuleiro)) 
    (append (lista-duplos (car tabuleiro)) (lista-duplos (cdr tabuleiro))))
   ((regra-duplo (car tabuleiro)) 
    (cons (car tabuleiro) (lista-duplos (cdr tabuleiro))))
   (t (lista-duplos (cdr tabuleiro)))
   )
 )

(defun posicoes-duplos (tabuleiro)
  (labels ((posicao-duplo-rec (tabuleiro i j contador)
             (cond ((>= i (length tabuleiro)) contador)
                   ((>= j (length (nth i tabuleiro)))
                    (posicao-duplo-rec tabuleiro (+ i 1) 0 contador))
                   ((regra-duplo (celula i j tabuleiro))
                    (posicao-duplo-rec tabuleiro i (+ j 1) (cons (list i j) contador)))
                   (t (posicao-duplo-rec tabuleiro i (+ j 1) contador)))))
    (posicao-duplo-rec tabuleiro 0 0 '()))
)

 

(defun operador-1 (tabuleiro)
  (let* ((posicao (posicao-cavalo tabuleiro))
         (i (posicao-linha posicao))
         (j (posicao-coluna posicao)))
    (cond ((and (cavalo-no-tabuleiro-p tabuleiro) (movimento-valido-p (+ i 2) (+ j 1) tabuleiro)
                )
           (let* ((novo-tabuleiro (substituir i j tabuleiro NIL))  ; Remover cavalo da posição atual
                  (novo-i (+ i 2))
                  (novo-j (+ j c)))
             (cond ((movimento-valido-p novo-i novo-j tabuleiro)
                    (substituir novo-i novo-j novo-tabuleiro T))  ; Colocar cavalo na nova posição
                   (t (substituir i j novo-tabuleiro T)))))  ; Colocar cavalo de volta na posição original se nova posição inválida
          (t tabuleiro))
    )
  )

(defun criar-estado (pontos tabuleiro)
  (list pontos tabuleiro))

(defun tabuleiro-do-estado (estado)
  (car estado))

(defun pontos-do-estado (estado)
  (cdr estado))

;; Tentativa de generalizar o operador 

(defun operador (estado salto)
  (let* ((tabuleiro (tabuleiro-do-estado estado))
         (pontos-atuais (pontos-do-estado estado))
         (posicao (posicao-cavalo tabuleiro))
         (i (posicao-linha posicao))
         (j (posicao-coluna posicao))
         (salto-i (posicao-linha salto))
         (salto-j (posicao-coluna salto)))
    (cond ((and (cavalo-no-tabuleiro-p tabuleiro) (movimento-valido-p (+ i salto-i) (+ j salto-j) tabuleiro))
           (let* ((novo-tabuleiro (substituir i j tabuleiro NIL))  ; Remover cavalo da posição atual
                  (novo-i (+ i salto-i))
                  (novo-j (+ j salto-j)))
             (cond ((movimento-valido-p novo-i novo-j tabuleiro)
                    (list (criar-estado (substituir novo-i novo-j novo-tabuleiro T) 
                  (+ pontos-atuais (celula novo-i novo-j tabuleiro)))))
                   (t (list estado)))))) ; Se a nova posição for inválida, retorna o estado original
          (t (list estado))))

#|
----------------------------------------------------REPRESENTAÇÃO DE ESTADOS-------------------------------------------------------
|# 

(defun cria-no (tabuleiro pontos profundidade pai &optional (heuristica 0))                           
  (list tabuleiro pontos profundidade pai heuristica))





