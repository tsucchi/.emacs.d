;;; -*- mode: lisp-interaction; syntax: elisp -*-

(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))

(setq load-path
      (append '("~/.emacs.d/conf") load-path))
(setq load-path
      (append '("~/.emacs.d/modes") load-path))

(load "my-package-install-conf")
(load "my-japanese-conf")

(if (equal system-type 'darwin)
	(load "my-mac-conf"))

(if (equal system-type 'windows-nt)
    (load "my-windows-conf"))

(if (or (equal system-type 'berkeley-unix)
		(equal system-type 'gnu/linux))
	(load "my-linux-bsd-conf"))

;; 設定系
(load "my-misc-conf")
(load "my-hilight-conf")
(load "my-uniquify-conf")
(load "my-keymap-conf")
(load "my-functions")
(load "my-jaspace-conf")
(load "my-anything-conf")
;;(load "my-helm-conf")
(load "my-auto-complete-conf")
(load "my-yasnippet-conf")

;; プログラミングの mode 系
(load "my-perl6-mode")
(load "my-perl-mode")
(load "my-vb-mode")
(load "my-text-mode")
(load "my-fundamental-mode")
(load "my-shell-script-mode")
(load "my-ruby-mode")
(load "my-lisp-mode")
(load "my-sql-mode")
(load "my-haskell-mode")
(load "my-html-mode")
(load "my-markdown-mode")
(load "my-scss-mode")
(load "my-yaml-mode")
(load "my-scala-mode")
(load "my-docker-mode")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet yaml-mode sql-indent package-utils magit helm-ag epl column-marker auto-install auto-complete anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
