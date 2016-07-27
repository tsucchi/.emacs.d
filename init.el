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

(load "package-install")
(load "my-japanese-conf")

(load "my-mac-conf")

(if (equal system-type 'windows-nt)
    (load "my-windows-conf"))
(load "linux-bsd")

;; 設定系
(load "hilight")
(load "misc")
(load "my-uniquify-conf")
(load "keymap")
(load "my-functions")
(load "my-jaspace-conf")
(load "my-anything-conf")
(load "my-auto-complete-conf")
(load "my-yasnippet-conf")

;; プログラミングの mode 系
(load "perl6")
(load "perl")
(load "vb")
(load "my-text-mode")
(load "my-fundamental-mode")
(load "my-shell-script-mode")
(load "my-ruby-mode")
(load "lisp")
(load "my-sql-conf")
(load "my-haskell-mode")
(load "my-html-mode")
(load "my-markdown-mode")
(load "my-scss-mode")
(load "my-yaml-mode")
(load "my-scala-mode")


