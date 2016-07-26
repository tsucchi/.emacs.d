;;
;; SQL mode
;;
(require 'sql-indent nil t)
(if (featurep 'sql-indent)
    (progn
      ;;(setq sql-product 'oracle)
	  (sql-set-product "postgres") ; mysql, postgres, oracle, sqlite...
      (setq indent-tabs-mode nil)
      (setq sql-indent-offset 4)
      (setq default-tab-width 4);;なぜか↑が効かない。最悪...
      ;;(setq sql-indent-maybe-tab t)
	  ))


(add-hook 'sql-mode-hook
		  '(lambda ()
			 (define-key sql-mode-map "\C-cc" 'comment-region)
			 (define-key sql-mode-map "\C-cu" 'changecase-word)
			 (define-key sql-mode-map "\C-l" 'my-font-lock-recenter)
			 ))
(add-to-list 'auto-mode-alist '("\\.sql" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . sql-mode))
