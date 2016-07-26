;;
;; markdown-mode
;; http://jblevins.org/projects/markdown-mode/markdown-mode.el
;;(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(autoload 'gfm-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . gfm-mode) auto-mode-alist))

;;先頭行にヘッダを入れる(日記専用)
(defun md-insert-header ()
  (interactive)
  (goto-char 1)
  (insert "---\n")
  (insert "layout: post\n")
  (insert "category: \n")
  (insert "tags: \n")
  (insert "title: \n")
  (insert "---\n")
  (insert "{% include JB/setup %}\n"))
(add-hook 'markdown-mode-hook
		  '(lambda ()
			 ;;(define-key markdown-mode-map "\C-ce" 'sgml-name-char); 文字実体参照HTMLモードを事前にロードしないとダメでうまくいっていない
			 (define-key markdown-mode-map "\C-ci" 'md-insert-header)))
