

(defun ctaa-remaining (amount remaining)
  (interactive)
  (message (format "Credit $%0.2f pre-paid hours. $%0.2f remain" amount (- remaining amount)))
  )

(ctaa-remaining 287.67 409.19)
