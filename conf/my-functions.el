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
