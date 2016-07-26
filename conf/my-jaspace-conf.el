;;
;; jaspace.el : 全角空白の表示
;;
(require 'jaspace nil t)
;;;; タブを表示する場合
;;(setq jaspace-highlight-tabs t)
;; 改行文字の表示
;;(setq jaspace-alternate-eol-string "↓\n")
;;;; 半角スペースの表示
;;;;<http://homepage1.nifty.com/blankspace/emacs/color.html>
;; (defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;; (defvar my-face-u-1 'my-face-u-1)
;; (defadvice font-lock-mode (before my-font-lock-mode ())
;;   (font-lock-add-keywords
;;    major-mode
;;     '((" " 0 my-face-u-1 append)
;;     )))
;; (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;; (ad-activate 'font-lock-mode)
(if (featurep 'jaspace)
    (progn
      ;; 空白文字を表示する関数
      (defun my-show-spaces ()
		(interactive)
		(font-lock-mode t)
		(setq jaspace-highlight-tabs t)
		(setq jaspace-alternate-eol-string "↓\n")
		(jaspace-mode-off)
		(jaspace-mode-on)
		(font-lock-fontify-buffer))
      ;; 空白文字の表示をやめる関数
      (defun my-hide-spaces ()
		(interactive)
		(font-lock-mode t)
		(jaspace-mode-off)
		(font-lock-fontify-buffer))))

;;
;; izonmoji-mode : 機種依存文字の表示
;;
(require 'izonmoji-mode nil t)
