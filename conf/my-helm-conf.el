;;; helm
;; (package-install 'helm)
(require 'helm nil t)
(require 'helm-imenu nil t)

;; key settings
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-q") 'helm-buffers-list)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(setq helm-buffer-max-length nil)
(define-key helm-map (kbd "C-h") 'delete-backward-char)

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
							   helm-source-file-name-history)))
