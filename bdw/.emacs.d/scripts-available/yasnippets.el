(when (package-installed-p 'yasnippet)
  
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"                 ;; personal snippets
	  "/Users/bweinraub/bash_profiles/bdw/emacs/contrib/yasnippet-snippets/snippets"
	  ;; , ;; git clone git@github.com:AndreaCrotti/yasnippet-snippets.git
	  ;; "/path/to/some/collection/"           ;; foo-mode and bar-mode snippet collection
	  ;; "/path/to/yasnippet/yasmate/snippets" ;; the yasmate collection
	  ;; "/path/to/yasnippet/snippets"         ;; the default collection
	  ))

  (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
  )

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "<backtab>") nil)




