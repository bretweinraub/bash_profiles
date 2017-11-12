;;
(when
    (package-installed-p 'magit )
  (global-set-key (kbd "C-x g") 'magit-status))
