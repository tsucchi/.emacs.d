;;
;;フレームと、日本語関連の設定(FreeBSD/Linux)
;;

;; PATH をシェルから引き継ぐ
;; https://github.com/purcell/exec-path-from-shell
(require 'exec-path-from-shell nil t) 
(if (featurep 'exec-path-from-shell)
	(progn
	  (exec-path-from-shell-initialize)))

;; サーバプロセスを起動する
(require 'server nil t)
(unless (server-running-p)
  (server-start))
(cond
 ;; 日本語入力(mozc)とフォント(Xが有効な場合のみ)
 (window-system
  (progn
	;; 日本語入力: mozc(Emacs 内蔵 / anthy の後継)
	;; mozc が無い環境では skip して壊さない
	(when (locate-library "mozc")
	  ;; mozc は内部で cl(Emacs 29 で obsolete)を必要とするため、
	  ;; 先に cl を読み込んで「Package cl is deprecated」メッセージを抑止する。
	  ;; (obsolete 警告を外した状態でロード。以降 mozc の require 'cl は no-op)
	  (let ((byte-compile-warnings '(not obsolete)))
	    (require 'cl nil t))
	  (require 'mozc)
	  (setq default-input-method "japanese-mozc")
	  (setq mozc-candidate-style 'echo-area) ; 変換候補はエコー領域に表示(確実)
	  ;; 半角/全角キー と C-o で日本語入力 ON/OFF(旧 anthy と同じ C-o)
	  (global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)
	  (global-unset-key "\C-o")
	  (global-set-key "\C-o" 'toggle-input-method))
	;;
	;;フレームの設定
	;;
	;; フォント設定(フォントが無い環境では既定のままにして壊さない)
	;; 欧文: Cascadia Code(プログラミング向け・0/O 区別が明確)
	(when (member "Cascadia Code" (font-family-list))
	  (let ((font "Cascadia Code-18"))
		(add-to-list 'default-frame-alist (cons 'font font))
		(set-frame-font font nil t)))
	;; 日本語: Noto Sans Mono CJK JP(Cascadia は日本語を持たないため)
	(when (member "Noto Sans Mono CJK JP" (font-family-list))
	  (dolist (cs '(japanese-jisx0208 kana han katakana-jisx0201))
		(set-fontset-font t cs (font-spec :family "Noto Sans Mono CJK JP"))))
	;;
	;;フレームの設定
	;;
	;;(setq default-frame-alist
	;;	  (append (list
	;;			   '(width . 104) ;;フレームの幅
	;;			   '(height . 47) ;;フレームの高さ
	;;			   )
	;;			  default-frame-alist))
	)))

;; WSLg + pgtk: Windows クリップボードとのコピペ文字化け対策。
;; pgtk のネイティブ選択が WSLg 経由だと CP932 の生バイトを返して化けるため、
;; wl-clipboard(UTF-8)経由でやり取りする。
(when (and (featurep 'pgtk)
		   (zerop (call-process "which" nil nil nil "wl-copy"))
		   (zerop (call-process "which" nil nil nil "wl-paste")))
  (setq wl-copy-process nil)
  (defun wl-copy (text)
	(setq wl-copy-process (make-process :name "wl-copy"
										:buffer nil
										:command '("wl-copy" "-f" "-n")
										:connection-type 'pipe
										:noquery t))
	(process-send-string wl-copy-process text)
	(process-send-eof wl-copy-process))
  (defun wl-paste ()
	(if (and wl-copy-process (process-live-p wl-copy-process))
		nil ; Emacs 側がクリップボード所有中は内部 kill-ring を使う
	  (shell-command-to-string "wl-paste -n | tr -d '\r'")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste))
