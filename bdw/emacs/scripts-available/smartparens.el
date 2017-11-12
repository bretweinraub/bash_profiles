					; https://crypt.codemancers.com/posts/2013-09-26-setting-up-emacs-as-development-environment-on-osx/

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
(when (fboundp 'rhtml-mode)
  (sp-local-pair 'rhtml-mode "<" ">")
  (sp-local-pair 'rhtml-mode "")
  )
