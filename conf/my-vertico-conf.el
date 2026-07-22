;;
;; vertico + consult + orderless + marginalia
;; anything/helm の代替。C-x C-b でバッファ＋最近のファイルを絞り込む
;;
(when (require 'vertico nil t)
  (vertico-mode 1))

(when (require 'marginalia nil t)
  (marginalia-mode 1))

;; orderless: スペース区切りのあいまい絞り込み
(when (require 'orderless nil t)
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles partial-completion)))))

;; recentf: 最近使ったファイルを consult-buffer に出すために有効化
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; savehist: 履歴を永続化し候補の並び順を賢くする
(savehist-mode 1)

;; consult: C-x C-b でバッファ＋最近のファイル＋ブックマークを絞り込み
(when (require 'consult nil t)
  (global-set-key (kbd "C-x C-b") 'consult-buffer)
  (global-set-key (kbd "M-y") 'consult-yank-pop))
