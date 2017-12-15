

(defun Refactor-hash ()
  "convert old style ruby hash to new style ruby hash"
  (interactive)
  (search-forward "=>")
  (search-backward ":")
  (delete-char 1)
  (search-forward-regexp " ")
  (backward-char 1)
  (insert ":")
  (delete-char 3)
  )


(defun my-ehr-mode-config ()
  "For use in `html-mode-hook'."
  (local-set-key (kbd "C-c C-r h") (symbol-function 'refactor-hash))  
  )

;; add to hook
(add-hook 'ehr-mode-hook 'my-ehr-mode-config)



;; foo: :bar
