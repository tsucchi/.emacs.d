;;
;; anything.el
;;(install-elisp-from-emacswiki "anything.el")
(require 'anything nil t)
(require 'anything-config nil t)

(setq anything-sources '( anything-c-source-buffers
                          anything-c-source-recentf
                          anything-c-source-file-name-history
						  anything-c-source-imenu
                          anything-c-source-bookmarks
                          anything-c-source-complex-command-history))
(setq anything-type-actions '( anything-actions-buffer
                               anything-actions-file
                               anything-actions-sexp))

(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(setq anything-enable-shortcuts 'prefix)
(define-key anything-map (kbd "@") 'anything-select-with-prefix-shortcut)

(global-set-key (kbd "C-x C-b") 'anything)



