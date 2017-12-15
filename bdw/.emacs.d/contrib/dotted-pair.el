
(defun dotted-pair-notation (l)
  ;; the idea is to have a function that can take a CONS and spit out the dotted pair notation
  ;; like in the Emacs *info elisp doc sec 2.3.6.2
  (let
      (
       (line '())
       )
    (if (not))
  (when (consp l)
      (message "%s is a cons" l)
    (let* (
	   (_car (car l))
	   (_cdr (cdr l))
	   )
      (dotted-pair-notation _car)
      (dotted-pair-notation _cdr)
    )))

(dotted-pair-notation '(1 2 3 4))

(cdr '(1))

(consp (cdr '(1 2 3 4)))

[1 2 3 4 5]

[ 1 2 3 4 5 6 7 8 9 10 ]
