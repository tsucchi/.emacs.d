;;;
;;;Rubyモード
;;;
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
;;rubyモード固有の設定
(add-hook 'ruby-mode-hook
		  '(lambda ()
			 (define-key ruby-mode-map "\C-ci" 'ruby-insert-header)
			 (define-key ruby-mode-map "\C-cu" 'changecase-word)
			 (define-key ruby-mode-map "\C-l" 'my-font-lock-recenter)))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(setq interpreter-mode-alist
      (append '(("^#!.*ruby" . ruby-mode))
			  interpreter-mode-alist))

;; ruby 2.0以降ではマジックコメント不要
(setq ruby-insert-encoding-magic-comment nil)

