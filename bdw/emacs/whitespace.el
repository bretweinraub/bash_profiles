(defun kill-whitespace ()
          "Kill the whitespace between two non-whitespace characters"
          (interactive "*")
          (save-excursion
            (save-restriction
              (save-match-data
                (progn
                  (re-search-backward "[^ \t\r\n]" nil t)
                  (re-search-forward "[ \t\r\n]+" nil t)
                  (replace-match "" nil nil))))))


(global-set-key [C-M-f12] (quote kill-whitespace))
(global-set-key [C-H-f12] (quote go-to-scratch))
