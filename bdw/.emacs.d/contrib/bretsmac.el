
;; (rails-start)
;; (rails-start "finaura")

(defun go-to-finaura-console ()
  (interactive)
  ""
  (pop-to-buffer "finaura-console")
  (end-of-buffer)
  (comint-previous-input 1)
)

(global-set-key "f" (quote go-to-finaura-console))

