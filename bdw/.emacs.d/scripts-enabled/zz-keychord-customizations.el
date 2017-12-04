

(load-file "~/.emacs.d/contrib/keychord.el")
(require 'key-chord)

;;;; BDW Customizations

;; http://emacsrocks.com/e07.html
(key-chord-mode 1)
(key-chord-define-global "qz"     'iy-go-to-char)
(key-chord-define-global "p,"     'iy-go-to-char-backward)


(setq key-chord-one-key-delay 0.0000000002) ; default 0.2
