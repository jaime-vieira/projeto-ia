;;; Ficheiro: projeto.lisp
;;;
;;; Descri��o: Carrega os outros ficheiros de c�digo, escreve e l� ficheiros, e trata da intera��o com o utilizador
;;;
;;; Autores: Francisco Vaz N� 202100217, Jaime Vieira N� 202100108


#|
----------------------------------------------- Diretorias ------------------------------------------------------------
|# 


;; C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3� ano\\1� Semestre\\IA\\projeto-ia\\ -> Diretoria Francisco
;; D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1� Semestre\\IA\\Projeto\\projeto-ia\\ -> Diretoria Jaime


(defun path ()
  (let ((path "C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3� ano\\1� Semestre\\IA\\projeto-ia\\ "))
    path
   )
  )


(defun path-solucao ()
   " Define o caminho at� ao ficheiro solu��o "
  (let ((ficheiro-path  ""))
    ficheiro-path)
  )


#|
----------------------------------------------- Menus e Fun��o Inicial ------------------------------------------------------------
|# 
(defun iniciar ()
  (load (compile-file(concatenate 'string (path) "problemas.dat" )))
  (load (compile-file(concatenate 'string (path) "Puzzle.lisp"   )))
  (load (compile-file(concatenate 'string (path) "Procura.lisp"  )))
  ()
  )

