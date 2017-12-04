(setq ruby-indent-level 2)

;;  (require 'highlight-indentation)

;; (setq highlight-indent-guides-method 'character)

;; 'fill is the default
;; (setq highlight-indent-guides-method 'fill)

;; https://github.com/DarthFennec/highlight-indent-guides
(add-hook 'enh-ruby-mode-hook
	  'highlight-indent-guides-mode)

;; https://github.com/dgutov/robe

(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

(add-hook 'robe-mode-hook 'ac-robe-setup)



