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
