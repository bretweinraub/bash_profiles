
(defun compile-last-command ()
  "This is for shell mode.   It will convert the last command run into something you can paste into the compile buffer"
  (interactive)
  (insert "echo '(' cd $(pwd) \\; !! ')'")
  (comint-send-input)
  ;; (previous-line)
  ;; (set-mark)
  ;; (end-of-line)
  ;; (kill-ring-save (point) (mark))
  )


(defun bdw-after-compile ()
  (pop-to-buffer "*compilation*")
  (goto-char (point-max))
;;  (text-scale-set -1)
  )


(add-function :after (symbol-function 'compile) #'bdw-after-compile)

