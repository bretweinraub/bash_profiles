
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package) ;; You might already have this line
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


;; alt tab

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (expand-line magit yasnippet highlight-indent-guides ag smartparens rspec-mode enh-ruby-mode rvm ac-inf-ruby inf-ruby neotree php-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setq load-path (cons "~/.emacs.d/contrib" load-path))
(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

(global-set-key (kbd "C-c k") 'compile)

(load-file "contrib/load-files.el")
