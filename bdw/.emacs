;; Rd Hat Linux default .emacs initialization file  ; -*- mode: emacs-lisp -*-

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.

(setq js-indent-level 2)

(set-variable (quote js-indent-level) 2 nil)
(set-variable (quote indent-tabs-mode) nil nil)

(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; turn on font-lock mode
(global-font-lock-mode t)
;; enable visual feedback on selections
(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; emacs 23 ; use old vertical split
(setq split-width-threshold nil)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions)
  ;; get rid of these real-estate hogs
  ;; (tool-bar-mode)
  ;; (scroll-bar-mode nil)
  (menu-bar-mode nil)
  (tooltip-mode nil)
  )


(global-set-key (quote [f9]) (quote call-last-kbd-macro))
(global-set-key (quote [C-M-f9]) (quote call-last-kbd-macro))
(global-set-key (quote [f10]) (quote hippie-expand))
(global-set-key (quote [C-M-f10]) (quote hippie-expand))


;; neotree
;;
(add-to-list 'load-path "/Users/bretweinraub/dev/github/neotree")

(require 'neotree)
(setq neo-smart-open t)

(define-key neotree-mode-map (kbd "i") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "I") #'neotree-enter-vertical-split)

(global-set-key (quote [f8]) 'neotree-toggle)
(global-set-key (quote [C-M-f8]) 'neotree-toggle)

;;
;; end neotree
;;


(global-set-key [C-M-f4] (quote search-all-buffers))
(global-set-key [f4] (quote search-all-buffers))
(global-set-key (quote [f6]) (quote hippie-expand))
(global-set-key (quote [C-M-f6]) (quote hippie-expand))
(global-set-key (quote [f3]) (quote font-lock-mode))
(global-set-key (quote [C-M-f3]) (quote font-lock-mode))

(fset 'scsh-eval
   [?\C-@ ?\C-\M-b ?\M-w ?\C-x ?o ?\C-y return ?\C-x ?o ?\C-\M-f])

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(global-set-key ":" (quote goto-line))

(defun doinstall ()       ; Interactive version.
  "run make install"
  (interactive)
  (eval-expression (quote (shell-command "(cd lib/perl; make install)" nil nil)) nil))

(defun srcinstall ()       ; Interactive version.
  "run make install"
  (interactive)
  (eval-expression (quote (shell-command "(cd src/util; make install)" nil nil)) nil))

(progn
  (defvar compile-command "(cd ~/dev/bitbucket/rover && ROVERENV=dev ~/dev/bitbucket/rover/bin/roverun)")
  (defun deal-test ()
	"deal test"
	(interactive)
	(compile compile-command)
	(other-window 1)
	(end-of-buffer)
	(other-window 1)
	)

  (defun debug-in-shell ()
	"debug the compile command"
	(interactive)
	(switch-to-buffer "iportal-shell")
	(insert compile-command)
	(condition-case nil
		(comint-send-input)
	  ((debug error) nil))
	)

  (global-set-key (quote [f1]) (quote deal-test))
  (global-set-key (quote [C-M-f11]) (quote deal-test))

  (global-set-key (quote [f9]) (quote debug-in-shell))
  (global-set-key (quote [C-M-f9]) (quote debug-in-shell))
)

;; (defun ant-compile ()       ; Interactive version.
;;   "the ant local compile"
;;   (interactive)
;;   (compile "(cd ~/main/TTS ; make den090 local)")
;;   (other-window 1)
;;   (end-of-buffer)
;;   (other-window 1)
;;   )


(defun bvtgrid-compile ()       ; Interactive version.
  "the ant local compile"
  (interactive)
  (compile "(m80 --execute make ; env M80_BDF=bweinrau.usbohp380-7.tier1Aprod m80 --oldschool -t deploy -m BVTGRID )")
  (other-window 1)
  (end-of-buffer)
  (other-window 1)
  )

;; (global-set-key (quote [f1]) (quote ant-compile))


(defun source-compile ()       ; Interactive version.
  "the ant local compile"
  (interactive)
  (compile "(cd /home/bret/dev/m81/lib/perl/Metadata && make && stupidTestChassis)")
  (other-window 1)
  (end-of-buffer)
  (other-window 1)
  )


(defun local-compile ()       ; Interactive version.
  "the ant local compile"
  (interactive)
  (compile "make")
  (delete-window)
  (end-of-buffer)
  )



(defun pg-compile ()       ; Interactive version.
  "the ant local compile"
  (interactive)
  (compile "(cd /usr/local/home/bweinrau/dev/sandbox/bweinrau/perf/r9023_dev/metadata && m80 --execute make ; m80 --execute sogv.pl -study studies/HardwareSurvey.pl -run test)")
  (delete-window)
  (end-of-buffer)
  )



(defun xreplace (name)
  "special replace"
  (interactive "r")
  (query-replace (concat "$" name) (concat "$arg->{" name "}") nil nil nil))

(global-set-key (quote [f10]) (quote next-error))
(global-set-key (quote [C-M-f10]) (quote next-error))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.jsp" 'sgml-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.dryml" 'sgml-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.cfm" 'java-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.cs" 'java-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.jpf" 'java-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.ts" 'javascript-mode))
       auto-mode-alist))


