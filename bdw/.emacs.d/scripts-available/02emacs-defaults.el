;; turn on font-lock mode
(global-font-lock-mode t)


;; enable visual feedback on selections
(setq-default transient-mark-mode t)

(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; emacs 23 ; use old vertical split
(setq split-width-threshold nil)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq mac-option-modifier  'hyper)
(setq mac-command-modifier 'meta)

(global-set-key (kbd "C-c k") 'compile)

;; i like my registers to save between sessions
(desktop-save-mode)
