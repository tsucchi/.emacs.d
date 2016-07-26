;;;
;;; text mode
;;;
(add-hook 'text-mode-hook '(lambda ()
							 (define-key text-mode-map "\C-cu" 'changecase-word)
							 (font-lock-mode t)
							 (jaspace-mode t)
							 ;;(turn-on-auto-fill)
							 ))
(add-to-list 'auto-mode-alist '("README" . text-mode))
