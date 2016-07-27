;;
;; auto-complete
;; package-install で入る
(require 'auto-complete nil t)
(when (require 'auto-complete-config nil t)
  (global-auto-complete-mode t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))
