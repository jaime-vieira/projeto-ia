;;; Ficheiro: projeto.lisp
;;;
;;; Descri��o: Carrega os outros ficheiros de c�digo, escreve e l� ficheiros, e trata da intera��o com o utilizador
;;;
;;; Autores: Francisco Vaz N� 202100217, Jaime Vieira N� 202100108


;Diret�rios

;; C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3� ano\\1� Semestre\\IA\\projeto-ia\\ -> Diretoria Francisco
;; D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1� Semestre\\IA\\Projeto\\projeto-ia\\ -> Diretoria Jaime

(defun path ()
  (let ((path "D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1� Semestre\\IA\\Projeto\\projeto-ia\\")) path)
)

(defun ler_ficheiro (nome_ficheiro)
  "L� um ficheiro e coloca numa lista"
  (with-open-file (file nome_ficheiro :direction :input)
    (loop for line = (read file nil)
          while line
          collect line)))

;; Exemplo:
;;(ler_ficheiro (concatenate 'string (path) "problemas.dat"))


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
    (format t "~%Escolha um n�mero entre 1 e 2: ")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inv�lida.~%"))
      ((= opcao 1) (format t "~%A come�ar o jogo...~%") (menu_escolha_problema) (return-from menu_inicial))
      ((= opcao 2) (format t "~%A sair... At� � pr�xima!~%") (return-from menu_inicial))
      (t (format t "~%Escolha inv�lida. ~%"))
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
    (format t "~%0 - Menu Inicial")
    (format t "~%~% Escolha uma op��o de 1 a 7: ")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inv�lida.~%"))
      ((= opcao 1) (menu_escolha_casa 0) (return-from menu_escolha_problema))
      ((= opcao 2) (menu_escolha_casa 1) (return-from menu_escolha_problema))
      ((= opcao 3) (menu_escolha_casa 2) (return-from menu_escolha_problema))
      ((= opcao 4) (menu_escolha_casa 3) (return-from menu_escolha_problema))
      ((= opcao 5) (menu_escolha_casa 4) (return-from menu_escolha_problema))
      ((= opcao 6) (menu_escolha_casa 5) (return-from menu_escolha_problema))
      ((= opcao 0) (menu_inicial) (return-from menu_escolha_problema))
      (t (format t "~%Escolha inv�lida.~%"))
     )
   )
 )
)


(defun menu_escolha_casa (problema)
  "Menu de escolha de tipo de jogo"
  (loop
     (format t "~%Escolha apenas uma posi��o com valores da primeira")      
     (format t "~%linha para o cavalo(0 para Menu Inicial):~%")
     (let ((opcao (read)))
      (cond 
       ((or (not (numberp opcao)) (< opcao 0) (> opcao 10)) (format t "~%Escolha inv�lida.~%"))
       ((= opcao 0) 
        (menu_inicial) (return-from menu_escolha_casa)
       )
       ((and (>= opcao 1) (<= opcao 10))
        (let* ((ficheiro (ler_ficheiro (concatenate 'string (path) "problemas.dat")))
              (pontos (car (nth problema ficheiro))) 
              (tabuleiro (cdr (nth problema ficheiro))))
          (cond
           ((movimento_valido_p 0 (1- opcao) tabuleiro)
            ;(menu_algoritmos (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro))) (return-from menu_escolha_casa)
            (menu_algoritmos (nth problema ficheiro) (1- opcao)) (return-from menu_escolha_casa)
            ;(format t "~%Escolha certa.~%")
            #|(format t "~{~a~^, ~}~%" tabuleiro)
            (format t "~a ~%" pontos)|#
            ;(format t "~{~a~^, ~}~%" (tabuleiro_do_estado (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro))))
            ;(format t "~a ~%" (pontos_do_estado (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro))))
           )
           (t (format t "~%Escolha inv�lida.~%"))
          )
        )
       )
       (t (format t "~%Valor inv�lido.~%"))
      )
     )
   )
)


