;; bretquote.el

;; A simple emulation package for the textedit/atoms of the world

;; List of functions [and only function]:

;; When the user hits one of the following characters:

;; '
;; "
;; [
;; (
;; {
;; <

;; a closeing character is inserted, and the cursor moved one backspaces.

;; How to Load

;; 1. Put in your loadpath ... maybe with something like this : (setq load-path (cons MY-PATH load-path))
;; 2. (load-library "bretquote")

(defun key-pair (q)
  "emulation of where you get two quotes for the price of one"
  (stringp q)
  (insert q q)
  (backward-char)
  )

(defun double-quote-pair ()
  ""
  (interactive)
  (key-pair "\""))

(defun single-quote-pair ()
  ""
  (interactive)
  (key-pair "'"))

(defun back-quote-pair ()
  ""
  (interactive)
  (key-pair "`"))

(global-set-key "\"" (quote double-quote-pair))
(global-set-key "'" (quote single-quote-pair))
(global-set-key "`" (quote back-quote-pair))



(setq closer-hash (make-hash-table :test 'equal))

(puthash "(" ")" closer-hash)
(puthash "[" "]" closer-hash)
(puthash "{" "}" closer-hash)
(puthash "<" ">" closer-hash)

(defun insert-and-close(char)
  "find the closing match for a character and insert it"
  (stringp char)
  (insert char)
  (setq insert-result (gethash char closer-hash))
  (if insert-result
      (progn
        (insert insert-result)
        (backward-char))
    )
  )

(insert-and-close "(")

(defun insert-and-close-paren()
  ""
  (interactive)
  (insert-and-close "(")
  ;; (insert "\n")
  ;; (delete-char)
  ;; (indent-for-tab-command)
  ;; (previous-line 1)
  ;; (end-of-line)
  )







(global-set-key "(" (quote insert-and-close-paren))

(defun insert-and-close-bracket()
  ""
  (interactive)
  (insert-and-close "["))

(global-set-key "[" (quote insert-and-close-bracket))


(defun insert-and-close-curlybrace()
  ""
  (interactive)
  (insert-and-close "{"))

(global-set-key "{" (quote insert-and-close-curlybrace))


(defun insert-and-close-lessthan()
  ""
  (interactive)
  (insert-and-close "<"))

(global-set-key "<" (quote insert-and-close-lessthan))
