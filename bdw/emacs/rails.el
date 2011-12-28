
(defun shell-with-command (name command accesskey)
  "Run a shell buffer with name ; and execute command with init"
  (interactive)
  (shell name)
  (pop-to-buffer name)
  (insert command)
  (comint-send-input)
;;  (global-set-key (concat "" accesskey) (quote call-last-kbd-macro))
  )

(defun rails-start (&optional server)
  "Begin a rails interactive environment"
  (interactive)
  (if server
      nil
    (setq server "iportal"))
  (progn
    (shell-with-command (concat server "-sql") "SQL" "S")
    (shell-with-command (concat server "-console") "console" "c")
    (shell-with-command (concat server "-server") "server" "s")
    (shell-with-command (concat server "-shell") "cd $TOP" "C")
    ))


(defun go-to-server ()
  (interactive)
  ""
  (pop-to-buffer "iportal-server")
  (end-of-buffer))

(defun go-to-shell ()
  (interactive)
  ""
  (pop-to-buffer "iportal-shell")
  (end-of-buffer))

(defun go-to-console ()
  (interactive)
  ""
  (pop-to-buffer "iportal-console")
  (end-of-buffer))

(defun go-to-sql ()
  (interactive)
  ""
  (pop-to-buffer "iportal-sql")
  (end-of-buffer))

(global-set-key "s" (quote go-to-server))

(global-set-key "c" (quote go-to-console))

(global-set-key "S" (quote go-to-sql))

(global-set-key "C" (quote go-to-shell))

(fset 'last-console-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?c ?o ?n ?s ?o ?l ?e return escape ?> ?\M-p return ?\C-x ?o])

(fset 'last-iportal-shell-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?s ?h ?e ?l ?l return escape ?> ?\M-p return ?\C-x ?o])

(fset 'last-sql-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?s ?q ?l return escape ?> return ?\M-p return ?\C-x ?o])





(global-set-key (quote [3 f1]) (quote last-console-command))
(global-set-key (quote [3 f2]) (quote last-sql-command))
(global-set-key (quote [3 f3]) (quote last-iportal-shell-command))


(global-set-key "C" (quote go-to-shell))

(fset 'last-shell-command
   [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l ?* return escape ?> return ?! ?! return])

(global-set-key (quote [3 f4]) (quote last-shell-command))
