;;;
;;; Windows 系の emacs の設定
;;;

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
(set-buffer-file-coding-system 'utf-8-unix)