(setq auto-mode-alist
      (append
       (list
	(cons "\\.jcx" 'java-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.tld" 'sgml-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.m80" 'perl-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.xml" 'html-mode)
	(cons "\\.xsd" 'html-mode)
	(cons "\\.resx" 'html-mode)
	(cons "\\.rhtml" 'html-mode)
	)
       auto-mode-alist))

(setq auto-mode-alist
      (append
       (list
	(cons "\\.rake" 'ruby-mode))
       auto-mode-alist))


(fset 'cfoutput-to-jsp-expression
   [?\C-s ?< ?c ?f ?o ?u ?t ?p ?u ?t ?> ?# ?\C-f ?\C-b ?\C-@ ?\M-b ?\C-b ?\C-w ?< ?% ?- ?  backspace backspace ?= ?  ?\C-s ?# ?\C-b ?\C-@ ?\M-f ?\C-f ?\C-w ?  ?% ?>])

(load-file "~/bash_profiles/bdw/emacs/sgml-mode.el")

(defvar my-compile-command nil "*")

(defun compilex ()
  "test"
  (interactive)
  (save-buffer)
  (compile my-compile-command t)
  (other-window 1)
  (end-of-buffer))


(defun create-bean-property ()
  "Hopefully will create a Java setter getter method based on the minibuffer"
  (interactive)
  (setq data-type (read-from-minibuffer "The bean property data type? "))
  (setq field-name (read-from-minibuffer "The name of the bean property? "))

  (if (or (equal data-type "int") (equal data-type "short"))
      (insert data-type " "  field-name " = -1;")
      (insert data-type " "  field-name " = null;")
      )
  (c-indent-command)
  (insert "\npublic void set"  (upcase-initials field-name) " (" data-type " in) {this." field-name " = in;}")
  (c-indent-command)
  (insert "\npublic " data-type " get"  (upcase-initials field-name) " () {return " field-name ";}")
  (c-indent-command)
  (insert "\n")
)

(defun only-these-parameters ()
  "insert the only these params"
  (interactive)
  (insert "      config,dummy = CkuruTools.only_these_parameters(h,")
  (ruby-indent-line)
  (insert "\n        [:config,{:instance_that_inherits_from => String,:required => true}]")
  (ruby-indent-line)
  (insert "\n        )")
  (ruby-indent-line)
  )


(defun create-package-header ()
  "Hopefully will create an oracle package header"
  (interactive)
  (setq package-name (read-from-minibuffer "The package name? "))
  (find-file (concat "P_" package-name ".pkg"))
  (insert "\n-- -*-sql-*- --")
  (insert "\n-----------------------------------------------------------------")
  (insert (concat "\n-- Package:		P_" package-name))
  (insert "\n--")
  (insert "\n-- Date:		")
  (insert "\n--")
  (insert "\n-- Description:		")
  (insert "\n--")
  (insert "\n-----------------------------------------------------------------")
  (insert "\n--")
  (insert (concat "\nPROMPT Creating PACKAGE P_" package-name "."))
  (insert (concat "\nCREATE OR REPLACE PACKAGE P_" package-name " AUTHID CURRENT_USER AS"))
  (insert (concat "\n  package_name CONSTANT VARCHAR(32) := 'P_" package-name "';"))
  (insert "\n")
  (insert "\n")
  (insert "\n")
  (insert "\nEND;")
  (save-buffer)
  (find-file ( concat "P_" package-name ".pkb"))
  (insert "\n-- -*-sql-*- --")
  (insert "\n-----------------------------------------------------------------")
  (insert (concat "\n-- Package:		P_" package-name ""))
  (insert "\n--")
  (insert "\n-- Date:		")
  (insert "\n--")
  (insert "\n-- Description:		")
  (insert "\n--")
  (insert "\n-----------------------------------------------------------------")
  (insert "\n--")
  (insert (concat "\nPROMPT Creating PACKAGE BODY P_" package-name "."))
  (insert "\n")
  (insert (concat "\nCREATE OR REPLACE PACKAGE BODY P_" package-name " AS"))
  (insert "\n")
  (insert "\nEND;")
  (save-buffer)
)


(defun create-java-array-loop ()
  "Create a new java array loop"
  (interactive)
  (setq array-name (read-from-minibuffer "The name of the array? "))
  (c-indent-command)
  (insert "\nfor (int i = 0 ; i < " array-name ".length ; i++) {")
  (c-indent-command)
  (insert "\n");
  (c-indent-command)
  (insert "\n}")
  (c-indent-command)
  (previous-line 1)
  (c-indent-command)
)

(defun ruby-method ()
  "Create a new ruby method"
  (interactive)
  (setq method-name (read-from-minibuffer "What is the new method name? "))
  (setq args (read-from-minibuffer "What is are the args? "))
  (ruby-indent-command)
  (insert "################################################################################\n")
  (ruby-indent-command)
  (insert "def " method-name "(" args ")\n")
  (ruby-indent-command)
  (insert "\n")
  (ruby-indent-command)
  (insert "end")
  (ruby-indent-command)
  (previous-line 1)
)

(defun ruby-abstract-method ()
  "Create a new ruby abstract-method"
  (interactive)
  (setq method-name (read-from-minibuffer "What is the new method name?"))
  (ruby-indent-command)
  (insert "def " method-name "(*args)\n")
  (ruby-indent-command)
  (insert "raise NotImplementedError.new(\"#{self.class} must define #{current_method}\")\n")
  (ruby-indent-command)
  (insert "end\n")
  (ruby-indent-command)
  (previous-line 1)
)



(defun create-java-class ()
  "Create a new java class"
  (interactive)
  (setq class-name (read-from-minibuffer "What is the new class name? "))
  (find-file ( concat class-name ".java"))
  (setq package-name (read-from-minibuffer "What is the package name? "))
  (if (> (length package-name) 0)
      (insert "package " package-name ";\n")
    )
  (insert "public class " class-name " {\n\n}\n")
  (previous-line 2)
)

(defun java-print ()
  "Insert a system out println"
  (interactive)
  (insert "System.out.println (\"\");\n");
  (previous-line 1)
  (c-indent-command)
  (end-of-line)
  (backward-char 3)
)

(defun java-comment ()
  "Insert a system out println"
  (interactive)
  (push-mark)
  (insert "/*\n*\n*/\n");
)


(defun bug-list ()
  "maintain a bug list"
  (interactive)
  (add-change-log-entry-other-window nil "~/r208/TTS/bugList.log")
)

(defun fix-list ()
  "maintain a bug list"
  (interactive)
  (add-change-log-entry-other-window nil "~/r208/TTS/fixList.log")
)

(defun create-tag-property ()
  "Hopefully will create a Java setter getter method based on the minibuffer"
  (interactive)
  (setq data-type (read-from-minibuffer "The tag property data type? "))
  (setq field-name (read-from-minibuffer "The name of the tag property? "))

  (if (equal data-type "int")
      (insert data-type " "  field-name " = -1;")
      (insert data-type " "  field-name " = null;")
      )
  (c-indent-command)
  (insert "\npublic void set"  (upcase-initials field-name) " ( String s) {")
  (if (equal data-type "int")
      (insert field-name " = (new Integer (s)).intValue();}")
      (insert field-name " = s;}")
      )
  (c-indent-command)
  (insert "\n")
)

(defun perl-here-document ()
  "Hopefully will create a Java setter getter method based on the minibuffer"
  (interactive)
  (insert "    print OUT <<\"EOF\";\n")
  (insert "\nEOF\n")
  (previous-line 2)
)

(defun insert-jsp-condition ()
  ""
  (interactive)
  (insert "<% if () { %>")
  (c-indent-command)
  (insert "\n<% } else { %>")
  (c-indent-command)
  (insert "\n<% } %>")
  (c-indent-command)
  (insert "\n")
  (previous-line 3)
  (forward-word 2)
  (forward-char 2)
)


(defun other-window-backward (&optional n)
  "Select nth previous window"
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))


(global-set-key "" (quote other-window-backward))

;; CFM
(fset 'color
   [?\C-s ?C ?o ?l ?o ?r ?# ?\C-f ?\C-b backspace ?% ?> ?\M-b backspace ?< ?% ?= ?  ?\M-f ?  backspace ?\C-b ? ])

(fset 'jspify
   [return ?\C-p tab ?< ?% ?\C-@ ?\C-n ?\C-w ?\C-a ?\C-e escape ?8 ?0 ?  ?\C-a escape ?8 ?0 ?\C-f ?\C-@ ?\C-e ?\C-w ?% ?> ?\C-n ?\C-a])

(fset 'jspify-atom
   "\C-r \C-f<%= \C-s\C-s\C-f\C-b%> ")

(defun list-and-goto-buffers ()
  "executes list-buffers but goes there"
  (interactive)
  (list-buffers)
  (other-window 1)
)

(global-set-key "" (quote list-and-goto-buffers))



(setq load-path (cons "~" (cons "~/bash_profiles/bdw/emacs" load-path)))

;; Then add the library like this:

(load-library "p4")


(load-library "psvn")

(defun scroll-back-n-lines (&optional n)
  "go back n lines"
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))

(defun scroll-ahead-n-lines (&optional n)
  "go back n lines"
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(global-set-key "\C-q" (quote scroll-back-n-lines))
(global-set-key "\C-z" (quote scroll-ahead-n-lines))
(global-set-key "" (quote quoted-insert))


;; (defadvice switch-to-buffer (before
;; 			     existing-buffer
;; 			     activate
;; 			     compile)
;;   "When interactive, switch to existing buffers only unless a prefix
;; arg is set."
;;   (interactive
;;    (list (read-buffer "Switch to buffer: "
;; 		      (other-buffer)
;; 		      (null current-prefix-arg)))))


(defadvice dired-find-file-other-window (before
					 existing-buffer
					 activate
					 compile)
  "dont go to new window."
   (other-buffer))

;; (defadvice compile (before
;; 		    compile-after-advice
;; 		    activate
;; 		    compile)
;;   "dont go to new window."
;;    (other-buffer))


;; (defun my-compile ()
;;   "test"
;;   (interactive)
;;   (compile)
;;   (switch-to-buffer-other-window)
;;   (end-of-buffer))

(defmacro test (x)
  (list 'defadvice x (list 'before
			   'existing-buffer
			   'activate
			   'compile)
	"When interactive, switch to existing buffers only unless a prefix
arg is set."
	(list 'interactive
	      (list 'list (list 'read-buffer "Switch to buffer :"
				(list 'other-buffer)
				(list 'null 'current-prefix-arg))))))


(defadvice p4-submit (before
		      existing-buffer
		      activate
		      compile)
  "revert unchanged files"
  (shell-command "(cd dev; p4 revert -a)" nil nil))

(global-set-key "" (quote suspend-emacs))

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(when (fboundp 'windmove-default-keybindings)      (windmove-default-keybindings))

;; (add-to-list 'load-path "~/ee/")
;; (require 'ee-autoloads)


(fset 'xml-format
   [?\C-s ?" ?  ?\C-b ?\C-d return tab])



(put 'set-goal-column 'disabled nil)

(defun commenter ()
  "Comment"
  (interactive)
  (end-of-line)
  (insert "                                                                                                    ")
  (set-variable (quote goal-column) 80)
  (previous-line 1)
  (next-line 1)
  (insert "#")
  (delete-horizontal-space)
  (insert " ")
  (set-variable (quote goal-column) 0)
)

(setq description "2eee")

(message "hello")

(cond
 ((> (length description) 2)
  (message "greater")))

(progn
  (message "progn")
  (message "progn2"))

(defun insert-php-function-stub ()
  "Insert a new php function with comment block"
  (interactive)
  (setq function-name (read-from-minibuffer "Function Name?"))
  (insert "/**")
  (c-indent-command)
  (insert "\n *")
  (c-indent-command)
  (insert "\n */")
  (c-indent-command)
  (insert "\npublic function " function-name "() {")
  (c-indent-command)
  (insert "\n\n}")
  (c-indent-command)
  (insert "\n")
  (previous-line 2)
  )


(defun new-perl-method ()
  "Insert a new perl method"
  (interactive)
  (setq method-name (read-from-minibuffer "The method name? "))
  (setq description (read-from-minibuffer "Description of the method? "))
  (insert "\n")
  (insert "################################################################################\n")
  (insert "\n")

  (insert "sub " method-name " {\n")
  (insert "   <:= $po->contract('" method-name "' => {description => '" description "',\n")
  (insert "				      getopts => [\n")
  (insert "				                   #{name => 'data' ,\n")
  (insert "						   # required => 't',\n")
  (insert "						   # description => 'data to process',},\n")
  (insert "						   ]}); :>\n")
  (insert "    do {\n")
  (insert "    };\n")
  (insert "}\n")
  (insert "\n")
)

(defun go-to-scratch ()
  "go to scratch buffer"
  (interactive)
  (switch-to-buffer-other-window "*scratch*")
  )



(global-set-key (quote [f4]) (quote commenter))
(global-set-key (quote [f12]) (quote go-to-scratch))
(global-set-key (quote [C-M-f12]) (quote go-to-scratch))

(load "desktop")
(desktop-load-default)
(desktop-read)

;
; Code to load a generated template at a certain line number
;

(defun strip-file-suffix (filename)
  "strips the suffix off of a file"
  (interactive)
  (let (
	(return-value (substring filename 0 (- (length filename) 4)))
	)
    ;; let body
    (message "file generated from %s is %s" filename return-value)
    ;; return value of let becomes return value of strip-file-suffix
    return-value))


(defun open-generated-file ()
  "opens a generated file by stripping the suffix of the current buffer and then prompting for the line in the file to seek to"
  (interactive)
  (find-file (strip-file-suffix (buffer-file-name)))
  (goto-line (string-to-number (read-from-minibuffer "Line Number? "))))


(global-set-key (quote [f11]) (quote open-generated-file))

(defun ruby-function-header ()
  ""
  (interactive)
  (set-mark)
  (ruby-lines
   "################################################################################"
   "#"
   "# function:\t"
   "#"
   "################################################################################"
   "\n")
  )

(global-set-key (quote [f7]) (quote debug-print))

(defun rununder ()       ; Interactive version.
  "run a command under an action id"
  (interactive)
  (setq action-id (read-from-minibuffer "Action ID? "))
  (setq command (read-from-minibuffer "command? "))

  (compile (concat "m80 --execute make && COMMAND=\"" command "\" m80 --execute debugChassis.sh -a " action-id " -c eval"))
  )

(defun brep ()
  "bret grep"
  (interactive)
  (setq grep-string (read-from-minibuffer "Grep String? "))
  (grep (concat "grep -i -n -e " grep-string " *.*[a-zA-Z0-9]")))

;; (global-set-key (quote [f5]) (quote source-compile))
(global-set-key (quote [f5]) (quote brep))
(global-set-key (quote [C-M-f5]) (quote brep))


;; this macro will save the current buffer; go to the shell buffer (assuming it  is running SQL); and run the last command.

(fset 'call-last-sql-statement
   [?\C-x ?\C-s ?\C-x ?4 ?b ?* ?s ?h tab return escape ?> return ?\M-p return ?\C-x ?o])

(global-set-key (quote [C-f6]) (quote call-last-sql-statement))

(defun go-to-shell ()
  ""
  (interactive)
  (switch-to-buffer-other-window "iportal-server")
  (end-of-buffer)
  (other-window 1))

(global-set-key (quote [C-f5]) (quote go-to-shell))

(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))

(fset 'ruby-first-error
   [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l tab return escape ?> ?\C-r ?. ?. ?. ?\C-n ?\C-a ?\C-@ ?\C-s ?: ?\C-f ?\C-b ?\C-b ?\M-w ?\C-x ?4 ?f ?\C-a ?\C-y ?\C-k return ?\C-x ?o ?\C-f ?\C-  ?\M-f ?\M-w ?\C-x ?o ?\M-x ?g ?o ?t ?o ?- ?l ?i ?n ?e return ?\C-y return ?\C-x ?o ?\C-p ?\C-p ?\C-n ?\C-n ?\C-x ?o])

(fset 'ruby-next-error
   [?\C-x ?4 ?b ?* ?s ?h ?e ?l ?l ?  return ?\C-n ?\C-a ?\C-@ ?\C-s ?: ?\C-b ?\M-w ?\C-x ?4 ?f ?\C-a ?\C-y ?\C-k return ?\C-x ?o ?\C-f ?\C-  ?\M-f ?\M-w ?\C-x ?o ?\M-x ?g ?o ?t ?o ?- ?l ?i ?n ?e return ?\C-y return])


(global-set-key (quote [C-f9]) (quote ruby-first-error))
(global-set-key (quote [C-f10]) (quote ruby-next-error))

(fset 'restart-rails
   [?\C-x ?4 ?b ?i ?p ?o ?r ?t ?a ?l ?- ?s ?e ?r ?v ?e ?r return escape ?> ?\C-c ?\C-c])

(global-set-key (quote [C-f6]) (quote restart-rails))

(load-library "rails")
(load-library "search-all-buffers")
(load-library "bretquote")

(defadvice list-and-goto-buffers (after
				  existing-buffer
				  activate
				  compile)
  "Resort the buffer every time I move to it."
   (Buffer-menu-sort 5))

;; for emacs 23 ; this will revert to horizontal splits
(setq split-width-threshold nil)

(global-set-key (kbd "<Scroll_Lock>") '(lambda () (interactive) nil))


(setq indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default indent-tabs-mode nil)

(setq-default tab-width 4) ; set tab width to 4 for all
(setq ruby-indent-level 2)

(load-library "git")

(add-to-list 'load-path "~/bash_profiles/bdw/emacs/color-theme-6.6.0/")
(load-library "color-theme")

(add-to-list 'load-path "~/geben-0.26/")
(autoload 'geben "geben" "PHP Debugger on Emacs" t)

;; (speedbar-add-supported-extension ".rb")
;; (speedbar-add-supported-extension ".php")
;; (speedbar-add-supported-extension ".rc1")
;; (speedbar-add-supported-extension ".erb")
;; (speedbar-add-supported-extension ".sql")
;; (speedbar-add-supported-extension ".")

(setq mac-option-modifier  'hyper)
(setq mac-command-modifier 'meta)

(load-file "~/bash_profiles/bdw/emacs/ebs.el")
(global-set-key [C-tab] (quote ebs-switch-buffer))
(global-set-key "." (quote ebs-switch-buffer))

;; org mode

;; The following lines are always needed.  Choose your own keys.

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.csv\\'" . fundamental-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;; crashes osx

(global-unset-key "")

(load "~/Downloads/nxhtml/autostart.el")

(defun devplan-org ()
  "open the devplan-org file"
  (interactive)
  )

(defun rover-find ()       ; Interactive version.
  "rover-find"
  (interactive)
  (setq text (read-from-minibuffer "Search text? "))
  (find-name-dired (concat (getenv "HOME") "/dev/bitbucket/aura-rover-config") (concat "*" text "*"))
)

(defun file-find-current-directory ()       ; Interactive version.
  "Searches the buffer current directory for a name "
  (interactive)
  (setq text (read-from-minibuffer "Search text? "))
  (setq directory (read-from-minibuffer "Directory? " default-directory nil nil file-name-history))
  (find-name-dired directory (concat "*" text "*"))
)


(global-set-key [C-M-f6] (quote find-dired))

(global-set-key [C-M-f7] (quote file-find-current-directory))


(global-set-key [C-M-f4] (quote search-all-buffers))

;; bury *scratch* buffer instead of kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

(setq js-indent-level 2)

;; http://www.emacswiki.org/emacs/IndentingJava
(add-hook 'java-mode-hook (lambda ()
							(setq c-basic-offset 2
								  tab-width 2
								  indent-tabs-mode nil)))

(fset 'php-dump
   [?\C-a tab ?e ?c ?h ?o ?  ?v ?a ?r ?_ ?d ?u ?m ?p ?\( ?\C-e ?\) ?\; ?\C-a tab])

(global-set-key "p" (quote php-dump))

(load-library "rails")
(load-library "bretsmac")
(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(defun xah-copy-file-path (&optional φdir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
If `universal-argument' is called, copy only the dir path.
Version 2015-01-14
URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'"
  (interactive "P")
  (let ((fPath
         (if (equal major-mode 'dired-mode)
             default-directory
           (buffer-file-name))))
    (kill-new
     (if (equal φdir-path-only-p nil)
         fPath
       (file-name-directory fPath)))
    (message "File path copied: 「%s」" fPath)))


(load-library "php-mode")
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(fset 'irb-follow-stacktrace
   [?\C-r ?  ?\C-? ?\C-i ?f ?r ?o ?m ?  ?\C-f ?\M-f ?\C-f ?\C-  ?\C-s ?: ?\C-b ?\M-w ?\C-x ?4 ?f ?\C-y return ?\C-x ?o ?\C-f ?\C-  ?\M-f ?\M-w ?\C-a ?\C-x ?o ?\M-x ?g ?o ?t ?o ?- ?l ?i ?n ?e return ?\C-y return ?\C-x ?o])

(global-set-key "e" (quote irb-follow-stacktrace))

(fset 'goto-ruby-error
   [?\C-a ?\C-  ?\C-s ?: ?\C-b ?\M-w ?\C-x ?4 ?f ?\C-a ?\C-y ?\C-k return ?\C-x ?o ?\C-f ?\C-  ?\M-f ?\M-w ?\C-x ?o ?\M-x ?g ?o ?t ?o ?- ?l ?i ?n ?e return ?\C-y return])

(global-set-key "u" (quote goto-ruby-error))

(defun make-recursive-directory-writable ()
  "recurse through the current working directory"
  (interactive)
  (shell-command "find . -type d |xargs sudo chmod 777 ; find . -type f |xargs sudo chmod 666" nil nil)
  )


(tool-bar-mode -1)

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(defun fix-htdocs-permissions ()
  "fix-htdocs-permissions"
  (interactive)
  (shell-command "find . -type f | xargs sudo chmod 666; find . -type d | xargs sudo chmod 777" nil nil)
  )

(fset 'html-close-tag
   [?\C-r ?< ?\C-f ?\C-  ?\M-f ?\M-w ?\C-e ?> return tab ?< ?/ ?\C-y ?> ?\C-x ?\C-x ?\C-p ?\C-e ?\C-b])

(global-set-key "m" (quote html-close-tag))




;;  Melpa Setup

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
