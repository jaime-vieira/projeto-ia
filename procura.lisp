;;; Ficheiro: procura.lisp
;;;
;;; Descrição: Implementação dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108

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
  ________________SMA*_________________
|# 
;;(set-max-nos 4)
(let ((memoria))
"CLOSER para definir memoria"
(defun set-max-nos  (max)
  (setf memoria max)
)

(defun SMA-STAR (abertos sucessores)
" SMA* devolve a lista de abertos com os novos sucessores ordenados pelo custo exatamente como o A* "
"Remove o numero de nos do fim da lista que sejam igual ou superior á memoria definida"
  (let ((open (sort (append sucessores (cdr abertos)) #'< :key #'no-custo)))
    (cond
      ((>= (length open) memoria) (SMA-STAR-REMOVE open (- (length open) memoria))) 
      (T open)
    )
  )
)

(defun SMA-STAR-REMOVE (lista n &optional (tamanho (length lista)))
"Retorna a lista com os elemntos removidos no fim da lista"
  (cond
    ((null lista) nil)
    ((= n tamanho) nil)
    (T (cons (car lista) (SMA-STAR-REMOVE (cdr lista) n (1- tamanho))))
  )
)
)








;Teste:(set-max-nos 4) (SMA* (NO-TESTE) 'H)
(defun SMA*(no heuristica &optional (abertos (list no)) (fechados nil))
  (cond 
   ((no-solucaop no 'a-star) (list no (+(length abertos)(length fechados)) (length fechados)  ))
   ((null abertos) nil)
   (t (SMA* (car abertos) heuristica (SMA-STAR (cdr abertos) 
                                                   (apply #'append 
                                                          (mapcar  #'(lambda (suc) (if (or (null abertos) (no-existep suc fechados)) '() (list suc))) 
                                                                   (sucessores (car abertos) (operadores) 'a-star heuristica )))) (cons  (car abertos) fechados)))
   )
  )




#|
  ________________IDA* INCOMPLETE_________________
|# 



(defun IDA*(no heuristica &optional (abertos (list no)) (fechados nil))
  (cond 
   ((no-solucaop no 'a-star) (list no (+(length abertos)(length fechados)) (length fechados)  ))
   ((null abertos) nil)
   (t (IDA* (car abertos) heuristica (get-limiar-nodes (cdr abertos) 
                                                   (apply #'append 
                                                          (mapcar  #'(lambda (suc) (if (or (null abertos) (no-existep suc fechados)) '() (list suc))) 
                                                                 (get-new-limiar  (sucessores (car abertos) (operadores) 'a-star heuristica ))))) (cons  (car abertos) fechados)))
   )
  )


(defun get-lowest-f(abertos)
  "Retorna o no de uma lista com o valor f mais baixo"
  (cond
   ((= (length abertos) 1) (car abertos))
   (T (let ((node (get-lowest-f(cdr abertos))))
        (if (< (no-custo (car abertos)) (no-custo node))
            (car abertos) node)))  
   )
  )


;TESTE: (get-limiar-nodes  (list (no-teste)) (get-new-limiar (sucessores (no-teste) (operadores) 'a-star 'h) ))
(defun get-limiar-nodes(abertos limiar)
"Recebe uma lista e um dado limiar e retorna uma lista de nos cujo valor F seja <= a esse limiar"
"f'(n)<=L"
  (remove nil (mapcar #'(lambda(node) (if (<= (no-custo node) limiar) node NIL)) abertos)) 
)

(defun get-new-limiar(list)
"Retorna o valo f mais baixo de uma lista de nos"
  (no-custo (get-lowest-f list))
)
