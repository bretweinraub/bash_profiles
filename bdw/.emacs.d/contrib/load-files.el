
(defun load-files-in-dir (dir)
  ;; searches for .el files in a directory and loads any files in there.
  ;; for example:

  (let* (
	 (list (directory-files dir t "\.el$" t)) ; https://www.gnu.org/software/emacs/manual/html_node/elisp/Contents-of-Directories.html
	 (filename (car list))
	 )
    (while list
      (if (file-regular-p filename)
	  (
	   progn 
	    (message "load-files-in-dir: Found %s." filename)
	    (load filename)
	    )
	(message "load-files-in-dir: skipping non-regular file %s." filename)
	)
      (setq filename (car list))    
      (setq list (cdr list)))
    )
  )

(load-files-in-dir "~/.emacs.d/scripts-enabled")

;; this might do the same:


;; Conclude init by setting up specifics for the current user
;; (when (file-exists-p user-settings-dir)
;;   (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))
