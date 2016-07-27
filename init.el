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

;;
;; mac
;;
(if (equal system-type 'darwin)
	(progn
	  ;; PATH をシェルから引き継ぐ
	  ;; https://github.com/purcell/exec-path-from-shell
	  (require 'exec-path-from-shell nil t) 
	  (if (featurep 'exec-path-from-shell)
		  (progn
			(exec-path-from-shell-initialize)))
	  ;;
	  ;; http://d.hatena.ne.jp/kazu-yamamoto/20140625/1403674172
	  (global-set-key [s-mouse-1] 'browse-url-at-mouse)
	  (cond
	   (window-system
		(let* ((size 12)
			   (jpfont "Hiragino Maru Gothic ProN")
			   (asciifont "Monaco")
			   (h (* size 10)))
		  (set-face-attribute 'default nil :family asciifont :height h)
		  (set-fontset-font t 'katakana-jisx0201 jpfont)
		  (set-fontset-font t 'japanese-jisx0208 jpfont)
		  (set-fontset-font t 'japanese-jisx0212 jpfont)
		  (set-fontset-font t 'japanese-jisx0213-1 jpfont)
		  (set-fontset-font t 'japanese-jisx0213-2 jpfont)
		  (set-fontset-font t '(#x0080 . #x024F) asciifont))
		(setq face-font-rescale-alist
			  '(("^-apple-hiragino.*" . 1.2)
				(".*-Hiragino Maru Gothic ProN-.*" . 1.2)
				(".*osaka-bold.*" . 1.2)
				(".*osaka-medium.*" . 1.2)
				(".*courier-bold-.*-mac-roman" . 1.0)
				(".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
				(".*monaco-bold-.*-mac-roman" . 0.9)
				("-cdac$" . 1.3)))))))


(load "package-install")

(set-language-environment "Japanese")

(if (equal system-type 'windows-nt)
    (load "my-windows-conf"))


(load "linux-bsd")

(prefer-coding-system 'utf-8-unix)
(add-hook 'window-setup-hook
		  (lambda ()
			(set-frame-parameter nil 'fullscreen 'maximized)))


(load "hilight")
(load "perl6")
(load "perl")
(load "vb")
(load "misc")
(load "my-uniquify-conf")
(load "keymap")
(load "my-text-mode")
(load "my-fundamental-mode")
(load "my-shell-script-mode")
(load "my-functions")

(load "my-ruby-mode")

(load "lisp")
(load "my-sql-conf")

(load "my-jaspace-conf")

;;
;; grep-edit
;;
(require 'grep-edit nil t)

;;
;; anything.el
;;(install-elisp-from-emacswiki "anything.el")
(require 'anything nil t)
(require 'anything-config nil t)

(setq anything-sources '( anything-c-source-buffers
						  anything-c-source-imenu
                          anything-c-source-bookmarks
                          anything-c-source-recentf
                          anything-c-source-file-name-history
						  ;;anything-c-source-locate-r
                          anything-c-source-complex-command-history))
(setq anything-type-actions '( anything-actions-buffer
                               anything-actions-file
                               anything-actions-sexp))

(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(global-set-key (kbd "C-x C-b") 'anything)

(load "my-haskell-mode")

;;
;; speedbar(最近では標準で入ってるみたいです)
(setq speedbar-supported-extension-expressions
	  (append '(".t" ".c" ".h")))

;;
;; color-moccur/moccur-edit(install from emacswiki)
;; (install-elisp-from-emacswiki "color-moccur.el")
(when (require 'color-moccur nil t)
  (setq moccur-split-word t))
(require 'moccur-edit nil t)

;;
;; auto-complete
;; package-install で入る
(require 'auto-complete nil t)
(when (require 'auto-complete-config nil t)
  (global-auto-complete-mode t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;
;; minor-mode-hack
;;(auto-install-from-emacswiki "minor-mode-hack.el")
(require 'minor-mode-hack nil t)


;;
;; recentf-ext
;; (auto-install-from-emacswiki "recentf-ext.el")
(setq recentf-max-saved-items 1000)

;; wdired.el
(define-key dired-mode-map "r" 'wdired-change-towdired-mode)

;;
;; yasnippet
;; package-install で入る
(when (require 'yasnippet)
  (yas-global-mode 1))

(load "my-html-mode")
(load "my-markdown-mode")


(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))


(require 'yaml-mode nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'scala-mode2 nil t)

;; ---------------------------- 以下は原則として変更しない ------------------------------------
;; emacs23.2 (以降?)では color-theme 使うとフレームサイズが勝手に変更されるのでここで実施
(add-hook 'window-setup-hook
          (lambda ()
            (modify-frame-parameters (selected-frame) initial-frame-alist)))

