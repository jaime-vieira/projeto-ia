;;; Ficheiro: procura.lisp
;;;
;;; Descrição: Implementação dos algoritmos de procura BFS, DFS e A*
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Nós ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun cria_no (estado &optional (profundidade 0) (pai NIL) (heuristica 0))
  "Cria um nó."
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
  (format t "Não conseguiu atingir o objetivo mínimo.~%")
)


(defun caminho_objetivo (no)
  (cond ((null no) nil)
        (t ( append (caminho_objetivo (no_pai no)) (list (posicao_cavalo (tabuleiro_do_estado (estado_no no))))))
  )
)

;; codigo do mario para ser refactored


(defun pontosQueFaltam (objetivo estado)
  (- objetivo (pontos_do_estado estado))
)

(defun contarNumerosTabuleiro (tabuleiro)
  (apply #'+ (mapcar #'(lambda (linha)
                         (contaNumeros linha)) tabuleiro))
)

(defun contaNumeros (lista)
  (cond ((null lista) 0)
        ((numberp (first lista)) (+ 1 (contaNumeros (rest lista))))
        (t (contaNumeros (rest lista)))
  )
)


(defun somaLista (lista)
  (cond ((null lista) 0)
        ((numberp (first lista)) (+ (first lista) (somaLista (rest lista)) ))
        (t (somaLista (rest lista)))
  )
)



(defun somaTabuleiro (tabuleiro)
  (apply #'+ (mapcar #'(lambda (linha)
                         (somaLista linha)) tabuleiro))
)

(defun mediaDePontosPorCasa (estado)
  (let* ((tabuleiro (tabuleiro_do_estado estado))
        (soma (somaTabuleiro tabuleiro))
        (numeroDeCasas (contarNumerosTabuleiro tabuleiro)))
    (/ soma numeroDeCasas)
   )
)

(defun heuristica (objetivo estado)
  (/ (pontosQueFaltam objetivo estado) (mediaDePontosPorCasa estado))
)

(defun sortNovosAbertos (lista-de-nos)
  "Ordena uma lista de nós crescentemente pelo custo"
  (sort lista-de-nos #'< :key #'custo_do_no)
)

(defun sucessoresH (no fechados objetivo)
  (let* ((saltosPossiveis '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))
         (novosEstados (apply #'append 
             (mapcar #'(lambda (salto)
                         (cond  ((null (operador (estado_no no) salto)) nil)
                                (t (list (operador (estado_no no) salto)))
                          ))
                    saltosPossiveis)))
         (novosSucessores (apply #'append 
             (mapcar #'(lambda (estado)
                 (list (ver_nos_repetidos (cria_no estado (1+ (profundidade_no no)) no (heuristica objetivo estado)) fechados)))
                    novosEstados)))
         )
          novosSucessores
          )
)


;; fim codigo


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
                   (t (list no_objetivo (length novos_fechados) (+ (length novos_fechados) (length novos_abertos)) 
                            (/ (profundidade_no no_objetivo) (+ (length novos_fechados) (length novos_abertos))))
                    
                    ;(print_results (caminho_objetivo no_objetivo) (tabuleiro_do_estado (estado_no no_objetivo)))
                   )
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
                   (t 
                    ;(print_results (caminho_objetivo no_objetivo) (tabuleiro_do_estado (estado_no no_objetivo)))
                   )
             )
             )
           )
  )
)


;;;;;;;;;;;;;;;;;; A* ;;;;;;;;;;;;;;; 


(defun a_asterisco (abertos fechados objetivo)
  "Algoritmo de procura A*"
  (cond ((null abertos) (falhou))
        (t (let* ((no (first abertos))
                  (novosFechados (cons no fechados))
                  (nosSucessores (sucessoresH no fechados objetivo))
                  (novosAbertos (sortNovosAbertos (append nosSucessores (rest abertos))))
                  (noObjetivo (devolve_no_objetivo nosSucessores objetivo)))
             (cond ((null noObjetivo) (a_asterisco novosAbertos novosFechados objetivo))
                   (t 
                    (print_results (caminho_objetivo noObjetivo)
                                   (tabuleiro_do_estado (estado_no noObjetivo))))
             )
            )
         )
  )
)



;;;;;;;;;;;;;;;;; Auxiliares da Consola ;;;;;;;;;;;;;;;;;



(defun print_results (caminho_objetivo tabuleiro_objetivo)
  (format t "~%********** Resultados **********~%")
  (format t "~%  Caminho final:~%")
  (print_list_Caminho caminho_objetivo)
  (format t "~%~%~%  Tabuleiro final:~%")
  (print_list_Tabuleiro tabuleiro_objetivo)
)

(defun print_list_Caminho (elements)
  (cond
   ((null elements) '()) 
   (t (format t "  ~a" (car elements))
      (when (cdr elements)
        (format t ","))
      (print_list_Caminho (cdr elements))))
)

(defun print_list_Tabuleiro (elements)
  (cond
    ((null elements) '())
    (t
      (format t "~%  ~a" (car elements))
      (print_list_Tabuleiro (cdr elements))))
)