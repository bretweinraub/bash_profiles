


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

(setq apachedocroot "/Library/WebServer/Documents/")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/ncmm/bretsmac") "ncmm")
(set_env "htdocs" (concat apachedocroot "ncmm/bretsmac") "ncmm")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/fishnick/bretsmac") "fishnick")
(set_env "htdocs" (concat apachedocroot "fishnick/bretsmac") "fishnick")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/aura-store") "aura-store")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/careofskills") "careofskills")
(set_env "htdocs" (concat apachedocroot "careofskills/bretsmac") "careofskills")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/fulcra") "fulcra")
(set_env "root" (concat (getenv "HOME") "/dev/gitlab/bright_ci/") "bright_ci")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/aurabright/bretsmac/bright-rails4") "bright4")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/aurabright/bretsmac/bright-rails5") "bright5")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/aurabright/bretsmac/qna") "qna")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/bright/bretsmac") "bright")
(set_env "htdocs" (concat apachedocroot "bright/bretsmac") "bright")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/medtronic/bretsmac_prodcopy2") "medtronic2")
(set_env "htdocs" (concat apachedocroot "medtronic/bretsmac_prodcopy2") "medtronic2")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac2") "mma2")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac4") "mma4")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac6") "mma6")
(set_env "htdocs" (concat apachedocroot "MedizinMedien/bretsmac6") "mma6")
(set_env "htdocs" (concat apachedocroot "MedizinMedien/bretsmac4") "mma4")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/yntp/bretsmac") "yntp")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/ynltp/ynltp_prodclone") "ynltp")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/finaura/bretsmac/fin3") "finaura")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/usada/bretspro_prodclone") "usada")
(set_env "htdocs" (concat apachedocroot "usada/bretspro_prodclone") "usada")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac") "penman")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac2") "penman2")
(set_env "htdocs" (concat apachedocroot "penman/bretsmac2") "penman2")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/aura_website/bretsmac") "aura_website")
(set_env "htdocs" (concat apachedocroot "aura_website/bretsmac") "aura_website")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac3") "penman3")
(set_env "htdocs" (concat apachedocroot "penman/bretsmac3") "penman3")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac4") "penman4")
(set_env "htdocs" (concat apachedocroot "penman/bretsmac4") "penman4")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/knowledgefront/bretsmac") "knowledgefront")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/ccgcloud/bretsmac") "ccgcloud")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/ccgcloud/bretsmac2") "ccgcloud2")
(set_env "htdocs" (concat apachedocroot "ccgcloud/bretsmac2") "ccgcloud2")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/vinca/bretsmac") "vinca")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/justculture/bretsmac") "justculture")
(set_env "htdocs" (concat apachedocroot "justculture/justculture_com_replica") "justculture2")

(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/silverbullet/bretsmac") "silverbullet")
(set_env "root" (concat (getenv "HOME") "/.rover/workspaces/justculture/justculture_com_replica") "justculture2")
(set_env "htdocs" (concat apachedocroot "justculture/justculture_com_replica") "justculture2")
(set_env "htdocs" (concat apachedocroot "vinca/bretsmac") "vinca")

(defun shell-with-command (name command accesskey)
  "Run a shell buffer with name ; and execute command with init"
  (interactive)
  (shell name)
  (pop-to-buffer name)
  (insert command)
  (condition-case nil
	  (comint-send-input)
	((debug error) nil))
  )

(defun use (&optional s &optional r)
  "Begin a rails interactive environment"
  (interactive)
  (if s
      (setq server s)
    (setq server (read-from-minibuffer "Rover Envirornment? ")))
  (if r
      (setq rails-env r)
    (setq rails-env (read-from-minibuffer "Rails Envirornment? ")))
  (if rails-env
      t
    (setq rails-env server))
  (setq rover-env server)
  (setq rover-base-path (get_env "root" server))
  (setq htdocs-base-path (get_env "htdocs" server))
  (setq server-base-path (get_env "root" rails-env))
  (rails-start server rails-env)
  )

(defun rails-start (server rails-env)
  "Begin a rails interactive environment"
  (interactive)
  (if (get_env "root" server)
	  (setq rover-base-path (get_env "root" server))
	(setq rover-base-path (concat "~/.rover/workspaces/" (getenv "ROVERENV") "/" server)))
  (setq default-directory rover-base-path)
  (setq htdocs-base-path (get_env "htdocs" server))
  (shell-with-command (concat rails-env "-sql") (concat "cd " server-base-path "; rails db") "S")
  (shell-with-command (concat rails-env "-server") (concat "cd " server-base-path "; rails s") "s")
  (shell-with-command (concat rails-env "-console") (concat "cd " server-base-path "; rails c") "c")
  (shell-with-command (concat rails-env "-railsshell") (concat "cd " server-base-path) "r")
  (shell-with-command (concat server "-shell") (concat "cd " rover-base-path) "c")
  (shell-with-command (concat server "-rover") (concat "cd ~/dev/gitlab/aura-rover-config; r " rover-env) "c")
  (shell-with-command (concat server "-htdocs") (concat  "cd " htdocs-base-path) "H")
  )

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
  (pop-to-buffer (concat rover-env "-htdocs"))
  (end-of-buffer)
  (comint-previous-input 1)
)


(defun go-to-shell ()
  (interactive)
  ""
  (pop-to-buffer (concat rover-env "-shell"))
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
  (concat rails-env "-sql")
  (message "%s" (concat rails-env "-sql"))
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
  (insert (concat "cd ~/dev/gitlab/aura-rover-config; r " rover-env))
  (comint-send-input)
  (comint-send-input)
  "Go to the home directory of the current root"
  )


(defun go-to-rover ()
  (interactive)
  ""
  (pop-to-buffer (concat rover-env "-rover"))
  (end-of-buffer)
  (comint-previous-input 1)
  )

(defun go-to-railsshell ()
  (interactive)
  ""
  (pop-to-buffer (concat rails-env "-railsshell"))
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
(global-set-key "R" (quote go-to-railsshell))
(global-set-key "h" (quote go-home))
(global-set-key "o" (quote get-project-org-file))
(global-set-key "d" (quote go-to-db-migrate))
(global-set-key "f" (quote rails-find))

(global-set-key "C" (quote go-to-shell))

(defun edit-this-file ()
  (interactive)
  ""
  (find-file-other-window "~/bash_profiles/bdw/emacs/rails.el" t)
)


(global-set-key "l" (quote edit-this-file))

(fset 'last-shell-command
   [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l ?* return escape ?> return ?! ?! return])

(global-set-key (quote [3 f4]) (quote last-shell-command))

(setq ruby-deep-indent-paren nil)
