;;
;; markdown-mode
;; http://jblevins.org/projects/markdown-mode/markdown-mode.el
;;(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(autoload 'gfm-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . gfm-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook
		  '(lambda ()
			 ;;(define-key markdown-mode-map "\C-ce" 'sgml-name-char); 文字実体参照HTMLモードを事前にロードしないとダメでうまくいっていない
			 ;; インデントがおかしいのを直す http://blog.shibayu36.org/entry/2015/08/04/190956
			 (electric-indent-local-mode -1)))
