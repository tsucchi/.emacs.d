;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;
;;; .emacs: emacs 設定ファイル。emacs 21 以上を対象にしているつもり(Meadow/NTEmacs も)


;;
;; install-elisp
;;(install-elisp-from-emacswiki "auto-install.el")
(add-to-list 'load-path "~/.emacs.d/elisp")
(when (require 'auto-install nil t)
  (setq install-elisp-repository-directory "~/.emacs.d/elisp")
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))


(set-language-environment "Japanese")

;;;
;;; Windows 系の emacs の設定
;;;
(if (equal system-type 'windows-nt)
    (progn
      ;; Meadow/NTEmacs で共通の設定(日本語設定など)
      (set-default-coding-systems 'sjis)
      (set-keyboard-coding-system 'sjis)

      (cond
       ((featurep 'meadow)
		(progn
		  ;;
		  ;; meadow
		  ;;
		  (w32-add-font
		   "MS Gothic 16"
		   '((spec
			  ((:char-spec ascii :height any)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 0 1 3 0))
			  ((:char-spec ascii :height any :weight bold)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 0 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec ascii :height any :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 0 1 3 0))
			  ((:char-spec ascii :height any :weight bold :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 0 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec japanese-jisx0208 :height any)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 128 1 3 0))
			  ((:char-spec japanese-jisx0208 :height any :weight bold)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 128 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec japanese-jisx0208 :height any :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 128 1 3 0))
			  ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 128 1 3 0)
			   ((spacing . -1))))))
		  ;; 起動時およびnew-frame時のフレーム(ウィンドウ)の設定。
		  (add-to-list 'default-frame-alist '(font . "MS Gothic 16"))
		  ;; 現在のフレームの設定(.emacs中では省略可)
		  (set-frame-font "MS Gothic 16")
		  ;; IMEのフォントを設定。こういう書式でないとだめらしい。
		  (let ((logfont '(w32-logfont "MS Gothic" 0 0 400 0 nil nil nil 128 1 3 0)))
			(modify-frame-parameters (selected-frame) (list (cons 'ime-font logfont)))
			(add-to-list 'default-frame-alist (cons 'ime-font logfont)))
		  (setq default-frame-alist
				(append (list
						 '(width . 154)    ;;フレームの幅
						 '(height . 67)) ;;フレームの高さ
						default-frame-alist))

		  ;; 日本語環境の設定
		  (set-terminal-coding-system 'sjis)
		  (setq file-name-coding-system 'sjis)
		  (set-clipboard-coding-system 'sjis-dos)
		  (set-w32-system-coding-system 'sjis-dos)
		  (set-input-method "MW32-IME")
		  (toggle-input-method)
		  (setq-default mw32-ime-mode-line-state-indicator "[--]")
		  (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
		  (mw32-ime-initialize)

		  ;; dosのコマンド関連
		  (setq explicit-shell-file-name "cmdproxy.exe")
		  (setq shell-file-name "cmdproxy.exe")
		  (setq shell-command-switch "-c")
		  ))
       (t
		(progn
		  ;;
		  ;; NTEmacs の場合
		  ;;

		  (setq w32-enable-synthesized-fonts t)
		  ;;(create-fontset-from-ascii-font "-outline-ＭＳ ゴシック-normal-r-normal-normal-16-*-*-*-*-*-iso8859-1" nil "myfont")
		  ;;(set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("ＭＳ ゴシック" . "jisx0208-sjis"))
		  ;;(set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("ＭＳ ゴシック" . "jisx0201-katakana"))
		  (create-fontset-from-ascii-font "-outline-VL ゴシック-normal-r-normal-normal-16-*-*-*-*-*-iso8859-1" nil "myfont")
		  (set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("VL ゴシック" . "jisx0208-sjis"))
		  (set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("VL ゴシック" . "jisx0201-katakana"))

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
		  )))

      ;; 日本語関連(IME の初期化後)
      (global-unset-key "\C-o")
      (global-set-key "\C-o" 'toggle-input-method)
	  (prefer-coding-system 'utf-8-unix)
	  (set-buffer-file-coding-system 'utf-8-unix)
	  ))


;;
;;フレームと、日本語関連の設定(FreeBSD)
;;
(if (equal system-type 'berkeley-unix)
    (progn
      ;;(set-default-coding-systems 'euc-jp-unix)
      (set-terminal-coding-system 'euc-jp-unix)
      (set-buffer-file-coding-system 'euc-jp-unix)
      (set-keyboard-coding-system 'euc-jp-unix)
	  (prefer-coding-system 'utf-8-unix)
	  ;; サーバプロセスを起動する
	  (require 'server nil t)
	  (unless (server-running-p)
		(server-start))
	  ;; anthy をロードする
      (load "anthy")
      (setq default-input-method "japanese-anthy")
	  (global-unset-key "\C-o")
      (global-set-key "\C-o" 'toggle-input-method)
	  (setq anthy-accept-timeout nil)
      ;;
      ;;フレームの設定
      ;;
      (setq default-frame-alist
			(append (list
					 ;;'(width . 104) ;;フレームの幅
					 ;;'(height . 47) ;;フレームの高さ
					 '(font . "fontset-14")
					 )
					default-frame-alist))))

(add-hook 'window-setup-hook
		  (lambda ()
			(set-frame-parameter nil 'fullscreen 'maximized)))



;;;
;;; color-theme
;;;
;; 名前の通り、色付けのテーマを使えます
;; http://www.geocities.com/kensanata/emacs-colors.html
;; (color-theme.elを/usr/local/share/emacs/site-lisp/に置けば良い)
(cond
 (window-system
  (progn
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
		  )))))
;;;
;;;mewの設定 (メーラー)
;;;
;;詳細設定は.mewか.mew.elで
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))
;;mew-fancy-summary
(add-hook 'mew-init-hook
		  (lambda ()
			(require 'mew-fancy-summary nil t)))
(setq mew-use-highlight-summary t)

;; Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))

;; theme file
(setq mew-theme-file "~/.mew-theme.el")

;;;
;;; cperl-mode : 細かい設定ができるperlモード
;;;
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
			 ;;              (require 'perl-completion nil t)
			 ;;              (if (featurep 'perl-completion)
			 ;;                  (progn
			 ;;                    (perl-completion-mode t)))
			 ))

(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(setq interpreter-mode-alist
      (append '(("^#!.*perl" . cperl-mode))
			  interpreter-mode-alist))

;;
;; w3m (webブラウジング)
;;
(require 'w3m nil t)
(setq w3m-use-filter t)
(setq w3m-display-inline-image t)
(setq mime-setup-enable-inline-html t)
;;;
;;; Visual Basic mode
;;;
(autoload 'visual-basic-mode "visual-basic-mode" "VB editing mode." t)
(add-to-list 'auto-mode-alist '("\\.bas$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.cls$" . visual-basic-mode))


;;ツールバーを消す
(tool-bar-mode 0)
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
;;ミニバッファで入力を取り消しても履歴に残す
;; (defadvice abort-recursive-edit (before minibuffer-save activate)
;;   (when (eq (selected-window) (active-minibuffer-window))
;; 	(add-to-history minibuffer-history-variable (minibuffer-contents))))
;; yes/no の代わりに y/n にする
(defalias 'yes-or-no-p 'y-or-n-p)
;; ファイルを開くのを強化
;;(ffap-bindings)
;; ファイル保存前に不要な末尾空白を削除する
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; conf 系のハイライトをするらしい
(require 'generic-x nil t)

;;
;;色の設定(コンソールの時)
;;
(cond
 ((not window-system)
  (progn
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
;;入力エラー時のbeep音を光に
(setq visible-bell t)
;;emacs内では、こうした方が良いらしい
(setenv "LC_TIME" "C")
;;ミニバッファのメッセージを必要に応じて拡張する(ちとウザい)
;;(resize-minibuffer-mode)
;;略語展開ファイルを読み込む
;;(read-abbrev-file "~/.abbrev_defs")
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

;;最終更新日を自動でつける。
;; last updated : yyyy/mm/ddの書式に反応する
(require 'time-stamp)
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "last updated : ")
(setq time-stamp-format "%04y/%02m/%02d")
(setq time-stamp-end " \\|$")
(setq time-stamp-line-limit 20)

;;;
;;; uniquify : バッファの名前を一意にする
;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;
;; iswitchb: バッファ切り替えの強化
;;
(iswitchb-mode 1)
;; バッファ読み取り関数を iswitchb にする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 正規表現を使わない
(setq iswitchb-regexp nil)
;; 新しいバッファを作成する時にいちいち聞かない
(setq iswitchb-prompt-newbuffer)


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
;;先頭行に#!/usr/local/bin/rubyを入力
(defun ruby-insert-header ()
  (interactive)
  (goto-char 1)
  (insert "#!/usr/local/bin/ruby \n"))
;;改行と同時に色つけ
(defun my-ruby-return ()
  (interactive)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer))))
  (ruby-reindent-then-newline-and-indent))
;;rubyモード固有の設定
(add-hook 'ruby-mode-hook
		  '(lambda ()
			 (define-key ruby-mode-map "\C-ci" 'ruby-insert-header)
			 (define-key ruby-mode-map "\C-cu" 'changecase-word)
			 (define-key ruby-mode-map "\C-j" 'newline)
			 (define-key ruby-mode-map "\C-m" 'my-ruby-return)
			 (define-key ruby-mode-map "\C-l" 'my-font-lock-recenter)))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
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
      (setq sql-product 'mysql)
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
(add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . sql-mode))




;;;
;;; マウスクリックによるブラウジング設定
;;;
(autoload 'browse-url-at-point "browse-url" nil t)
(autoload 'browse-url-at-mouse "browse-url" nil t)
(autoload 'browse-url-of-buffer "browse-url" nil t)
(autoload 'browse-url-of-file "browse-url" nil t)
(autoload 'browse-url-of-dired-file "browse-url" nil t)
(setq browse-url-netscape-program "/usr/local/bin/firefox")

;;;
;;;navi-2ch: 2ch専用ブラウザ
;;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(setq navi2ch-list-bbstable-url "http://menu.2ch.net/bbsmenu.html")

;;
;;seimei.el: 姓名診断
;;
;;http://kakugawa.aial.hiroshima-u.ac.jp/~kakugawa/Hacks/
(autoload 'seimei "seimei" "seimei" t)


;;
;; ChangeLog (改定履歴)
;;
(add-hook 'change-log-mode-hook
		  '(lambda ()
			 (font-lock-mode nil)
			 (font-lock-mode t)
			 (font-lock-fontify-buffer)))

;; C-x M で ChangeLog メモを起動します。
(defun memo ()
  (interactive)
  (let ((add-log-current-defun-function 'ignore)
		(memo-file "~/documents/ChangeLog"))
    (set-buffer (find-file-noselect memo-file))
    (add-change-log-entry
     nil
     (expand-file-name memo-file))))
(define-key ctl-x-map "M" 'memo)
;; M-x expand-image で ChangeLog メモ中の URLか画像を表示
;; M-x insert-image-file でファイル名を補完しつつ画像を挿入
(defun image-file-name-completion (file predicate flag)
  "Completion function for image files."
  (let ((regexp "\\(jpg\\|png\\|gif\\)$"))
    (if (eq flag 'lambda)
		(and (string-match regexp file)
			 (file-exists-p file)
			 (not (file-directory-p file)))
      (let* ((dir (file-name-as-directory
				   (or (file-name-directory file)
					   default-directory)))
			 (collection
			  (delq nil
					(mapcar
					 (lambda (f)
					   (unless (string-match "^\\.\\.?$" f)
						 (cond
						  ((file-directory-p (setq f (concat dir f)))
						   (list (file-name-as-directory f)))
						  ((string-match regexp f)
						   (list f)))))
					 (directory-files dir)))))
		(cond
		 ((not flag)
		  (try-completion file collection predicate))
		 ((eq flag t)
		  (all-completions file collection predicate)))))))

(defun insert-image-file (filename)
  (interactive
   (list (completing-read "Image file: " 'image-file-name-completion
						  nil t (file-name-as-directory default-directory))))
  (let* ((filename (expand-file-name filename))
		 (image (create-image filename))
		 (url (concat "<" filename ">")))
    (insert-image image url)))

(defun expand-images ()
  (interactive)
  (let* ((pos (point))
		 (home (getenv "HOME"))
		 (regexp (format "<\\(%s/.*\\.\\(jpg\\|png\\|gif\\)\\)>" home)))
    (while (re-search-forward regexp nil t)
      (let* ((start (match-beginning 0))
			 (end (match-end 0))
			 (filename (match-string 1))
			 (image (cons 'image (cdr (create-image filename)))))
		(add-text-properties start end
							 (list 'display image
								   'intangible image
								   'rear-nonsticky (list 'display)))))
    (goto-char pos)))

;;
;; jaspace.el : 全角空白の表示
;;
(require 'jaspace nil t)
;;;; タブを表示する場合
										;(setq jaspace-highlight-tabs t)
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

;; PerlySense : 補完機能(実験中 -> いまいちうまく動かない orz)
;;(global-unset-key "\C-\\")
;;(setq perly-sense-key-prefix "\C-\\")
;;(setq perly-sense-load-flymake nil)
;;(require 'perly-sense nil t)

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
;; twitterling-mode
(require 'twittering-mode nil t)
(setq twittering-username "tsucchi")
(setq twittering-status-format "%i %s/%S,  (%C{%Y/%m/%d %H:%M:%S}):%L\n%FILL{  %T //[%f%r%R]}\n ")
(setq twittering-convert-fix-size 24)
(setq twittering-auth-method 'xauth)
(setq twittering-allow-insecure-server-cert t)
(add-hook 'twittering-mode-hook
		  (lambda ()
			(set-face-bold-p 'twittering-username-face t)
			(set-face-foreground 'twittering-username-face "DeepSkyBlue3")
			(set-face-foreground 'twittering-uri-face "LightSalmon")
			(twittering-icon-mode t)
			(twittering-scroll-mode t)
			(setq twittering-reverse-mode t); #逆順
			(define-key  twittering-mode-map "\C-m" 'twittering-scroll-up)
			(define-key   twittering-mode-map "A" 'twittering-enter)
			(setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)
			))

;;
;; color-moccur/moccur-edit(install from emacswiki)
(when (require 'color-moccur nil t)
  (setq moccur-split-word t))
(require 'moccur-edit nil t)

;;
;; undohist(install from http://cx4a.org/pub/undohist.el)
;; NTEmacs でうまく動かないのでコメントアウト
;;(when (require 'undohist nil t)
;;  (undohist-initialize))

;;
;;
;; undo-tree(install from http://www.dr-qubit.org/undo-tree/undo-tree.el)
;;(when (require 'undo-tree nil t)
;;  (global-undo-tree-mode))

;;
;; auto-complete
;;(http://cx4a.org/software/auto-complete/ よりDL, ファイルを展開し、M-x load-file でインストール)
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;
;; auto-async-byte-compile.el (install from emacswiki)
;;(when (require 'auto-async-byte-compile nil t)
;;  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))

;;
;; sticky
;;(install-elisp-from-emacswiki "sticky.el")
;; 試すのは SKK も試してからのほうがよさげ
;;(when (require 'sticky nil t)
;;  (use-sticky-key ";" stick-alist:ja))

;;
;; sequential-command
;;(auto-install-from-emacswiki "sequential-command.el")
;;(auto-install-from-emacswiki "sequential-command-config.el")
;;(when (require 'sequential-command-config nil t)
;;  (sequential-command-setup-keys))

;;
;; minor-mode-hack
;;(auto-install-from-emacswiki "minor-mode-hack.el")
(require 'minor-mode-hack nil t)


;;
;; recentf-ext
;; (auto-install-from-emacswiki "recentf-ext.el")
(setq recentf-max-saved-items 1000)
;;(setq recentf-exclude '("file1" "/tmp"))
;;(require 'recentf-ext)
;;(global-set-key (kbd "C-x f") 'recentf-open-files)

;;
;; tempbuf.el : 使わないバッファを自動で削除
;; (auto-install-from-emacswiki "tempbuf.el")
(when (require 'tempbuf nil t)
  (setq tempbuf-minimum-timeout 6000);;[sec] デフォルトだと早すぎるので長くする
  (add-hook 'find-file-hook 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode))

;; auto-save-buffers.el : 自動保存
;; (install-elisp "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el")
(when (require 'auto-save-buffers nil t)
  ;;2秒アイドルで保存する
  (run-with-idle-timer 2 t 'auto-save-buffers))

;; wdired.el
(define-key dired-mode-map "r" 'wdired-change-towdired-mode)

;;
;; redo+.el
;; (auto-install-from-emacswiki "redo+.el")
(when (require 'redo+)
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t); undo で redo しないようにする
  (setq undo-limit 65536)
  (setq undo-strong-limit 131072))

;; ---------------------------- 以下は原則として変更しない ------------------------------------
;; emacs23.2 (以降?)では color-theme 使うとフレームサイズが勝手に変更されるのでここで実施
(add-hook 'window-setup-hook
          (lambda ()
            (modify-frame-parameters (selected-frame) initial-frame-alist)))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
	(load
	 (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
