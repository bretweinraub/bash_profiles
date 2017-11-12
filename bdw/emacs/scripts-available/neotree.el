(when (fboundp 'neotree)
  (defun chomp(str)
    ;; chomp the last character
    (substring str 0 -1))

  (setq current-working-directory
	(chomp (shell-command-to-string "pwd")
	       )
	)

  (neotree-dir  current-working-directory)

  ;; https://github.com/jaypei/emacs-neotree/issues/209
  (setq split-window-preferred-function 'neotree-split-window-sensibly)
  )

