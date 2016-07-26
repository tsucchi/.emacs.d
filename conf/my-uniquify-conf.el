;;;
;;; uniquify : バッファの名前を一意にする
;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-strip-common-suffix nil)
