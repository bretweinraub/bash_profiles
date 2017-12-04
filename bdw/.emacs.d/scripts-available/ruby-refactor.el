


(require 'ruby-refactor)
In both cases, you must enable ruby-refactor-minor-mode in ruby-mode:

(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
(add-hook 'enh-ruby-mode-hook 'ruby-refactor-mode-launch)
