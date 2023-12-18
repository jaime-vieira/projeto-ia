;;; Ficheiro: procura.lisp
;;;
;;; Descri��o: Implementa��o dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz N� 202100217, Jaime Vieira N� 202100108



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; N�s ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun cria_no (estado &optional (profundidade 0) (pai NIL) (heuristica 0))
  "Cria um n�."
  (list estado profundidade pai heuristica)
)

(defun estado_no (no)
  "Devolve o estado do tabuleiro"
  (first no)
)

(defun profundidade_no (no)
  "Devolve a profundidade"
  (second no)
)

(defun no_pai (no)
  "Devolve o no pai."
  (third no)
)

(defun no_heuristica (no)
  "Devolve a heuristica."
  (fourth no)
)

(defun custo_do_no (no)
  (+ (profundidade_no no) (no_heuristica no))
)

(defun devolve_no_objetivo(sucessores objetivo)
  (cond ((null sucessores) NIL)
        ((no_objetivo_p (car sucessores) objetivo) (car sucessores))
        (t (devolve_no_objetivo (cdr sucessores) objetivo))
  )
)


(defun ver_nos_repetidos (estado fechados)
  "Verifica se o tabuleiro do estado j� existe na lista de n�s fechados."
  (cond ((null fechados) estado)
        (t (let* ((tabuleiro_estado (estado_no estado))
                   (tabuleiro_no (estado_no (first fechados))))
             (cond ((equal tabuleiro_estado tabuleiro_no) nil)
                   (t (ver_nos_repetidos estado (rest fechados)))
             ))
         )
  )
)

(defun sucessores (no fechados)
  (let* ((saltos_possiveis '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))
         (novos_estados (apply #'append 
             (mapcar #'(lambda (salto)
                         (cond  ((null (operador (estado_no no) salto)) nil)
                                (t (list (operador (estado_no no) salto)))
                          ))
                    saltos_possiveis)))
         (novos_sucessores (apply #'append 
             (mapcar #'(lambda (estado)
                 (list (verificar_nos_repetidos (cria_no estado (1+ (profundidade_no no)) no) fechados)))
                    novos_estados)))
         )
         novos_sucessores
  )
)

(defun no_existep (no lista)
  (eval (cons 'or (mapcar #'(lambda(x) (and (equal (estado_tabuleiro no) (estado_tabuleiro x)) (>= (profundidade_no no) (profundidade_no x)))) lista))))

(defun devolve_no_objetivo(sucessores objetivo)
  (cond ((null sucessores) NIL)
        ((no_objetivo_p (car sucessores) objetivo) (car sucessores))
        (t (devolve_no_objetivo (cdr sucessores) objetivo))
  )
)

(defun no_objetivo_p (no objetivo)
  (>= (pontos_do_estado (estado_no no)) objetivo)
)

(defun falhou ()
  (format t "N�o conseguiu atingir o objetivo m�nimo.~%")
)


(defun caminho_objetivo (no)
  (cond ((null no) nil)
        (t ( append (caminho_objetivo (no_pai no)) (list (posicao_cavalo (tabuleiro_do_estado (estado_no no))))))
  )
)


;;;;;;;;;;;;;;;;; BFS ;;;;;;;;;;;;;;;;


(defun bfs (abertos fechados objetivo)
  (cond ((null abertos) (falhou))
        (t (let* ((no (first abertos))  
                  (novos_fechados (cons no fechados))
                  (nos_sucessores (sucessores no fechados) )
                  (novos_abertos (append (rest abertos) nos_sucessores))
                  (no_objetivo (devolve_no_objetivo nos_sucessores objetivo))
                  )
             (cond ((null no_objetivo) (bfs novos_abertos novos_fechados objetivo))
                   (t (caminho_objetivo no_objetivo))
                   )
             )
        )
  )
)


;;;;;;;;;;;;;;;;; DFS ;;;;;;;;;;;;;;;;;


(defun dfs (abertos fechados objetivo)
  (cond ((null abertos) (falhou))
        (t (let* ((no (first abertos))  
                  (novos_fechados (cons no fechados))
                  (nos_sucessores (sucessores no fechados) )
                  (novos_abertos (append nos_sucessores (rest abertos)))
                  (no_objetivo (devolve_no_objetivo nos_sucessores objetivo))
                  )
             (cond ((null no_objetivo) (bfs novos_abertos novos_fechados objetivo))
                   (t (caminho_objetivo no_objetivo))
                   )
             )
           )
  )
)


;;;;;;;;;;;;;;;;;; A* ;;;;;;;;;;;;;;; 





