
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
(set_env "root" "/Users/bretweinraub/dev/bitbucket/bright_ci/" "bright_ci")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/aurabright/bretsmac/bright-rails4" "bright4")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/bright/bretsmac" "bright")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/medtronic/bretsmac_prodcopy2" "medtronic2")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/MedizinMedien/bretsmac2" "mma2")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/MedizinMedien/bretsmac4" "mma4")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/MedizinMedien/bretsmac6" "mma6")
(set_env "htdocs" "/usr/htdocs/MedizinMedien/bretsmac4" "mma4")

(set_env "root" "/Users/bretweinraub/.rover/workspaces/yntp/bretsmac" "yntp")

(set_env "root" "/Users/bretweinraub/.rover/workspaces/finaura/bretsmac/fin3" "finaura")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/usada/bretsmac2" "usada")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/penman/bretsmac" "penman")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/penman/bretsmac2" "penman2")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/penman/bretsmac3" "penman3")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/knowledgefront/bretsmac" "knowledgefront")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/ccgcloud/bretsmac" "ccgcloud")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/ccgcloud/bretsmac2" "ccgcloud2")
(set_env "htdocs" "/usr/htdocs/ccgcloud/bretsmac2" "ccgcloud2")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/vinca/bretsmac" "vinca")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/justculture/bretsmac" "justculture")
(set_env "root" "/Users/bretweinraub/.rover/workspaces/justculture/justculture_com_replica" "justculture2")
(set_env "htdocs" "/usr/htdocs/vinca/bretsmac" "vinca")

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

(defun use ()
  "Begin a rails interactive environment"
  (interactive)
  (setq server (read-from-minibuffer "Use Envirornment? "))
  (progn
	(setq rails-env server)
	(setq rover-base-path (get_env "root" server))
	(setq htdocs-base-path (get_env "htdocs" server))
	(if (get-buffer (concat server "-shell"))
		t
	  (rails-start server))
	)
  )

(defun rails-start (&optional server)
  "Begin a rails interactive environment"
  (interactive)
  (if server
	  t
	(progn (
			(setq server (read-from-minibuffer "Search text? "))
			(if server
				nil
			  (setq server "bright_app"))
			)
		   )
	)
  (if (get_env "root" server)
	  (setq rover-base-path (get_env "root" server))
	(setq rover-base-path (concat "~/.rover/workspaces/" (getenv "ROVERENV") "/" server)))
  (setq default-directory rover-base-path)
  (setq htdocs-base-path (get_env "htdocs" server))
  (progn
	(setq rails-env server)
    (shell-with-command (concat server "-sql") (concat "cd " rover-base-path "; rails db") "S")
    (shell-with-command (concat server "-server") (concat "cd " rover-base-path "; rails s") "s")
    (shell-with-command (concat server "-console") (concat "cd " rover-base-path "; rails c") "c")
    (shell-with-command (concat server "-shell") (concat "cd " rover-base-path) "c")
    (shell-with-command (concat server "-rover") (concat "cd ~/dev/bitbucket/aura-rover-config") "c")
    (shell-with-command (concat server "-htdocs") (concat  "cd " htdocs-base-path) "H")
    ))

(defun go-to-server ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-server"))
  (end-of-buffer)
  (comint-previous-input 1)
)

(defun go-to-htdocs ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-htdocs"))
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

(defun go-to-rover-home ()
  (interactive)
  (comint-send-input)
  (insert "cd ~/dev/bitbucket/aura-rover-config")
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

(defun get-project-org-file ()
  (interactive)
  "get the project org file in another window"
  (find-file-other-window (concat rover-base-path "/project.org") t)
  )

(defun go-to-db-migrate ()
  (interactive)
  "get the project org file in another window"
  (find-file-other-window (concat rover-base-path "/db/migrate") t)
  )

(defun rails-find ()       ; Interactive version.                                                                              
  "rails-find"
  (interactive)
  (setq text (read-from-minibuffer "Search text? "))
  (find-name-dired (concat rover-base-path "/app") (concat "*" text "*"))
)

(global-set-key "s" (quote go-to-server))
(global-set-key "H" (quote go-to-htdocs))

(global-set-key "c" (quote go-to-console))

(global-set-key "S" (quote go-to-sql))

(global-set-key "C" (quote go-to-shell))

(global-set-key "r" (quote go-to-rover))
(global-set-key "R" (quote go-to-rover-home))
(global-set-key "h" (quote go-home))
(global-set-key "o" (quote get-project-org-file))
(global-set-key "d" (quote go-to-db-migrate))
(global-set-key "f" (quote rails-find))

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

