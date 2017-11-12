
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
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


(setq load-path (cons "~" (cons "~/bash_profiles/bdw/emacs" load-path)))
(setq load-path (cons "~/bash_profiles/bdw/emacs/contrib" load-path))
(load-library "search-all-buffers")
; (load-library "bretquote")
(load "bw/ruby.el")
(load "bw/01javascript.el")
(load "bw/02emacs-defaults.el")
(load "bw/03windows.el")
(load "bw/04keymappings.el")
(load "bw/05filesuffixs.el")
(load "bw/ebs.el") ;; Ctrl-tab
(load "bw/yasnippets.el")

(load "bw/smartparens.el")

(load "bw/whitespace.el") ; kill whitespace

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)


;; contrib
(load-library "git")

;; https://github.com/jaypei/emacs-neotree/issues/209
(if (fboundp 'neotree)
    (setq split-window-preferred-function 'neotree-split-window-sensibly)
  )

(load "bw/autocomplete.el")

;; enhanced-ruby-mode
;; https://github.com/zenspider/enhanced-ruby-mode


(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

;; enhanced ruby config

;; all hail WindMove!
;; https://www.emacswiki.org/emacs/WindMove

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


(defun chomp(str)
  ;; chomp the last character
  (substring str 0 -1))

(setq current-working-directory
      (chomp (shell-command-to-string "pwd")
	     )
      )

(neotree-dir  current-working-directory)

;; (when (file-exists-p "Gemfile")
;;   (inf-ruby-console-rails current-working-directory))

;; requires melpa package expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
