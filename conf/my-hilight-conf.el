(cond
 (window-system
  ;; Window system が有効な場合(-nwじゃない場合)
  (progn
	;;
	;; color-theme
	;;
	;; 名前の通り、色付けのテーマを使えます
	;; http://www.geocities.com/kensanata/emacs-colors.html
    (require 'color-theme nil t)
    (if (featurep 'color-theme)
		(progn
		  (defun color-theme-tsucchi ()
			"color-theme-subtle-hackerをベースにいじったもの"
			(interactive)
			(color-theme-subtle-hacker)
			(let ((color-theme-is-cumulative t))
			  (color-theme-install
			   '(color-theme-tsucchi
				 nil
				 nil
				 (modeline
				  ((t (:foreground "white" :background "RosyBrown4"))))
				 (font-lock-comment-face
				  ((t (:foreground "lime green"))))
				 (font-lock-type-face
				  ((t (:bold nil :foreground "pink"))))
				 (font-lock-string-face
				  ((t (:bold t :foreground "LightSalmon"))))
				 (font-lock-variable-name-face
				  ((t (:bold t :foreground "Aquamarine"))))
				 ))))
		  (add-to-list 'color-themes '(color-theme-tsucchi "customized subtle-hacker" "tsucchi"))
		  (color-theme-tsucchi)
		  ;;ツールバーを消す
		  (tool-bar-mode 0)))))
 (t ; Window system が有効でない場合(-nwで起動した場合)
  (progn
	;;
	;;色の設定(コンソールの時)
	;;
	;; (custom-set-faces
	;;  '(default ((t
	;; 			 (:background "darkslategray" :foreground "chaki")
	;; 			 ))))
	(make-face 'font-lock-keyword-face)
	(set-face-foreground 'font-lock-keyword-face "cornflower blue")
	(setq font-lock-keyword-face 'font-lock-keyword-face)
	(make-face 'font-lock-comment-face)
	(set-face-foreground 'font-lock-comment-face "lime green")
	(setq font-lock-comment-face 'font-lock-comment-face)
	(make-face 'font-lock-string-face)
	(set-face-foreground 'font-lock-string-face "LightSalmon")
	(setq font-lock-string-face 'font-lock-string-face)
	(set-face-bold-p 'font-lock-string-face t)
	(make-face 'font-lock-function-name-face)
	(set-face-foreground 'font-lock-function-name-face "MediumSlateBlue")
	(setq font-lock-function-name-face 'font-lock-function-name-face)
	(make-face 'font-lock-type-face)
	(set-face-foreground 'font-lock-type-face "pink")
	(setq font-lock-type-face 'font-lock-type-face)
	(make-face 'font-lock-variable-name-face)
	(set-face-foreground 'font-lock-variable-name-face "Aquamarine")
	(setq font-lock-variable-name-face 'font-lock-variable-name-face)
	(make-face 'font-lock-builtin-face)
	(set-face-foreground 'font-lock-builtin-face "cornflower blue")
	(setq font-lock-builtin-face 'font-lock-builtin-face)
	(make-face 'font-lock-constant-face)
	(set-face-foreground 'font-lock-constant-face "yellow")
	(setq font-lock-constant-face 'font-lock-constant-face))))
