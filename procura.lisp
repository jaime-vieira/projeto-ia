;;; Ficheiro: procura.lisp
;;;
;;; Descri��o: Implementa��o dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz N� 202100217, Jaime Vieira N� 202100108

#|
----------------------------------------------- Algoritmos ------------------------------------------------------------
|# 




(defun no-existep (no lista)
  (eval (cons 'or(mapcar #'(lambda(x) (and(equal (no-estado-tabuleiro no) (no-estado-tabuleiro x))(>= (no-profundidade no)(no-profundidade x))))lista))))




#|
----------------------------------------------- BFS ------------------------------------------------------------
|#  


(defun abertos-bfs (abertos sucessores)
  "Devolve a lista de abertos do BFS"
  (append abertos sucessores))

(defun bfs (no funcao-objetivo sucessores operadores &optional (abertos (list no)) (fechados nil))
  (cond 
    ((null abertos) nil)
    ((funcall funcao-objetivo no 'bfs) (list no (+ (length abertos) (length fechados)) (length fechados)))
    ((member no fechados) (bfs (car abertos) funcao-objetivo sucessores operadores (abertos-bfs (cdr abertos) (funcall sucessores no operadores 'bfs nil)) fechados))
    (t (bfs (car abertos) funcao-objetivo sucessores operadores (pushnew (funcall sucessores no operadores 'bfs nil) abertos) fechados))))


#|
----------------------------------------------- DFS ------------------------------------------------------------
|#  

(defun abertos-dfs (abertos sucessores)
  "Devolve a lista de abertos do DFS"
  (append sucessores abertos))

(defun dfs (no profundidade &optional (abertos (list no)) (fechados nil))
  "Se profundidade do N� chegar � profundidade fornecida, retorna-se o estado atual do n� independente do objetivo"
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

#|
----------------------------------------------- A* ------------------------------------------------------------
|#  


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






#|
----------------------------------------------- SMA* ------------------------------------------------------------
|# 





#|
----------------------------------------------- IDA* ------------------------------------------------------------
|# 


(defun h (node goal)
  ;; Fun��o heur�stica
  ;; Retorna o custo estimado do n� ao objetivo
  ...)

(defun a-star (node g h-cost limit)
  (let ((f (+ g (h-cost node))))
    (cond ((> f limit) f)
          ((equal node goal) 'found)
          (t (loop for successor in (generate-successors node)
                   do
                   (let ((new-g (+ g (cost node successor))))
                     (let ((result (a-star successor new-g h-cost limit)))
                       (cond ((equal result 'found) 'found)
                             ((< result f) (setq f result))))))
    f))

(defun ida-star (start goal)
  ;; Fun��o principal para IDA*
  (let ((limit (h start goal)))
    (loop until (equal (a-star start 0 #'h limit) 'found)
          do (setq limit (+ limit 1)))))
