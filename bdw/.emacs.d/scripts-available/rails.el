
;; Bright Environment Shell for Emacs
;;
;; Manages launching shells for various aspects of Bright development.
;;
;; bright.el
;;

(setq bright-dict (make-hash-table :test 'equal))

(defun bright-fetch-dict (key env)
  "bright-fetch-dict"
  (interactive)
  (gethash key (gethash env bright-dict))
  )


(defun bright-set-dict (key value env)
  "bright-set-dict"
  (if (gethash env bright-dict)
      bright-dict
    ;; create the nested hash if it doesn't exist     
    (puthash env 
	     (make-hash-table :test 'equal)
	     bright-dict))
  ;; set the value
  (progn
    (puthash key value (gethash env bright-dict))
    (message (concat "Wrote " env " -> " key " -> " value ))
    )
  )

;; apachedocroot
(if (equal system-type 'darwin)
    (setq apachedocroot "/Library/WebServer/Documents/")
  (setq apachedocroot "/var/www/"))


(defun bright-full-setup (env default-env)
  ;; example (bright-full-setup "ncmm" "bretsmac")
  ;; $HOME/.rover/workspaces/$ENV/bretsmac
  (bright-set-dict "root" (concat (getenv "HOME")
				  "/.rover/workspaces/" env
				  "/" default-env) env)
  ;; $WEBROOT/bretsmac/$ENV
  (bright-set-dict "htdocs" (concat apachedocroot env "/" default-env) 
		   env)
  )


(bright-full-setup "ncmm" "bretsmac")

(mapcar ( lambda(env-name)
	  (bright-full-setup env-name "bretsmac" ) )
	'("ncmm" "fishnick" "careofskills"))

;;


(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/fulcra") "fulcra")
(bright-set-dict "root" (concat (getenv "HOME") "/dev/gitlab/bright_ci/") "bright_ci")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/aurabright/bretsmac/bright-rails4") "bright4")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/aurabright/bretsmac/bright-rails5") "bright5")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/meteor5/bretsmac/meteor5") "meteor5")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/bright/bretsmac/qna") "qna")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/bright/bretsmac") "bright")
(bright-set-dict "htdocs" (concat apachedocroot "bright/bretsmac") "bright")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/medtronic/bretsmac_prodcopy2") "medtronic2")
(bright-set-dict "htdocs" (concat apachedocroot "medtronic/bretsmac_prodcopy2") "medtronic2")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac2") "mma2")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac4") "mma4")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/MedizinMedien/bretsmac6") "mma6")
(bright-set-dict "htdocs" (concat apachedocroot "MedizinMedien/bretsmac6") "mma6")
(bright-set-dict "htdocs" (concat apachedocroot "MedizinMedien/bretsmac4") "mma4")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/yntp/bretsmac") "yntp")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/ynltp/ynltp_prodclone") "ynltp")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/finaura/bretsmac/fin3") "finaura")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/usada/bretspro_prodclone") "usada")
(bright-set-dict "htdocs" (concat apachedocroot "usada/bretspro_prodclone") "usada")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac") "penman")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac2") "penman2")
(bright-set-dict "htdocs" (concat apachedocroot "penman/bretsmac2") "penman2")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/aura_website/bretsmac") "aura_website")
(bright-set-dict "htdocs" (concat apachedocroot "aura_website/bretsmac") "aura_website")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac3") "penman3")
(bright-set-dict "htdocs" (concat apachedocroot "penman/bretsmac3") "penman3")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/penman/bretsmac4") "penman4")
(bright-set-dict "htdocs" (concat apachedocroot "penman/bretsmac4") "penman4")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/knowledgefront/bretsmac") "knowledgefront")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/ccgcloud/bretsmac") "ccgcloud")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/ccgcloud/bretsmac2") "ccgcloud2")
(bright-set-dict "htdocs" (concat apachedocroot "ccgcloud/bretsmac2") "ccgcloud2")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/vinca/bretsmac") "vinca")
(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/justculture/bretsmac") "justculture")
(bright-set-dict "htdocs" (concat apachedocroot "justculture/justculture_com_replica") "justculture2")

(bright-set-dict "root" (concat (getenv "HOME") "/.rover/workspaces/justculture/justculture_com_replica") "justculture2")
(bright-set-dict "htdocs" (concat apachedocroot "justculture/justculture_com_replica") "justculture2")
(bright-set-dict "htdocs" (concat apachedocroot "vinca/bretsmac") "vinca")

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
  (setq rover-base-path (bright-fetch-dict "root" server))
  (setq htdocs-base-path (bright-fetch-dict "htdocs" server))
  (setq server-base-path (bright-fetch-dict "root" rails-env))
  (rails-start server rails-env)
  )

