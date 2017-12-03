
(eval-when-compile (require 'subr-x))

(setq Bright-dict (make-hash-table :test 'equal))

(assert (eq (boundp 'Bright-dict) t))

(defun Bright-dict-finder (&optional dict)
  "Return 'Bright-dict on nil argument"
  (or dict Bright-dict))
(assert (eq (Bright-dict-finder) Bright-dict))

(defun Bright-get-nested-hash (key &optional dict)
  (let ((*dict (Bright-dict-finder dict)))
    (or  (gethash key *dict)
	 ;; create the nested hash if it doesn't exist
	 (puthash key (make-hash-table :test 'equal) *dict))))

(assert (hash-table-p (Bright-get-nested-hash "test")))
(assert (hash-table-p (gethash "test" (Bright-dict-finder))))
  
(defun Bright-fetch-dict (key env &optional dict)
  "Bright-fetch-dict"
  (gethash key (Bright-get-nested-hash env)))

(defun Bright-set-dict (env key value)
  "Bright-set-dict"
  (puthash key value (Bright-get-nested-hash env))
  (message (concat "Wrote " env " -> " key " -> " value )))

;; apachedocroot
(if (equal system-type 'darwin)
    (setq apachedocroot "/Library/WebServer/Documents/")
  (setq apachedocroot "/var/www/"))


(setq Bright-user-home (getenv "HOME"))
(setq Bright-workspace-home (concat Bright-user-home "/.rover/workspaces/"))

(setq Bright-rails-list (list (cons "rails5" (concat Bright-workspace-home "aurabright/bretsmac/bright-rails5"))
			      (cons "fin3" (concat Bright-workspace-home "finaura/bretsmac/fin3"))))

;;
(defun Bright-ido-assoc (assoc-list &optional prompt)
  "Prompt [or take a prompt] to select from an assoc list, and return the result"
  (cdr (assoc (ido-completing-read
	       (or prompt
		   "Pick one? ")
	       (sort (mapcar 'car assoc-list) 'string<))
			  assoc-list)))

(defun Bright-full-setup (env &optional rails-env)
  (let ((rails-env (or rails-env
		       "rails5")))
    (Bright-set-dict env "rails-env" rails-env)
    (Bright-set-dict env "gitroot" (concat Bright-workspace-home env))
    (Bright-set-dict env "htdocs" (concat apachedocroot env))
    (Bright-set-dict env "railsroot" (cdr (assoc rails-env Bright-rails-list)))))

(defun Bright-simple-setup (env &optional rails-env)
  (Bright-full-setup (concat env "/" "bretsmac") rails-env))

(mapcar (lambda(env)
	  (Bright-simple-setup env))
	'("ncmm" "fishnick" "careofskills"))

(Bright-simple-setup "fin3" "fin3")

(defun Bright-use (&optional env)
  (interactive)
  (setq Bright-env-in-use
	(or env
	    (ido-completing-read "Pick an environment? " (hash-table-keys Bright-dict))))
  (mapcar (lambda(shell-def)
	    (lexical-let ((key (car shell-def))
			  (name (cdr shell-def)))
	      (global-set-key (kbd (concat "C-c " key))
			      (lambda ()
				(interactive)
				(Bright-start name t)))))
	  '(
	    ("S" . "sql")
	    ("c" . "console")
	    ("s" . "server")
	    ("r" . "rover")
	    ("R" . "railshell")
	    ("H" . "htdocs")
	    ("C" . "shell")
	    ))
  Bright-env-in-use)

(defun Bright-get-env-in-use ()
  "Returns the Bright Env in Use, or prompts the user to select one"
  (if (and (boundp 'Bright-env-in-use)
	   Bright-env-in-use)
      Bright-env-in-use
    (Bright-use)))

(defun Bright-run-commands(command-list)
  "Execute a series of commands in the current shell buffer"
  (mapcar (lambda (command)
	    (insert command)
	    (comint-send-input))
	  command-list))

(defun Bright-get-buffer-title(title env)
  "Based on the env type, get the buffer title.   For Rails, we are going to re-use buffers for 
different environments.
"
  (if (member title '("sql" "server" "railshell" "console"))
      (concat (Bright-fetch-dict "rails-env" Bright-env-in-use) "-" title)
    (concat env "-" title)))

(defun Bright-pop-to-buffer(buffer-title &optional command-list)
  (if (get-buffer buffer-title) ;; buffer already exists
      (progn
	(pop-to-buffer buffer-title) ;;; we are in an existing buffer
	(end-of-buffer)
	)
    (shell buffer-title))
  (Bright-run-commands command-list))  

(defun Bright-shell-with-command(title command-list do-commands)
  "Create (or pop-to) a buffer, execute a set of commands (if set), and define a hot key
to pop to it [also if set]"
  (lexical-let* ((env (Bright-get-env-in-use))
		 (buffer-title (Bright-get-buffer-title title env)))
    (if (get-buffer buffer-title) ;; buffer already exists
	(progn
	  (pop-to-buffer buffer-title) ;;; we are in an existing buffer
	  (end-of-buffer)
	  (if do-commands 
	      (Bright-run-commands command-list)))
      (progn  ;;; buffer does not exist
	(shell buffer-title)
	(Bright-run-commands command-list)
	))
    ))

(setq Bright-shell-type-env '(("sql"       . "railsroot")
			      ("server"    . "railsroot")
			      ("console"   . "railsroot")
			      ("railshell" . "railsroot")
			      ("shell"     . "gitroot")
			      ("htdocs"    . "htdocs")
			      ))

(setq Bright-additional-shell-commands
      (make-hash-table :test 'equal))

(puthash "sql" '("PAGER=cat rails db") Bright-additional-shell-commands)
(puthash "server" '("rails s") Bright-additional-shell-commands)
(puthash "console" '("rails c") Bright-additional-shell-commands)

(gethash (cdr (assoc "sql" Bright-shell-type-env)) (Bright-get-nested-hash (Bright-get-env-in-use)))

(defun Bright-get-command-list (shell-type)
  (let ((command-list (list
		       (concat "cd "
			       (gethash (cdr (assoc shell-type Bright-shell-type-env)) (Bright-get-nested-hash (Bright-get-env-in-use))))
		       ". .localenv"
		       )))
    (append command-list (gethash shell-type Bright-additional-shell-commands))))


(defun Bright-start (shell-type do-commands)
  "Takes an argument of the shell type to start"
  (Bright-shell-with-command shell-type (Bright-get-command-list shell-type) do-commands) ; nil -> access_key
  )
