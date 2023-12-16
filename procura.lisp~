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
  (let* ((tabuleiro-atual (tabuleiro-do-estado no))
         (saltos-possiveis '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))
         (novos-sucessores '()))
    
    (defun aplicar-salto (posicao salto)
      (mapcar #'+ posicao salto))
    
    (defun criar-no (novo-estado)
      (cria_no novo-estado
               (+ (profundidade_no no) 1)
               no))
    
    ;; Aplicar operador com todos os saltos possíveis
    (dolist (salto saltos-possiveis)
      (let ((novo-estado (aplicar-salto tabuleiro-atual salto))
            (novo-no nil))
        ;; Criar nós a partir dos estados devolvidos
        (setq novo-no (criar-no novo-estado))
        
        ;; Verificar se o nó está na lista de fechados
        (unless (some #'(lambda (x) (equal (estado_tabuleiro novo-no) (estado_tabuleiro x))) fechados)
          ;; Adicionar à lista dos novos-sucessores
          (push novo-no novos-sucessores))))
    
    ;; Adicionar novos-sucessores à lista de abertos
    (append abertos novos-sucessores)
  )
)

(defun no_existep (no lista)
  (eval (cons 'or (mapcar #'(lambda(x) (and (equal (estado_tabuleiro no) (estado_tabuleiro x)) (>= (profundidade_no no) (profundidade_no x)))) lista))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Algoritmos ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;; BFS ;;;;;;;;;;;;;;;;




(defun abertos-bfs (abertos sucessores)
  "Devolve a lista de abertos do BFS"
  (append sucessores abertos))

(defun bfs (no funcao-objetivo sucessores operadores &optional (abertos (list no)) (fechados nil))
  (cond 
    ((null abertos) nil)
    ((funcall funcao-objetivo no 'bfs) (list no (+ (length abertos) (length fechados)) (length fechados)))
    ((member no fechados) (bfs (car abertos) funcao-objetivo sucessores operadores (abertos-bfs (cdr abertos) (funcall sucessores no operadores 'bfs nil)) fechados))
    (t (bfs (car abertos) funcao-objetivo sucessores operadores (abertos-bfs (cdr abertos) (funcall sucessores no operadores 'bfs nil)) (pushnew no fechados)))))




;;;;;;;;;;;;;;;;; DFS ;;;;;;;;;;;;;;;;;




(defun abertos-dfs (abertos sucessores)
  "Devolve a lista de abertos do DFS"
  (append sucessores abertos))

(defun dfs (no profundidade &optional (abertos (list no)) (fechados nil))
  "Se profundidade do Nó chegar à profundidade fornecida, retorna-se o estado atual do nó independente do objetivo"
  (cond 
    ((= (no-profundidade no) profundidade) (list no (+ (length abertos) (length fechados)) (length fechados)))
    ((no-solucaop no 'dfs) (list no (+ (length abertos) (length fechados)) (length fechados)))
    ((null abertos) nil)
    (t (let ((cabeca (car abertos))
             (resto (cdr abertos))
             (novos-sucessores
               (apply #'append 
                      (mapcar #'(lambda (suc)
                                  (if (or (null abertos) (not (member suc fechados)))
                                      (list suc)))
                              (sucessores cabeca (operadores) 'dfs 'h profundidade)))))
         (dfs cabeca profundidade (abertos-dfs resto novos-sucessores) (cons cabeca fechados)))
    )
  )
)

(defun dfs-v2 (no f-solucao f-sucessores ops prof)
  (let ((abertos (list no))
        (fechados '()))
    (labels ((algoritmo (a f)
               (let* ((cabeca (car a))
                      (sucessores (funcall f-sucessores cabeca ops 'dfs 'h prof))
                      (solucao (remove nil (mapcar #'(lambda (x) (cond ((funcall f-solucao x 'dfs) x) (t nil))) sucessores))))
                 (cond ((not (null solucao)) solucao)
                       ((= (no-profundidade cabeca) prof) nil)
                       (t (algoritmo (abertos-dfs (cdr a) (suce-existe sucessores a f)) (cons cabeca f)))))))
      (algoritmo abertos fechados))))

(defun suce-existe (suce lista f)
  (if (null suce) nil
      (let ((cabeca (car suce)))
        (if (null (no-existep cabeca lista))
            (cons cabeca (suce-existe (cdr suce) lista f))
            (suce-existe (cdr suce) lista f)))))




;;;;;;;;;;;;;;;;;; A* ;;;;;;;;;;;;;;; 





(defun quicksort (nodes)
  "Quicksort algorithm for sorting nodes based on heuristic values."
  (if (null nodes)
      nil
      (let* ((pivot (car nodes))
             (rest (cdr nodes))
             (less-than-pivot (lambda (a) (< (node-heuristic a) (node-heuristic pivot)))))
        (append (quicksort (remove-if-not less-than-pivot rest))
                (list pivot)
                (quicksort (remove-if less-than-pivot rest))))))

(defun sort-nodes (nodes)
  "Sorts nodes based on their cost for use in the A* algorithm."
  (sort (copy-seq nodes) #'< :key #'node-cost))

(defun a-star (initial-node heuristic &optional (open-nodes (list initial-node)) (closed-nodes nil))
  "A* algorithm implementation."
  (cond
    ((goal-test initial-node 'a-star) (list initial-node (+ (length open-nodes) (length closed-nodes)) (length closed-nodes)))
    ((null open-nodes) nil)
    (t (let ((current-node (car open-nodes))
             (successors (apply #'append
                                (mapcar #'(lambda (s) (if (or (null open-nodes) (node-exists-p s closed-nodes))
                                                        '()
                                                        (list s)))
                                        (successors current-node (operators) 'a-star heuristic)))))
         (a-star current-node heuristic (quicksort (append (cdr open-nodes) successors)) (cons current-node closed-nodes))))))

(defun a-star-v2 (initial-node goal-test successors operators heuristic &optional (open-nodes (list initial-node)) (closed-nodes nil))
  "A* algorithm with a different interface."
  (cond
    ((null open-nodes) nil)
    ((funcall goal-test initial-node 'a-star) (list initial-node (+ (length open-nodes) (length closed-nodes)) (length closed-nodes)))
    ((node-exists-p initial-node closed-nodes) (a-star-v2 (car open-nodes) goal-test successors operators heuristic (cdr open-nodes) closed-nodes))
    (t (let ((current-node (car open-nodes))
             (successors (funcall successors current-node operators 'a-star heuristic)))
         (a-star-v2 current-node goal-test successors operators heuristic (quicksort (append (cdr open-nodes) successors)) (cons current-node closed-nodes))))))






;;;;;;;;;;;;;;;;;;;; SMA* ;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;; IDA* ;;;;;;;;;;;;;;;;;;;



