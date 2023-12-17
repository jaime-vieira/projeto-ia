;;; Ficheiro: procura.lisp
;;;
;;; Descrição: Implementação dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Nós ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; cria no
(defun cria_no (estado &optional (profundidade 0) (pai NIL) (heuristica 0))                           
  (list estado profundidade pai heuristica)
)

;; vai buscar o estado do tabuleiro 
(defun estado_no (no)
  (first no)
)

;; vai buscar a profundidade 
(defun profundidade_no (no)
  (second no)
)

;; vai buscar o no pai
(defun no_pai (no)
  (third no)
)

;; vai buscar a heuristica
(defun no_heuristica (no)
  (fourth no)
)

(defun custo_do_no (no)
  (+ (profundidade_no no) (no_heuristica no)))


(defun ver_nos_repetidos (estado fechados)
  "Verifica se o tabuleiro do estado já existe na lista de nós fechados."
  (cond ((null fechados) estado)
        (t (let* ((tabuleiro_estado (estado_no estado))
                   (tabuleiro_no (estado_no (first fechados))))
             (cond ((equal tabuleiro_estado tabuleiro_no) nil)
                   (t (ver_nos_repetidos estado (rest fechados)))
             ))
         )
  )
)

(defun sucessores (no abertos fechados)
  (let* ((saltos_possiveis '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))
         (novos_estados (apply #'append 
             (mapcar #'(lambda (salto)
                         (cond  ((null (operador (estado_no no) salto)) nil)
                                (t (list (operador (estado_no no) salto)))
                          ))
                    saltos_possiveis)))
         (novos_sucessores (apply #'append 
             (mapcar #'(lambda (estado)
                 (list (ver_nos_repetidos (cria_no estado (1+ (profundidade_no no)) no) fechados)))
                    novos_estados)))
         (novos_abertos (append abertos novos_sucessores)))
    novos_abertos
  )
)

(defun no_existep (no lista)
  (eval (cons 'or (mapcar #'(lambda(x) (and (equal (estado_tabuleiro no) (estado_tabuleiro x)) (>= (profundidade_no no) (profundidade_no x)))) lista))))


(defun falhou ()
  (format t "Não conseguiu atingir o objetivo mínimo.~%"))





;;;;;;;;;;;;;;;;; DFS ;;;;;;;;;;;;;;;;;

(defun dfs (abertos fechados objetivo)
  (cond ((null abertos) (falhou))
        (t (let* ((no (first abertos))
                  (novos_fechados (cons no fechados))
                  (nos_sucessores (sucessores no abertos fechados))
                  (novos_abertos (append nos_sucessores (rest abertos)))
                  (no_objetivo (devolve_no_objetivo nos_sucessores objetivo)))
             (cond ((null no_objetivo) (dfs novos_abertos novos_fechados objetivo))
                   (t (caminho_objetivo no_objetivo)))))))


;;;;;;;;;;;;;;;;; BFS ;;;;;;;;;;;;;;;;


(defun bfs (abertos fechados objetivo)
  (cond ((null abertos) (falhou))
        (t (let* ((no (first abertos))  
                  (novos_fechados (cons no fechados))
                  (nos_sucessores (sucessores no abertos fechados) )
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


;;;;;;;;;;;;;;;;;; A* ;;;;;;;;;;;;;;; 