(defun rails-start (server rails-env)
  "Begin a rails interactive environment"
  (if (bright-fetch-dict "root" server)
      (setq rover-base-path (bright-fetch-dict "root" server))
    (setq rover-base-path (concat "~/.rover/workspaces/" (getenv "ROVERENV") "/" server)))
  (setq default-directory rover-base-path)
  (setq htdocs-base-path (bright-fetch-dict "htdocs" server))
  (shell-with-command (concat rails-env "-sql") (concat "cd " server-base-path "; rails db") "S")
  (shell-with-command (concat rails-env "-server") (concat "cd " server-base-path "; rails s") "s")
  (shell-with-command (concat rails-env "-console") (concat "cd " server-base-path "; rails c") "c")
  (shell-with-command (concat rails-env "-railsshell") (concat "cd " server-base-path) "r")
  (shell-with-command (concat server "-shell") (concat "cd " rover-base-path) "c")
  (shell-with-command (concat server "-rover") (concat "cd ~/dev/gitlab/aura-rover-config; r " rover-env) "c")
  (shell-with-command (concat server "-htdocs") (concat  "cd " htdocs-base-path) "H")
  )

(defun rails-pop-tobuffer (buff)
  (interactive)
  ;;
  ;; (setq foo (current-buffer))
  ;; (delete-other-windows)
  (pop-to-buffer buff)
  ;; (switch-to-buffer-other-window foo)
  ;; (other-window 1)
  (end-of-buffer)
  (comint-previous-input 1)
  )

(defun go-to-server ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rails-env "-server"))
  )

(defun go-to-htdocs ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rover-env "-htdocs"))
  )


(defun go-to-shell ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rover-env "-shell"))
  )

(defun go-to-console ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rails-env "-console")  )
  ;; (if (get-buffer "*rails*")
  ;;     (rails-pop-tobuffer (get-buffer "*rails*"))
  ;;   (rails-pop-tobuffer (concat rails-env "-console")))
  )

(defun go-to-sql ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rails-env "-sql"))
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
  (rails-pop-tobuffer (concat rover-env "-rover"))
  (end-of-buffer)
  (comint-previous-input 1)
  )

(defun go-to-railsshell ()
  (interactive)
  ""
  (rails-pop-tobuffer (concat rails-env "-railsshell"))
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

;; doesn't work

;; (defun rails-find ()       ; Interactive version.                                                                              
;;   "rails-find"
;;   (interactive)
;;   (setq text (read-from-minibuffer "Search text? "))
;;   (find-name-dired (concat rover-base-path "/app") (concat "*" text "*"))
;;   )
;; (global-set-key "f" (quote rails-find))

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


(global-set-key "C" (quote go-to-shell))

(defun edit-this-file ()
  (interactive)
  ""
  (find-file-other-window "~/bash_profiles/bdw/emacs/rails.el" t)
  )

;; (global-set-key "l" (quote edit-this-file))

(fset 'last-shell-command
      [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l ?* return escape ?> return ?! ?! return])

(global-set-key (quote [3 f4]) (quote last-shell-command))

(setq ruby-deep-indent-paren nil)


;; def open(*args)
;;   url = server_url
;;   if args[0] && arg1 = args.shift[:arg1]
;;     if arg1.match /^bright/
;;       url += "/wp-admin/admin.php?page=#{arg1}"
;;     end
;;   end

;;   system('open -a /Applications/Google\ Chrome.app ' + url)
;; end


;; (shell-command "open -a /Applications/Google\ Chrome.app localhost:3000")

;; (shell-command "open -a /Applications/Google\ Chrome.app")

					; (setq browse-url-browser-function 'browse-url-chromium)

					; (setq browse-url-browser-function nil)

					; (browse-url "localhost:3000")
