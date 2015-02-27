
(setq railshash (make-hash-table :test 'equal))

(defun get_env (key env)
  "get_env"
  (interactive)
  (gethash key
		   (gethash env
			railshash)
		   )
  )

(defun set_env (key value env)
  "set_env"
  (if (gethash env railshash)
	  railshash
	  (puthash env 
			   (make-hash-table :test 'equal)
			   railshash))
  (puthash key value (gethash env railshash)))

(set_env "root" "/Users/bretweinraub/.rover/workspaces/aurabright/bretsmac/bright_app" "bright_app")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/aurabright/bretsmac/bright-rails4" "bright4")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/MedizinMedien/bretsmac2" "mma2")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/MedizinMedien/bretsmac4" "mma4")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/finaura/bretsmac/fin3" "finaura")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/usada/bretsmac2" "usada")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/penman/bretsmac" "penman")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/penman/bretsmac2" "penman2")

(defun shell-with-command (name command accesskey)
  "Run a shell buffer with name ; and execute command with init"
  (interactive)
  (shell name)
  (pop-to-buffer name)
  (insert command)
  (condition-case nil
	  (comint-send-input)
	((debug error) nil))
;;  (global-set-key (concat "" accesskey) (quote call-last-kbd-macro))
  )

(defun use (server)
  "Begin a rails interactive environment"
  (interactive)
  (progn
	(setq rails-env server)
	(setq rover-base-path (get_env "root" server))
	))

(defun rails-start (&optional server)
  "Begin a rails interactive environment"
  (interactive)
  (if server
      nil
    (setq server "bright_app"))
  (if (get_env "root" server)
	  (setq rover-base-path (get_env "root" server))
	(setq rover-base-path (concat "~/.rover/workspaces/" (getenv "ROVERENV") "/" server)))
  (setq default-directory rover-base-path)
  (progn
	(setq rails-env server)
    (shell-with-command (concat server "-sql") (concat "cd " rover-base-path "; rails db") "S")
    (shell-with-command (concat server "-server") (concat "cd " rover-base-path "; rails s") "s")
    (shell-with-command (concat server "-console") (concat "cd " rover-base-path "; rails c") "c")
    (shell-with-command (concat server "-shell") (concat "cd " rover-base-path) "c")
    (shell-with-command (concat server "-rover") (concat "cd ~/dev/bitbucket/aura-rover-config") "c")
    ))

(defun go-to-server ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-server"))
  (end-of-buffer)
  (comint-previous-input 1)
)

(defun go-to-shell ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-shell"))
  (end-of-buffer)
  (comint-previous-input 1)
  )

(defun go-to-console ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-console"))
  (end-of-buffer)
  (comint-previous-input 1)
)

(defun go-to-sql ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-sql"))
  (end-of-buffer)
  (comint-previous-input 1)
)

(defun go-home ()
  (interactive)
  (comint-send-input)
  (insert "cd ")
  (insert rover-base-path)
  (comint-send-input)
  (comint-send-input)
  "Go to the home directory of the current root"
  )

(defun go-to-rover ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-rover"))
  (end-of-buffer)
  (comint-previous-input 1)
  )

(global-set-key "s" (quote go-to-server))

(global-set-key "c" (quote go-to-console))

(global-set-key "S" (quote go-to-sql))

(global-set-key "C" (quote go-to-shell))

(global-set-key "r" (quote go-to-rover))
(global-set-key "h" (quote go-home))

(fset 'last-console-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?c ?o ?n ?s ?o ?l ?e return escape ?> ?\M-p return ?\C-x ?o])

(fset 'last-bright_app-shell-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?s ?h ?e ?l ?l return escape ?> ?\M-p return ?\C-x ?o])

(fset 'last-sql-command
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?s ?q ?l return escape ?> return ?\M-p return ?\C-x ?o])





(global-set-key (quote [3 f1]) (quote last-console-command))
(global-set-key (quote [3 f2]) (quote last-sql-command))
(global-set-key (quote [3 f3]) (quote last-bright_app-shell-command))


(global-set-key "C" (quote go-to-shell))

(fset 'last-shell-command
   [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l ?* return escape ?> return ?! ?! return])

(global-set-key (quote [3 f4]) (quote last-shell-command))

(setq ruby-deep-indent-paren nil)