(defun menu_algoritmos (problema casa)
 "Menu de escolha do algoritmo"
 (loop
    (format t "~%Escolha um Algoritmo:~%")
    (format t "~%1 - BFS")
    (format t "~%2 - DFS")
    (format t "~%3 - A*")
    (format t "~%0 - Menu Inicial")
    (format t "~%~% Escolha uma op��o de 1 a 3: ")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inv�lida.~%"))
      ((= opcao 1) (executar 'bfs problema casa) (return-from menu_algoritmos))
      ((= opcao 2) (executar 'dfs problema casa) (return-from menu_algoritmos))
      ((= opcao 3) (menu_heuristica problema casa) (return-from menu_algoritmos))
      ((= opcao 0) (menu_inicial) (return-from menu_algoritmos))
      (t (format t "~%Escolha inv�lida.~%"))
     )
   )
 )
)

(defun menu_heuristica (problema casa)
 "Menu de escolha da heur�stica"
 (loop
    (format t "~%Escolha a heur�stica:~%")
    (format t "~%1 - h(x) = o(x)/m(x)")
    (format t "~%2 - Implementada")
    (format t "~%0 - Menu Inicial")
    (format t "~%~% Escolha uma op��o de 1 a 2: ")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inv�lida.~%"))
      ((= opcao 1) (executar 'a_asterisco problema casa) (return-from menu_heuristica))
      ((= opcao 2) (executar 'a_asterisco_melhorado problema casa) (return-from menu_heuristica))
      ((= opcao 0) (menu_inicial) (return-from menu_heuristica))
      (t (format t "~%Escolha inv�lida.~%"))
     )
    )
 )
)


(defun executar (algoritmo problema casa)
  (let ((pontos (car problema)) 
        (tabuleiro (cdr problema)))
   (cond 
      ((eq algoritmo 'bfs) (mostrar_estatisticas algoritmo problema (bfs (list (cria_no (criar_estado (celula 0 casa tabuleiro) (colocar_cavalo 0 casa tabuleiro)))) '() pontos)))
      ((eq algoritmo 'dfs) (mostrar_estatisticas algoritmo problema (dfs (list (cria_no (criar_estado (celula 0 casa tabuleiro) (colocar_cavalo 0 casa tabuleiro)))) '() pontos)))
      ((eq algoritmo 'a_asterisco) (mostrar_estatisticas algoritmo problema (a_asterisco (list (cria_no (criar_estado (celula 0 casa tabuleiro) (colocar_cavalo 0 casa tabuleiro)) 0 nil (heuristica pontos (criar_estado (celula 0 casa tabuleiro) (colocar_cavalo 0 casa tabuleiro))))) '() pontos)))
      ((eq algoritmo 'a_asterisco_melhorado) )
      (t NIL)
   )
  )
)


(defun mostrar_estatisticas (algoritmo problema estatisticas) 
  (cond 
   ((eq estatisticas nil) (format t "~%Objetivo n�o alcan�ado."))
   (t 
        (format t "~%~%--- Estat�sticas ---~% ~%")
        (format t "~% Algoritmo: ~a ~%" algoritmo)
        (format t "~% Profundidade: ~a~%" (profundidade_no (first estatisticas)))
        (format t "~% Tamanho da solu��o: ~a" (profundidade_no (first estatisticas))) 
        (format t "~% N�s gerados: ~a" (third estatisticas))
        (format t "~% N�s expandidos: ~a" (second estatisticas))
        (format t "~% Penetr�ncia: ~f" (fourth estatisticas))
        (format t "~% Pontos: ~d" (pontos_do_estado (estado_no (first estatisticas))))
        (format t "~% Objetivo: ~d" (car problema))
        ;(format t "~%Average branching factor ~f ~%" () )
      (cond 
       ((>= (pontos_do_estado (estado_no (first estatisticas))) (car problema)) (format t "~%~%Objetivo Alcan�ado"))
       (T (format t "~%~%Objetivo N�o Alcan�ado"))
      )
   )
  )
)