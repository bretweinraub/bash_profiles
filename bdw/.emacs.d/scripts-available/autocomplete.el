
;; Auto-complete
;; https://github.com/auto-complete/auto-complete

(if (fboundp 'auto-complete)
    (progn
      (require 'auto-complete-config)
      (add-to-list 'ac-dictionary-directories
		   "~/.emacs.d/.cask/25.3/elpa/auto-complete-20170124.1845/dict/")
      (ac-config-default)
;      (setq ac-ignore-case nil)
      (when (fboundp 'enh-ruby-mode)
	(add-to-list 'ac-modes 'enh-ruby-mode))
	
      (add-to-list 'ac-modes 'web-mode)
      (add-to-list 'ac-modes 'list-mode)
      (add-to-list 'ac-modes 'sql-mode)

      (setq ac-use-menu-map t) ;; https://github.com/auto-complete/auto-complete/blob/master/doc/manual.md
      (setq ac-use-fuzzy t)
      (setq ac-dwim t)
      )
  )


(when (fboundp 'inf-ruby)
  (progn
    (eval-after-load 'auto-complete
      '(add-to-list 'ac-modes 'inf-ruby-mode))
    (add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

					; If you want to trigger auto-complete using TAB in inf-ruby buffers, you should bind it directly:

    (eval-after-load 'inf-ruby '
      '(define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))
    ))



