;;; Ficheiro: projeto.lisp
;;;
;;; Descrição: Carrega os outros ficheiros de código, escreve e lê ficheiros, e trata da interação com o utilizador
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108


;Diretórios

;; C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3º ano\\1º Semestre\\IA\\projeto-ia\\ -> Diretoria Francisco
;; D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\ -> Diretoria Jaime

(defun path ()
  (let ((path "D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\")) path)
)

(defun ler_ficheiro (nome_ficheiro)
  "Lê um ficheiro e coloca numa lista"
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
    (format t "~%Escolha um número entre 1 e 2:~%")
    (let ((opcao (read)))
     (cond 
      ((= opcao 1) (format t "~%A começar o jogo...~%") (menu_escolha_problema) (return-from menu_inicial))
      ((= opcao 2) (format t "~%A sair... Até à próxima!~%") (return-from menu_inicial))
      (t (format t "~%Escolha inválida. ~%"))
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
    (format t "~%~% Escolha uma opção de 1 a 7:")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inválida.~%"))
      ((= opcao 1) (menu_escolha_casa 0) (return-from menu_escolha_problema))
      ((= opcao 2) (menu_escolha_casa 1) (return-from menu_escolha_problema))
      ((= opcao 3) (menu_escolha_casa 2) (return-from menu_escolha_problema))
      ((= opcao 4) (menu_escolha_casa 3) (return-from menu_escolha_problema))
      ((= opcao 5) (menu_escolha_casa 4) (return-from menu_escolha_problema))
      ((= opcao 6) (menu_escolha_casa 5) (return-from menu_escolha_problema))
      ((= opcao 0) (menu_inicial) (return-from menu_escolha_problema))
      (t (format t "~%Escolha inválida.~%"))
     )
   )
 )
)


(defun menu_escolha_casa (problema)
  "Menu de escolha de tipo de jogo"
  (loop
     (format t "~%Escolha apenas uma posição com valores da primeira")      
     (format t "~%linha para o cavalo(0 para Menu Inicial):~%")
     (let ((opcao (read)))
      (cond 
       ((or (not (numberp opcao)) (< opcao 0) (> opcao 10)) (format t "~%Escolha inválida.~%"))
       ((= opcao 0) 
        (menu_inicial) (return-from menu_escolha_casa)
       )
       ((and (>= opcao 1) (<= opcao 10))
        (let* ((ficheiro (ler_ficheiro (concatenate 'string (path) "problemas.dat")))
              (pontos (car (nth problema ficheiro))) 
              (tabuleiro (cdr (nth problema ficheiro))))
          (cond
           ((movimento_valido_p 0 (1- opcao) tabuleiro)
            ;(menu_algoritmos (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro)))
            (format t "~%Escolha certa.~%")
            #|(format t "~{~a~^, ~}~%" tabuleiro)
            (format t "~a ~%" pontos)|#
            ;(format t "~{~a~^, ~}~%" (tabuleiro_do_estado (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro))))
            ;(format t "~a ~%" (pontos_do_estado (criar_estado pontos (colocar_cavalo 0 (1- opcao) tabuleiro))))
           )
           (t (format t "~%Escolha inválida.~%"))
          )
        )
       )
       (t (format t "~%Valor inválido.~%"))
      )
     )
   )
)


(defun menu_algoritmos (estado)
 "Menu de escolha do algoritmo"
 (loop
    (format t "~%Escolha um Algoritmo:~%")
    (format t "~%1 - BFS")
    (format t "~%2 - DFS")
    (format t "~%3 - A*")
    (format t "~%0 - Menu Inicial")
    (format t "~%~% Escolha uma opção de 1 a 3:")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inválida.~%"))
      ((= opcao 1) (executar_estatisticas 'bfs estado) (return-from menu_algoritmos))
      ((= opcao 2) (executar_estatisticas 'dfs estado) (return-from menu_algoritmos))
      ((= opcao 3) (executar_estatisticas 'a_asterisco) (return-from menu_algoritmos))
      ((= opcao 0) (menu_inicial) (return-from menu_algoritmos))
      (t (format t "~%Escolha inválida.~%"))
     )
   )
 )
)

(defun menu_heuristica (estado)
 "Menu de escolha do algoritmo"
 (loop
    (format t "~%Escolha a heuristica:~%")
    (format t "~%1 - h(x) = o(x)/m(x)")
    (format t "~%2 - Implementada")
    (format t "~%0 - Menu Inicial")
    (format t "~%~% Escolha uma opção de 1 a 2:")
    (let ((opcao (read)))
     (cond 
      ((= opcao 1) (executar_estatisticas 'bfs estado) (return-from menu_algoritmos))
      ((= opcao 2) (executar_estatisticas 'dfs estado) (return-from menu_algoritmos))
      ((= opcao 0) (menu_inicial) (return-from menu_algoritmos))
     )
    )
 )
)


(defun executar_estatisticas (algoritmo estado)
  (cond 
      ((= opcao 1) (menu_escolha_casa 0) (return-from menu_algoritmos))
      ((= opcao 2) (menu_escolha_casa 1) (return-from menu_algoritmos))
      ((= opcao 3) (menu_escolha_casa 2) (return-from menu_algoritmos))
      (t NIL)
  )
)



