

;; expect experiments

(+ 2 2)


(setq a "1")
(setq b "1")
  (if (eq a b)
      (message "yes")
    (message "no")
    )

(defun expect(a b)
  (if (equal a b)
      (message "yes")
    (message "no"))
  )



(expect "1" "1")

(expect
(hash-table-p
 (make-hash-table))
(make-hash-table :test 'eq)
