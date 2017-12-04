

(when
    (package-installed-p 'iy-go-to-char)
  (require 'iy-go-to-char)
;;   (add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos)
  (global-set-key (kbd "C-c f") 'iy-go-to-char)
  (global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
  (global-set-key (kbd "C-c ;") 'iy-go-to-or-up-to-continue)
  (global-set-key (kbd "C-c ,") 'iy-go-to-or-up-to-continue-backward)


					; Or if you prefer up-to (vim "t") versions:
  ;; (global-set-key (kbd "C-c f") 'iy-go-up-to-char)
  ;; (global-set-key (kbd "C-c F") 'iy-go-up-to-char-backward)
  )
  
