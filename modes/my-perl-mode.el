;;;
;;; cperl-mode : 細かい設定ができるperlモード
;;;
(require 'jpl-reformat nil t)
(defun ensure-mark()
  "Deprecated function that is needed by jpl-reformat"
  (and (not mark-active) (set-mark-command nil)))

(autoload 'cperl-mode "cperl-mode" "Perl editing mode." t)
(defalias 'perl-mode 'cperl-mode)
;;インデントと色付けと改行をおこなう
(defun my-perl-return ()
  (interactive)
  ;;(cperl-indent-command)
  (newline)
  (cperl-indent-command)
  (font-lock-fontify-buffer))
;;perlモード固有の設定
(add-hook 'cperl-mode-hook
		  '(lambda ()
			 ;;(set-buffer-file-coding-system 'utf-8-unix)
			 (define-key cperl-mode-map "\C-ci" 'perl-insert-header)
			 (define-key cperl-mode-map "\C-cc" 'comment-region)
			 (define-key cperl-mode-map "\C-cu" 'changecase-word)
			 (define-key cperl-mode-map "\C-j" 'newline)
			 (define-key cperl-mode-map "\C-m" 'my-perl-return)
			 (define-key cperl-mode-map "\C-l" 'my-font-lock-recenter)
			 (define-key cperl-mode-map "\C-cg" 'goto-line)
			 (define-key cperl-mode-map "\C-cr" 'jpl-reformat-align-enclosing-block)
			 (setq cperl-indent-level 4
				   cperl-continued-statement-offset 4
				   cperl-close-paren-offset -4
				   cperl-comment-column 40
				   cperl-highlight-variables-indiscriminately t
				   cperl-indent-parens-as-block t
				   cperl-label-offset -4
				   cperl-tab-always-indent t
				   cperl-font-lock t)
			 (setq indent-tabs-mode nil)
			 (setq tab-width 4)
			 (setq font-lock-background-mode 'dark)
			 (setq frame-background-mode 'dark)
			 (cperl-set-style "PerlStyle")
			 ;; 配列とハッシュの色設定
			 (set-face-background 'cperl-array-face nil)
			 (set-face-bold-p 'cperl-array-face nil)
			 (set-face-foreground 'cperl-array-face "light salmon")
			 (set-face-background 'cperl-hash-face nil)
			 (set-face-bold-p 'cperl-hash-face nil)
			 (set-face-foreground 'cperl-hash-face "beige")
			 ;;              (require 'perl-completion nil t)
			 ;;              (if (featurep 'perl-completion)
			 ;;                  (progn
			 ;;                    (perl-completion-mode t)))
			 ))

(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile" . cperl-mode))
(setq interpreter-mode-alist
      (append '(("^#!.*perl" . cperl-mode))
			  interpreter-mode-alist))

;;;
;;; perlモード, cperlモードで使う関数
;;;
;;先頭行に#!/usr/bin/perlを入力
(defun perl-insert-header ()
  (interactive)
  (goto-char 1)
  (insert "#!/usr/bin/perl\n")
  (insert "use strict;\n")
  (insert "use warnings;\n")
  )
