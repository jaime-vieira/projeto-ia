;;; Ficheiro: procura.lisp
;;;
;;; Descrição: Implementação dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Nós ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; cria no
(defun cria_no (estado profundidade pai &optional (heuristica 0))                           
  (list (pontos-do-estado estado) (tabuleiro-do-estado estado) profundidade pai heuristica)
)

;; vai buscar os pontos 
(defun pontos (no)
  (first no)
)

;; vai buscar o estado do tabuleiro 
(defun estado_tabuleiro (no)
  (second no)
)

;; vai buscar a profundidade 
(defun profundidade_no (no)
  (third no)
)

;; vai buscar o no pai
(defun no_pai (no)
  (fourth no)
)

;; vai buscar a heuristica
(defun no_heuristica (no)
  (fifth no)
)

(defun custo_do_no (no)
  (+ (profundidade_no no) (no_heuristica no)))


(defun sucessores (no abertos fechados)
  (let* ((saltos-possiveis '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))
         (novos-estados (apply #'append 
             (mapcar #'(lambda (salto)
                         (cond  ((null (operador (estadoNo no) salto)) nil)
                                (t (list (operador (estadoNo no) salto)))
                          ))
                    saltos-possiveis)))
         (novos-sucessores (apply #'append 
             (mapcar #'(lambda (estado)
                 (list (criarNo estado (1+ (profundidadeNo no)) no)))
                    novos-estados)))
         (novos-abertos (append abertos novos-sucessores)))
          novos-abertos
          )
)

(defun no_existep (no lista)
  (eval (cons 'or (mapcar #'(lambda(x) (and (equal (estado_tabuleiro no) (estado_tabuleiro x)) (>= (profundidade_no no) (profundidade_no x)))) lista))))







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
  (cond ((null abertos) (fail))
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





