#######
#
# E-scripts about irbsh
#
#######

;;
;; (eeb-eval)
(defun eech-M-x (&rest args)
  (eech (concat "\ex" (mapconcat 'identity args "\n") "\n")))
(defun eech-comint-send-input (input)
  (eech (concat input "\excomint-send-input\r"))
  )
(defun eech-kill-emacs ()
  (eech-M-x "kill-emacs"))
;;


# test-invoke
 (eevnow-at ".test-invoke")
 (eech-comint-send-input " echo a")
 (eech-comint-send-input " el (setq x 1)")
:x
 (eech-comint-send-input " el (setq x \"100\")")
:x
 (eech-kill-emacs)

# test-eval-list
 (eevnow-at ".test-invoke")
 (eech "\C-c\ee")
 (eech-kill-emacs)


#
# .test-invoke
<<'%%%' > $EERUBY
el_load 'irbsh'
irbsh "irb --inf-ruby-mode"
%%%
el4r -r ~/src/el4r -I ~/emacs/lisp/ $EERUBY
#
