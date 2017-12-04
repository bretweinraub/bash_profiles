
(require 'rspec-mode)

;; set it up so that after calling rspec verify, we move to the
;; rspec-compilation buffer and go to the end!   #ER [emacs rocks]


(defun bdw-after-rspec-verify ()
  (pop-to-buffer "*rspec-compilation*")
  (goto-char (point-max))
;;  (text-scale-set -1)
  )


(add-function :after (symbol-function 'rspec-verify) #'bdw-after-rspec-verify)
