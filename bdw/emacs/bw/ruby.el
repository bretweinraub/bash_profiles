(setq ruby-indent-level 2)

(load-library "bw/rails")
(load "bw/enhanced-ruby.el")


;;  (require 'highlight-indentation)

(setq highlight-indent-guides-method 'character)

(add-hook 'enh-ruby-mode-hook
	  'highlight-indent-guides-mode)

;; https://github.com/dgutov/robe

(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

(add-hook 'robe-mode-hook 'ac-robe-setup)



