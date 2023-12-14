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


(defun path-solucao ()
   "Caminho da solu��o"
  (let ((ficheiro-path  "D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1� Semestre\\IA\\Projeto\\projeto-ia\\solucao.dat")) ficheiro-path)
)


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
    (format t "~%1. Iniciar Jogo")
    (format t "~%2. Sair~%")
    (format t "~%Escolha um n�mero entre 1 e 2:~%")
    (let ((opcao (read)))
     (cond 
      ((= opcao 1) (format t "~%A come�ar o jogo...~%") (menu_escolha_problema))
      ((= opcao 2) (format t "~%A sair... At� � pr�xima!~%") (return))
      (t (format t "~%Escolha inv�lida. ~%"))
     )
    )
  )
)


(defun menu_escolha_problema ()
 "Menu de escolha do problema"
 (loop
    (format t "~%1-Problema A")
    (format t "~%2-Problema B")
    (format t "~%3-Problema C")
    (format t "~%4-Problema D")
    (format t "~%5-Problema E")
    (format t "~%6-Problema F")
    (format t "~%7-Menu Inicial")
    (format t "~%~% Escolha uma op��o de 1 a 7:")
    (let ((opcao (read)))
     (cond 
      ((not (numberp opcao)) (format t "~%Escolha inv�lida.~%"))
      ((= opcao 1) (progn (definir-objetivo 'A) (menu-escolha (problema-A) ) t))
      ((= opcao 2) (progn (definir-objetivo 'B) (menu-escolha (problema-B) ) t))
      ((= opcao 3) (progn (definir-objetivo 'C) (menu-escolha (problema-C) ) t))
      ((= opcao 4) (progn (definir-objetivo 'D) (menu-escolha (problema-D) ) t))
      ((= opcao 5) (progn (definir-objetivo 'E) (menu-escolha (problema-E) ) t))
      ((= opcao 6) (progn (definir-objetivo 'F) (menu-escolha (problema-F) ) t))
      ((= opcao 7) (menu_inicial))
      (t (format t "~%Escolha inv�lida.~%"))
     )
    )
 )
)



#|(defun menu_inicial ()
  "Menu Inicial"
  (progn
    (format t "~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%"                                 )
    (loadingBar)
    (format t "~%           ______________________________________________________~%"    )
    (format t "~%                              W E L C O M E                ~%"          ) 
    (format t "~%                                    TO                           ~%~%"  )      
    (loading)
    (format t "~%                                                                 ~%"    ) 
    (format t "~%           ______________________________________________________~%"    ) 
    (loadingBar)
    (menu-principal)
  )
)




(defun menu-principal ()
  "Menu principal com as opc�es do programa"
  (loop
    (progn
      (format t "~%~%~%~%~%~%~%~%~%")
      (format t "~%           ______________________________________________________")
      (format t "~%          �                  JOGO DO CAVALO                      �")
      (format t "~%          �                   (Knight Game)                      �")
      (format t "~%          �                                                      �")
      (format t "~%          �                                                      �")
      (format t "~%          �                                                      �")
      (format t "~%          �                 1-Solve a Game                       �")
      (format t "~%          �                 2-Game Rules                         �")
      (format t "~%          �                 3-Show Boards                        �")
      (format t "~%          �                 4-Quit                               �")
      (format t "~%          �                                                      �")
      (format t "~%          �______________________________________________________�")

      (format t "~%~%~%          Option -> ")
      )
    (cond ((not (let ((escolha (read)))
               (cond 
                ((and (numberp escolha) (< escolha 5) (> escolha 0)) (case escolha
                                                    (1 (progn (menu-tabuleiros) t))
                                                    (2 (progn (menu-regras)  t))
                                                    (3 (progn (imprime-tabuleiros) t))
                                                    (4 (progn (format t "~%~%~%          PROGRAMA TERMINADO") nil))))
                ( T (progn  (format t "~%          Invalid Choice~%~%          Option -> ")
                            (setf escolha (read))))))) 
(return)))))









(defun menu-tabuleiros ()
"1- Menu para escolher o problema a resolver"
(loop
    (progn
      (format t "~%           ______________________________________________________")
      (format t "~%          �                CHOOSE THE BOARD                      �")
      (format t "~%          �                                                      �")
      (format t "~%          �                 1-Problem A                          �")
      (format t "~%          �                 2-Problem B                          �")
      (format t "~%          �                 3-Problem C                          �")
      (format t "~%          �                 4-Problem D                          �")
      (format t "~%          �                 5-Problem E                          �")
      (format t "~%          �                 6-Problem F                          �")
      (format t "~%          �                 7-Home Menu                          �")
      (format t "~%          �                                                      �")
      (format t "~%          �______________________________________________________�")
      (format t "~%~%~%          Option -> ")
      )
    (cond ((not (let ((escolha (read)))
               (cond 
                ((and (numberp escolha) (< escolha 9) (> escolha 0)) (case escolha
                                                    (1 (progn (definir-objetivo 'A) (menu-escolha (problema-A) ) t))
                                                    (2 (progn (definir-objetivo 'B) (menu-escolha (problema-B) ) t))
                                                    (3 (progn (definir-objetivo 'C) (menu-escolha (problema-C) ) t))
                                                    (4 (progn (definir-objetivo 'D) (menu-escolha (problema-D) ) t))
                                                    (5 (progn (definir-objetivo 'E) (menu-escolha (problema-E) ) t))
                                                    (6 (progn (definir-objetivo 'F) (menu-escolha (problema-F) ) t))                                                   
                                                    (7 (progn  nil))))
                ( T (progn  (format t "~%          Invalid Choice~%~%          Option -> ")
                            (setf escolha (read)))))))
 (return)))))






(defun menu-escolha (problema)
  "1.1 Sub menu escolhe algoritmo ap�s ter escolhido o tabuleiro"
  (loop
   (progn
     (format t "~%           ______________________________________________________")
     (format t "~%          �                                                      �")
     (format t "~%          �                      GAME MODES                      �")
     (format t "~%          �                                                      �")
     (format t "~%          �                                                      �")
     (format t "~%          �                 1-GO TO ALGORITHM                    �")
     (format t "~%          �                 2-CONFIGURE BOARD                    �")
     (format t "~%          �                                                      �")
     (format t "~%          �                 0-Home Menu                          �")
     (format t "~%          �                                                      �")
     (format t "~%          �______________________________________________________�") 
     (format t "~%~%~%          Option -> ")
     )
   (cond ((not (let ((escolha (read))) 
                 (cond 
                  ((and (numberp escolha) (< escolha 3) (> escolha -1)) (case escolha
                                                                          (1 (menu-algoritmos problema))
                                                                          (2 (menu-Configurar-tabuleiro problema ))
                                                                          (0 (progn  NIL))))
                  ( T (progn  (format t "~%          Invalid Choice~%~%          Option -> ")
                        (setf escolha (read)))))))
          (return)))))




|#