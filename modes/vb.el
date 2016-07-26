;;;
;;; Visual Basic mode
;;;
(autoload 'visual-basic-mode "visual-basic-mode" "VB editing mode." t)
(add-to-list 'auto-mode-alist '("\\.bas$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.cls$" . visual-basic-mode))
