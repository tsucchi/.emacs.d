;;;
;;; 雑多な設定
;;;

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


;;
;; speedbar
(setq speedbar-supported-extension-expressions
	  (append '(".t" ".c" ".h")))

;;
;; color-moccur/moccur-edit(install from emacswiki)
;; (install-elisp-from-emacswiki "color-moccur.el")
(when (require 'color-moccur nil t)
  (setq moccur-split-word t))
(require 'moccur-edit nil t)

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


;; 最大化して起動
(add-hook 'window-setup-hook
		  (lambda ()
			(set-frame-parameter nil 'fullscreen 'maximized)))
