;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;
;;; .emacs: emacs 設定ファイル。emacs 21 以上を対象にしているつもり(Meadow/NTEmacs も)


(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))

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


;;
;; install-elisp
;;(install-elisp-from-emacswiki "auto-install.el")
(add-to-list 'load-path "~/.emacs.d/elisp")
(when (require 'auto-install nil t)
  (setq auto-install-use-wget t)
  (setq auto-install-wget-command "/usr/local/bin/wget --no-check-certificate")
  (setq install-elisp-repository-directory "~/.emacs.d/elisp")
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))


(set-language-environment "Japanese")

;;
;; package
;;
(fset 'package-desc-vers 'package--ac-desc-version)
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(require 'melpa)


;;;
;;; Windows 系の emacs の設定
;;;
(if (equal system-type 'windows-nt)
    (progn
      ;; Meadow/NTEmacs で共通の設定(日本語設定など)
      (set-default-coding-systems 'sjis)
      (set-keyboard-coding-system 'sjis)
	  ;;
	  ;; NTEmacs の場合
	  ;;
	  (setq w32-enable-synthesized-fonts t)
	  ;;(create-fontset-from-ascii-font "-outline-ＭＳ ゴシック-normal-r-normal-normal-14-*-*-*-*-*-iso8859-1" nil "myfont")
	  ;;(set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("ＭＳ ゴシック" . "jisx0208-sjis"))
	  ;;(set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("ＭＳ ゴシック" . "jisx0201-katakana"))
	  (create-fontset-from-ascii-font "-outline-VL ゴシック-normal-r-normal-normal-14-*-*-*-*-*-iso8859-1" nil "myfont")
	  (set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("ＭＳ ゴシック" . "jisx0208-sjis"))
	  (set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("ＭＳ ゴシック" . "jisx0201-katakana"))
	  ;;(set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("VL ゴシック" . "jisx0208-sjis"))
	  ;;(set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("VL ゴシック" . "jisx0201-katakana"))
	  ;;(create-fontset-from-ascii-font "-outline-Ricty-normal-r-normal-normal-18-*-*-*-*-*-iso8859-1" nil "myfont")
	  ;;(set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("Ricty" . "jisx0208-sjis"))
	  ;;(set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("Ricty" . "jisx0201-katakana"))
	  (setq default-frame-alist
			(append (list
					 '(width . 155) ;;フレームの幅
					 '(height . 52) ;;フレームの高さ
					 '(top . 0)     ;; フレーム左上角 y 座標
					 '(left . 0)    ;; フレーム左上角 x 座標
					 '(font . "fontset-myfont")
					 )
					default-frame-alist))

	  (setq initial-frame-alist default-frame-alist)
	  (w32-ime-initialize)
	  (set-input-method "W32-IME")
	  (setq-default w32-ime-mode-line-state-indicator "[--]")
	  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      ;; 日本語関連(IME の初期化後)
      (global-unset-key "\C-o")
      (global-set-key "\C-o" 'toggle-input-method)
	  (set-buffer-file-coding-system 'utf-8-unix)))



;;
;;フレームと、日本語関連の設定(FreeBSD/Linux)
;;
(if (or (equal system-type 'berkeley-unix)
		(equal system-type 'gnu/linux))
    (progn
	  ;; サーバプロセスを起動する
	  (require 'server nil t)
	  (unless (server-running-p)
		(server-start))
	  (cond
	   ;; anthy をロードする(Xが有効な場合のみ)
	   (window-system
		(progn
		  (load "anthy")
		  (setq default-input-method "japanese-anthy")
		  (setq anthy-accept-timeout nil)
		  (global-unset-key "\C-o")
		  (global-set-key "\C-o" 'toggle-input-method)
		  ;;
		  ;;フレームの設定
		  ;;
		  (setq default-frame-alist
				(append (list
						 ;;'(width . 104) ;;フレームの幅
						 ;;'(height . 47) ;;フレームの高さ
						 ;;'(font . "fontset-14")
						 '(font . "-unknown-VL ゴシック-normal-normal-normal-*-13-*-*-*-*-0-iso10646-1")
						 )
						default-frame-alist)))))))

(prefer-coding-system 'utf-8-unix)
(add-hook 'window-setup-hook
		  (lambda ()
			(set-frame-parameter nil 'fullscreen 'maximized)))



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
	(make-face 'font-lock-keyword-face)
	(set-face-foreground 'font-lock-keyword-face "cornflower blue")
	(setq font-lock-keyword-face 'font-lock-keyword-face)
	(make-face 'font-lock-comment-face)
	(set-face-foreground 'font-lock-comment-face "lime green")
	(setq font-lock-comment-face 'font-lock-comment-face)
	(make-face 'font-lock-string-face)
	(set-face-foreground 'font-lock-string-face "deep pink")
	(setq font-lock-string-face 'font-lock-string-face)
	(make-face 'font-lock-function-name-face)
	(set-face-foreground 'font-lock-function-name-face "red")
	(setq font-lock-function-name-face 'font-lock-function-name-face)
	(make-face 'font-lock-type-face)
	(set-face-foreground 'font-lock-type-face "white")
	(setq font-lock-type-face 'font-lock-type-face)
	(make-face 'font-lock-variable-name-face)
	(set-face-foreground 'font-lock-variable-name-face "pink")
	(setq font-lock-variable-name-face 'font-lock-variable-name-face)
	(make-face 'font-lock-builtin-face)
	(set-face-foreground 'font-lock-builtin-face "cornflower blue")
	(setq font-lock-builtin-face 'font-lock-builtin-face)
	(make-face 'font-lock-constant-face)
	(set-face-foreground 'font-lock-constant-face "yellow")
	(setq font-lock-constant-face 'font-lock-constant-face))))


;;;
;;; perl6-mode
;;;
(require 'perl6-mode nil t)
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
			 (setq cperl-indent-subs-specially nil)
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
;;; Visual Basic mode
;;;
(autoload 'visual-basic-mode "visual-basic-mode" "VB editing mode." t)
(add-to-list 'auto-mode-alist '("\\.bas$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.cls$" . visual-basic-mode))


;;カーソルの点滅を止める
(blink-cursor-mode 0)
;;空カーソルの表示をしない
(setq cursor-in-non-selected-windows nil)
;;デバッガの自動起動をしない
(setq eval-expression-debug-on-error nil)
;;イメージファイル対応
(auto-image-file-mode)
;;emacs21以降はコンソールでも色付なのでここでfont-lockをロードして平気
(global-font-lock-mode t)
;;スタートアップメッセージを表示しない
(setq inhibit-startup-screen t)
;;履歴を保存する
(savehist-mode t)
;; ファイル内のカーソルを記録する
(setq-default save-place t)
;; GC を減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;; ログの記録行数を増やす
(setq message-log-max 1000)
;; ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers t)
;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;; 履歴をたくさん保存する
(setq history-length 1000)
;; キーストロークをエコーエリアに速く表示する
(setq echo-keystrokes 0.1)
;; 大きいファイルを開いたときに警告するしきい値を増やす(25MB)
(setq large-file-warning-threshold (* 25 1024 102))
;; yes/no の代わりに y/n にする
(defalias 'yes-or-no-p 'y-or-n-p)
;; conf 系のハイライトをするらしい
(require 'generic-x nil t)




;;;
;;; 雑多な設定
;;;

;;ホームディレクトリからスタート
(cd "~")
;;新しい行を勝手に作らない
(setq next-line-add-newlines nil)
;;モードラインに時刻を表示
(setq display-time-24hr-format t) ;;24h
(display-time)
;;バックアップファイルを作る
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;;入力エラー時のbeep音を光に
(setq visible-bell t)
;;emacs内では、こうした方が良いらしい
(setenv "LC_TIME" "C")
;;regionを目立つようにする
(transient-mark-mode t)
;;行番号を表示
(line-number-mode t)
;;列番号を表示
(column-number-mode t)
;; デフォルトのタブ長を 4 に
(setq default-tab-width 4)
;; タブでインデントしない
(setq indent-tabs-mode nil)

;;;
;;; uniquify : バッファの名前を一意にする
;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-strip-common-suffix nil)

;;;
;;;global key map
;;;
;;C-hヘルプを封印して変わりにバックスペースとして使う
;;ヘルプはM-x help-commandで。
(global-unset-key "\C-h")
(global-set-key "\C-h" 'backward-delete-char-untabify)
;;C-tで逆スクロール
(global-unset-key "\C-t")
(global-set-key "\C-t" 'scroll-down)

;;;
;;; text mode
;;;
(add-hook 'text-mode-hook '(lambda ()
							 (define-key text-mode-map "\C-cu" 'changecase-word)
							 (font-lock-mode t)
							 (jaspace-mode t)
							 ;;(turn-on-auto-fill)
							 ))
(add-to-list 'auto-mode-alist '("README" . text-mode))

;;;
;;; Fundamental Mode
;;;
(add-hook 'fundamental-mode-hook
		  '(lambda ()
			 (define-key fundamental-mode-map "\C-cu" 'changecase-word)
			 (jaspace-mode t)
			 (modify-frame-parameters nil default-frame-alist)			 ;; emacs23.1 では color-theme 呼ぶとフレームサイズが勝手に変更されるのでここで実施
			 (font-lock-mode t)))


;;;
;;; shell-script-mode
;;;
(add-to-list 'auto-mode-alist '(".cshrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".aliases" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".complete" . shell-script-mode))
(add-hook 'shell-script-mode-hook
		  '(lambda ()
			 (font-lock-mode t)
			 (font-lock-fontify-buffer)))

;;;
;;;trr19 : タイピング練習
;;;
;; http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/mydist.shtml
(autoload 'trr "/usr/local/share/emacs/site-lisp/trr/trr" nil t)




;;小文字大文字変換(おもにC-c uにマッピング)
(defun changecase-word(cnt)
  "単語の大文字小文字変換"
  (interactive "p")
  (if (not (eq last-command 'changecase-word))
      (setq changecase-word-type 0))
  (cond ((= changecase-word-type 0)
		 (upcase-word (- cnt))
		 (setq changecase-word-type 1))
		((= changecase-word-type 1)
		 (capitalize-word (- cnt))
		 (setq changecase-word-type 2))
		(t
		 (downcase-word (- cnt))
		 (setq changecase-word-type 0))))
;;;
;;; font-lockの色つけを再び行うための関数(C-lに割り付けると便利)
;;;
(defun my-font-lock-recenter ()
  (interactive)
  (recenter)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer)))))
;;;
;;; 改行後に色つけする関数
;;;
(defun my-font-lock-return ()
  (interactive)
  (recenter)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer)
      (newline-and-indent)))))
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


;;;
;;;Rubyモード
;;;
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
;;rubyモード固有の設定
(add-hook 'ruby-mode-hook
		  '(lambda ()
			 (define-key ruby-mode-map "\C-ci" 'ruby-insert-header)
			 (define-key ruby-mode-map "\C-cu" 'changecase-word)
			 (define-key ruby-mode-map "\C-l" 'my-font-lock-recenter)))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(setq interpreter-mode-alist
      (append '(("^#!.*ruby" . ruby-mode))
			  interpreter-mode-alist))


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

;;
;; SQL mode
;;
(require 'sql-indent nil t)
(if (featurep 'sql-indent)
    (progn
      ;;(setq sql-product 'oracle)
	  (sql-set-product "postgres") ; mysql, postgres, oracle, sqlite...
      (setq indent-tabs-mode nil)
      (setq sql-indent-offset 4)
      (setq default-tab-width 4);;なぜか↑が効かない。最悪...
      ;;(setq sql-indent-maybe-tab t)
	  ))


(add-hook 'sql-mode-hook
		  '(lambda ()
			 (define-key sql-mode-map "\C-cc" 'comment-region)
			 (define-key sql-mode-map "\C-cu" 'changecase-word)
			 (define-key sql-mode-map "\C-l" 'my-font-lock-recenter)
			 ))
(add-to-list 'auto-mode-alist '("\\.sql" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . sql-mode))

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

;;
;; Haskell mode
;;
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)

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
;;(http://cx4a.org/software/auto-complete/ よりDL, ファイルを展開し、M-x load-file でインストール)
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
;; yasnippet-x.x.x.tar.bz2 を展開したものを yasnippet にリネーム
;; ~/.emacs.d/plugins 以下に置いたうえで、
;; yasnippet.el を ~/.emacs.d/elisp に置いて、下記を実行
;; (install-elisp-from-emacswiki "yasnippet-config.el")
(when (require 'yasnippet-config)
  (yas/setup "~/.emacs.d/plugins/yasnippet"))


;; html-mode
(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . html-mode)) ; for TemplateToolkit
(add-to-list 'auto-mode-alist '("\\.mt$" . html-mode)) ; for T::MT
(add-to-list 'auto-mode-alist '("\\.xt$" . html-mode)) ; for Xslate

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

