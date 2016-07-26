;;;
;;;emacs-lisp-modeと
;;;lisp-interaction-mode用の設定
;;;
;;先頭行に;;; -*- mode: lisp-interaction; syntax: elisp -*-を入力
(defun lisp-insert-header ()
  (interactive)
  (goto-char 1)
  (insert ";;; -*- mode: lisp-interaction; syntax: elisp -*-\n"))
;;先頭行に;;; -*- Emacs-Lisp -*-を入力
(defun elisp-insert-header ()
  (interactive)
  (goto-char 1)
  (insert ";;; -*- Emacs-Lisp -*-\n"))
;;.emacsをリロードする関数
(defun my-load-dot-emacs ()
  (interactive)
  (load "~/.emacs"))
;;lisp-interaction-mode固有の設定
(add-hook 'lisp-interaction-mode-hook
		  '(lambda ()
			 (define-key lisp-interaction-mode-map "\C-ci" 'lisp-insert-header)
			 (define-key lisp-interaction-mode-map "\C-cu" 'changecase-word)
			 (define-key lisp-interaction-mode-map "\M-\C-m" 'newline)
			 (define-key lisp-interaction-mode-map "\C-cg" 'goto-line)
			 (define-key lisp-interaction-mode-map "\C-cl" 'my-load-dot-emacs)
			 (define-key lisp-interaction-mode-map "\C-l" 'my-font-lock-recenter)
			 (define-key lisp-interaction-mode-map "\C-m" 'my-font-lock-return)
			 (define-key lisp-interaction-mode-map "\C-cc" 'comment-region)))
;;emacs-lisp-modeでも同じ物を使う
(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (define-key emacs-lisp-mode-map "\C-ci" 'elisp-insert-header)
			 (define-key emacs-lisp-mode-map "\C-cu" 'changecase-word)
			 (define-key emacs-lisp-mode-map "\M-\C-m" 'newline)
			 (define-key emacs-lisp-mode-map "\C-cg" 'goto-line)
			 (define-key emacs-lisp-mode-map "\C-l" 'my-font-lock-recenter)
			 ;;(define-key emacs-lisp-mode-map "\C-m" 'my-hilit-return)
			 (define-key emacs-lisp-mode-map "\C-cl" 'my-load-dot-emacs)
			 (define-key emacs-lisp-mode-map "\C-cc" 'comment-region)))
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))
