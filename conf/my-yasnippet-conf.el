;;
;; yasnippet
;; package-install で入る
(when (require 'yasnippet)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))
