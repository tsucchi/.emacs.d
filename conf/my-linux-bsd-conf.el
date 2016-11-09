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
				  default-frame-alist)))))
