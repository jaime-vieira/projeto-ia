;;; Ficheiro: projeto.lisp
;;;
;;; Descrição: Carrega os outros ficheiros de código, escreve e lê ficheiros, e trata da interação com o utilizador
;;;
;;; Autores: Francisco Vaz Nº 202100217, Jaime Vieira Nº 202100108


#|
----------------------------------------------- Diretorias ------------------------------------------------------------
|# 


;; C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3º ano\\1º Semestre\\IA\\projeto-ia\\ -> Diretoria Francisco
;; D:\\Jaime\\IPS\\Curso\\2023 - 2024\\1º Semestre\\IA\\Projeto\\projeto-ia\\ -> Diretoria Jaime


(defun path ()
  (let ((path "C:\\Users\\PC Multimedia\\OneDrive\\Ambiente de Trabalho\\LEI\\3º ano\\1º Semestre\\IA\\projeto-ia\\ "))
    path
   )
  )


(defun path-solucao ()
   " Define o caminho até ao ficheiro solução "
  (let ((ficheiro-path  ""))
    ficheiro-path)
  )


#|
----------------------------------------------- Menus e Função Inicial ------------------------------------------------------------
|# 
(defun iniciar ()
  (load (compile-file(concatenate 'string (path) "problemas.dat" )))
  (load (compile-file(concatenate 'string (path) "Puzzle.lisp"   )))
  (load (compile-file(concatenate 'string (path) "Procura.lisp"  )))
  ()
  )

