;;;
;;; Fundamental Mode
;;;
(add-hook 'fundamental-mode-hook
		  '(lambda ()
			 (define-key fundamental-mode-map "\C-cu" 'changecase-word)
			 (jaspace-mode t)
			 (modify-frame-parameters nil default-frame-alist)			 ;; emacs23.1 では color-theme 呼ぶとフレームサイズが勝手に変更されるのでここで実施
			 (font-lock-mode t)))
