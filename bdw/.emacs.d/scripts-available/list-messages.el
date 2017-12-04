

(defun pop-to-Messages-split-window()
  (interactive)
  (let ((cb (current-buffer)))
    (split-window-right)
    (pop-to-buffer "*Messages*")
    (pop-to-buffer cb)))
  
(global-set-key (kbd "C-c m") 'pop-to-Messages-split-window)
