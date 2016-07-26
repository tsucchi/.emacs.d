;;;
;;; shell-script-mode
;;;
(add-to-list 'auto-mode-alist '(".cshrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".aliases" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".complete" . shell-script-mode))
(add-hook 'shell-script-mode-hook
		  '(lambda ()
			 (font-lock-mode t)
			 (font-lock-fontify-buffer)))
