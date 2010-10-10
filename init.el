;;; -*- mode: lisp-interaction; syntax: elisp -*-
;;;
;;; .emacs: emacs ����ե����롣emacs 21 �ʾ���оݤˤ��Ƥ���Ĥ��(Meadow/NTEmacs ��)


;;
;; install-elisp
;;(install-elisp-from-emacswiki "auto-install.el")
(add-to-list 'load-path "~/.emacs.d/elisp")
(when (require 'auto-install nil t)
  (setq install-elisp-repository-directory "~/.emacs.d/elisp")
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))


(set-language-environment "Japanese")

;;;
;;; Windows �Ϥ� emacs ������
;;;
(if (equal system-type 'windows-nt)
    (progn
      ;; Meadow/NTEmacs �Ƕ��̤�����(���ܸ�����ʤ�)
      (set-default-coding-systems 'sjis)
      (set-keyboard-coding-system 'sjis)

      (cond
       ((featurep 'meadow)
		(progn
		  ;;
		  ;; meadow
		  ;;
		  (w32-add-font
		   "MS Gothic 16"
		   '((spec
			  ((:char-spec ascii :height any)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 0 1 3 0))
			  ((:char-spec ascii :height any :weight bold)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 0 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec ascii :height any :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 0 1 3 0))
			  ((:char-spec ascii :height any :weight bold :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 0 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec japanese-jisx0208 :height any)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0 nil nil nil 128 1 3 0))
			  ((:char-spec japanese-jisx0208 :height any :weight bold)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0 nil nil nil 128 1 3 0)
			   ((spacing . -1)))
			  ((:char-spec japanese-jisx0208 :height any :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 400 0   t nil nil 128 1 3 0))
			  ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
			   strict
			   (w32-logfont "MS Gothic" 0 -16 700 0   t nil nil 128 1 3 0)
			   ((spacing . -1))))))
		  ;; ��ư�������new-frame���Υե졼��(������ɥ�)�����ꡣ
		  (add-to-list 'default-frame-alist '(font . "MS Gothic 16"))
		  ;; ���ߤΥե졼�������(.emacs��ǤϾ�ά��)
		  (set-frame-font "MS Gothic 16")
		  ;; IME�Υե���Ȥ����ꡣ���������񼰤Ǥʤ��Ȥ���餷����
		  (let ((logfont '(w32-logfont "MS Gothic" 0 0 400 0 nil nil nil 128 1 3 0)))
			(modify-frame-parameters (selected-frame) (list (cons 'ime-font logfont)))
			(add-to-list 'default-frame-alist (cons 'ime-font logfont)))
		  (setq default-frame-alist
				(append (list
						 '(width . 154)    ;;�ե졼�����
						 '(height . 67)) ;;�ե졼��ι⤵
						default-frame-alist))
		  
		  ;; ���ܸ�Ķ�������
		  (set-terminal-coding-system 'sjis)
		  (setq file-name-coding-system 'sjis)
		  (set-clipboard-coding-system 'sjis-dos)
		  (set-w32-system-coding-system 'sjis-dos)
		  (set-input-method "MW32-IME")
		  (toggle-input-method)
		  (setq-default mw32-ime-mode-line-state-indicator "[--]")
		  (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[��]" "[--]"))
		  (mw32-ime-initialize)

		  ;; dos�Υ��ޥ�ɴ�Ϣ
		  (setq explicit-shell-file-name "cmdproxy.exe")
		  (setq shell-file-name "cmdproxy.exe")
		  (setq shell-command-switch "-c")       
		  ))
       (t
		(progn
		  ;;
		  ;; NTEmacs �ξ��
		  ;;
		  
		  (setq w32-enable-synthesized-fonts t)
		  ;;(create-fontset-from-ascii-font "-outline-�ͣ� �����å�-normal-r-normal-normal-16-*-*-*-*-*-iso8859-1" nil "myfont")
		  ;;(set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("�ͣ� �����å�" . "jisx0208-sjis"))
		  ;;(set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("�ͣ� �����å�" . "jisx0201-katakana"))
		  (create-fontset-from-ascii-font "-outline-VL �����å�-normal-r-normal-normal-16-*-*-*-*-*-iso8859-1" nil "myfont")
		  (set-fontset-font "fontset-myfont" 'japanese-jisx0208  '("VL �����å�" . "jisx0208-sjis"))
		  (set-fontset-font "fontset-myfont" 'katakana-jisx0201 '("VL �����å�" . "jisx0201-katakana"))

		  (setq default-frame-alist
				(append (list
						 '(width . 155) ;;�ե졼�����
						 '(height . 52) ;;�ե졼��ι⤵
						 '(top . 0)     ;; �ե졼�ຸ��� y ��ɸ
						 '(left . 0)    ;; �ե졼�ຸ��� x ��ɸ
						 '(font . "fontset-myfont")
						 )
						default-frame-alist))

		  (setq initial-frame-alist default-frame-alist)
		  (w32-ime-initialize)
		  (set-input-method "W32-IME")
		  (setq-default w32-ime-mode-line-state-indicator "[--]")
		  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[��]" "[--]"))
		  )))

      ;; ���ܸ��Ϣ(IME �ν������)
      (global-unset-key "\C-o")
      (global-set-key "\C-o" 'toggle-input-method)
	  (prefer-coding-system 'utf-8-unix)
	  (set-buffer-file-coding-system 'utf-8-unix)
	  ))


;;
;;�ե졼��ȡ����ܸ��Ϣ������(Unix ��)
;;
(if (not (equal system-type 'windows-nt))
    (progn
      (set-default-coding-systems 'euc-jp-unix)
      (set-terminal-coding-system 'euc-jp-unix)
      (set-buffer-file-coding-system 'euc-jp-unix)
      (set-keyboard-coding-system 'euc-jp-unix)
	  ;; �����Хץ�����ư����
	  (server-start)
	  ;; anthy ����ɤ���
      (load "anthy")
      (setq default-input-method "japanese-anthy")
	  (global-unset-key "\C-o")
      (global-set-key "\C-o" 'toggle-input-method)
	  (setq anthy-accept-timeout nil)
      ;;
      ;;�ե졼�������
      ;;
      (setq default-frame-alist 
			(append (list
					 '(width . 104) ;;�ե졼����� 
					 '(height . 47) ;;�ե졼��ι⤵
					 '(font . "fontset-14")
					 ) 
					default-frame-alist))))


;;;
;;; color-theme
;;;
;; ̾�����̤ꡢ���դ��Υơ��ޤ�Ȥ��ޤ�
;; http://www.geocities.com/kensanata/emacs-colors.html
;; (color-theme.el��/usr/local/share/emacs/site-lisp/���֤����ɤ�)
(cond
 (window-system
  (progn
    (require 'color-theme nil t)
    (if (featurep 'color-theme)
		(progn
		  (defun color-theme-tsucchi ()
			"color-theme-subtle-hacker��١����ˤ����ä����"
			(interactive)
			(color-theme-subtle-hacker)
			(let ((color-theme-is-cumulative t))
			  (color-theme-install
			   '(color-theme-tsucchi
				 nil
				 nil
				 (modeline
				  ((t (:foreground "white" :background "RosyBrown4"))))
				 (font-lock-comment-face
				  ((t (:foreground "lime green"))))
				 (font-lock-type-face
				  ((t (:bold nil :foreground "pink"))))
				 (font-lock-string-face
				  ((t (:bold t :foreground "LightSalmon"))))
				 (font-lock-variable-name-face
				  ((t (:bold t :foreground "Aquamarine"))))
				 ))))
		  (add-to-list 'color-themes '(color-theme-tsucchi "customized subtle-hacker" "tsucchi"))
		  (color-theme-tsucchi)
		  )))))
;;;    
;;;mew������ (�᡼�顼)
;;;
;;�ܺ������.mew��.mew.el��
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))
;;mew-fancy-summary
(add-hook 'mew-init-hook 
		  (lambda () 
			(require 'mew-fancy-summary nil t)))

;; Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))

;; theme file
(setq mew-theme-file "~/.mew-theme.el")

;;;
;;; cperl-mode : �٤������꤬�Ǥ���perl�⡼��
;;;
(autoload 'cperl-mode "cperl-mode" "Perl editing mode." t)
(defalias 'perl-mode 'cperl-mode)
;;����ǥ�Ȥȿ��դ��Ȳ��Ԥ򤪤��ʤ�
(defun my-perl-return ()
  (interactive)
  ;;(cperl-indent-command)
  (newline)
  (cperl-indent-command)
  (font-lock-fontify-buffer))
;;perl�⡼�ɸ�ͭ������
(add-hook 'cperl-mode-hook
		  '(lambda ()
			 ;;(set-buffer-file-coding-system 'utf-8-unix)
			 (define-key cperl-mode-map "\C-ci" 'perl-insert-header)
			 (define-key cperl-mode-map "\C-cc" 'comment-region)
			 (define-key cperl-mode-map "\C-cu" 'changecase-word)
			 (define-key cperl-mode-map "\C-j" 'newline)
			 (define-key cperl-mode-map "\C-m" 'my-perl-return)
			 ;;(define-key cperl-mode-map "\C-l" 'my-font-lock-recenter)
			 (define-key cperl-mode-map "\C-cg" 'goto-line)
			 (setq cperl-indent-level 4
				   cperl-continued-statement-offset 4
				   cperl-close-paren-offset -4
				   cperl-comment-column 40
				   cperl-highlight-variables-indiscriminately t
				   cperl-indent-parens-as-block t
				   cperl-label-offset -4
				   cperl-tab-always-indent t
				   cperl-font-lock t)
			 (setq indent-tabs-mode nil)
			 (setq tab-width 4)
			 (setq font-lock-background-mode 'dark)
			 (setq frame-background-mode 'dark)
			 ;;              (require 'perl-completion nil t)
			 ;;              (if (featurep 'perl-completion)
			 ;;                  (progn
			 ;;                    (perl-completion-mode t)))
			 ))

(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(setq interpreter-mode-alist 
      (append '(("^#!.*perl" . cperl-mode))
			  interpreter-mode-alist))

;;
;; w3m (web�֥饦����)
;;
(require 'w3m nil t)
(setq w3m-use-filter t)
(setq w3m-display-inline-image t)
(setq mime-setup-enable-inline-html t)
;;;
;;; Visual Basic mode
;;;
(autoload 'visual-basic-mode "visual-basic-mode" "VB editing mode." t)
(add-to-list 'auto-mode-alist '("\\.bas$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.cls$" . visual-basic-mode))


;;�ġ���С���ä�
(tool-bar-mode 0)
;;������������Ǥ�ߤ��
(blink-cursor-mode 0)
;;�����������ɽ���򤷤ʤ�
(setq cursor-in-non-selected-windows nil)
;;�ǥХå��μ�ư��ư�򤷤ʤ�
(setq eval-expression-debug-on-error nil)
;;���᡼���ե������б�
(auto-image-file-mode)
;;emacs21�ʹߤϥ��󥽡���Ǥ⿧�դʤΤǤ�����font-lock����ɤ���ʿ��
(global-font-lock-mode t)
;;�������ȥ��åץ�å�������ɽ�����ʤ�
(setq inhibit-startup-screen t)
;;�������¸����
(savehist-mode t)
;; �ե�������Υ���������Ͽ����
(setq-default save-place t)
;; GC �򸺤餷�Ʒڤ�����
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;; ���ε�Ͽ�Կ������䤹
(setq message-log-max 1000)
;; �ߥ˥Хåե���Ƶ�Ū�˸ƤӽФ���褦�ˤ���
(setq enable-recursive-minibuffers t)
;; ���������ܥå�����Ȥ�ʤ��褦�ˤ���
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;; ����򤿤�������¸����
(setq history-length 1000)
;; �������ȥ����򥨥������ꥢ��®��ɽ������
(setq echo-keystrokes 0.1)
;; �礭���ե�����򳫤����Ȥ��˷ٹ𤹤뤷�����ͤ����䤹(25MB)
(setq large-file-warning-threshold (* 25 1024 102))
;;�ߥ˥Хåե������Ϥ���ä��Ƥ�����˻Ĥ�
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (activate-minibuffer-window))
	(add-to-history minibuffer-history-variable (minibuffer-contents))))
;; yes/no ������� y/n �ˤ���
(defalias 'yes-or-no-p 'y-or-n-p)

;;
;;��������(���󥽡���λ�)
;;
(cond
 ((not window-system)
  (progn
    (make-face 'font-lock-keyword-face)     
    (set-face-foreground 'font-lock-keyword-face "cornflower blue")
    (setq font-lock-keyword-face 'font-lock-keyword-face)
    (make-face 'font-lock-comment-face)
    (set-face-foreground 'font-lock-comment-face "lime green")
    (setq font-lock-comment-face 'font-lock-comment-face)
    (make-face 'font-lock-string-face)
    (set-face-foreground 'font-lock-string-face "deep pink")
    (setq font-lock-string-face 'font-lock-string-face)
    (make-face 'font-lock-function-name-face)
    (set-face-foreground 'font-lock-function-name-face "red")
    (setq font-lock-function-name-face 'font-lock-function-name-face)
    (make-face 'font-lock-type-face)
    (set-face-foreground 'font-lock-type-face "white")
    (setq font-lock-type-face 'font-lock-type-face)  
    (make-face 'font-lock-variable-name-face)
    (set-face-foreground 'font-lock-variable-name-face "pink")
    (setq font-lock-variable-name-face 'font-lock-variable-name-face)
    (make-face 'font-lock-builtin-face)
    (set-face-foreground 'font-lock-builtin-face "cornflower blue")
    (setq font-lock-builtin-face 'font-lock-builtin-face)
    (make-face 'font-lock-constant-face)
    (set-face-foreground 'font-lock-constant-face "yellow")
    (setq font-lock-constant-face 'font-lock-constant-face))))





;;;
;;; ��¿������
;;;

;;�ۡ���ǥ��쥯�ȥ꤫�饹������
(cd "~")
;;�������Ԥ򾡼�˺��ʤ�
(setq next-line-add-newlines nil)
;;�⡼�ɥ饤��˻����ɽ��
(setq display-time-24hr-format t) ;;24h
(display-time)
;;�Хå����åץե��������
(setq make-backup-files t)
;;���ϥ��顼����beep�������
(setq visible-bell t)
;;emacs��Ǥϡ��������������ɤ��餷��
(setenv "LC_TIME" "C")
;;�ߥ˥Хåե��Υ�å�������ɬ�פ˱����Ƴ�ĥ����(���ȥ�����)
;;(resize-minibuffer-mode)
;;ά��Ÿ���ե�������ɤ߹���
;;(read-abbrev-file "~/.abbrev_defs")
;;region����Ω�Ĥ褦�ˤ���
(transient-mark-mode t)
;;���ֹ��ɽ��
(line-number-mode t)
;;���ֹ��ɽ��
(column-number-mode t)
;; �ǥե���ȤΥ���Ĺ�� 4 ��
(setq default-tab-width 4)
;; ���֤ǥ���ǥ�Ȥ��ʤ�
(setq indent-tabs-mode nil)

;;�ǽ���������ư�ǤĤ��롣
;; last updated : yyyy/mm/dd�ν񼰤�ȿ������
(require 'time-stamp)
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "last updated : ")
(setq time-stamp-format "%04y/%02m/%02d")
(setq time-stamp-end " \\|$")
(setq time-stamp-line-limit 20)

;;;
;;; uniquify : �Хåե���̾�����դˤ���
;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;;
;;;global key map
;;;
;;C-h�إ�פ����������Ѥ��˥Хå����ڡ����Ȥ��ƻȤ�
;;�إ�פ�M-x help-command�ǡ�
(global-unset-key "\C-h")
(global-set-key "\C-h" 'backward-delete-char-untabify)
;;C-t�ǵե�������
(global-unset-key "\C-t")
(global-set-key "\C-t" 'scroll-down)

;;;
;;; text mode
;;;
(add-hook 'text-mode-hook '(lambda ()
							 (define-key text-mode-map "\C-cu" 'changecase-word)
							 (font-lock-mode t)
							 (jaspace-mode t)
							 ;;(turn-on-auto-fill)
							 ))
(add-to-list 'auto-mode-alist '("README" . text-mode))

;;;
;;; Fundamental Mode
;;;
(add-hook 'fundamental-mode-hook
		  '(lambda ()
			 (define-key fundamental-mode-map "\C-cu" 'changecase-word)
			 (jaspace-mode t)
			 (modify-frame-parameters nil default-frame-alist)			 ;; emacs23.1 �Ǥ� color-theme �Ƥ֤ȥե졼�ॵ������������ѹ������ΤǤ����Ǽ»�
			 (font-lock-mode t)))


;;;
;;; shell-script-mode
;;;
(add-to-list 'auto-mode-alist '(".cshrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".aliases" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".complete" . shell-script-mode))
(add-hook 'shell-script-mode-hook
		  '(lambda () 
			 (font-lock-mode t)
			 (font-lock-fontify-buffer)))

;;;
;;;trr19 : �����ԥ�����
;;;
;; http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/mydist.shtml
(autoload 'trr "/usr/local/share/emacs/site-lisp/trr/trr" nil t)




;;��ʸ����ʸ���Ѵ�(�����C-c u�˥ޥåԥ�)
(defun changecase-word(cnt)
  "ñ�����ʸ����ʸ���Ѵ�"
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
;;; font-lock�ο��Ĥ���ƤӹԤ�����δؿ�(C-l�˳���դ��������)
;;;
(defun my-font-lock-recenter ()
  (interactive)
  (recenter)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer)))))
;;;
;;; ���Ը�˿��Ĥ�����ؿ�
;;;
(defun my-font-lock-return ()
  (interactive)
  (recenter)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer)
      (newline-and-indent)))))
;;;
;;; perl�⡼��, cperl�⡼�ɤǻȤ��ؿ�
;;;
;;��Ƭ�Ԥ�#!/usr/bin/perl������
(defun perl-insert-header ()
  (interactive)
  (goto-char 1)
  (insert "#!/usr/bin/perl\n")
  (insert "use strict;\n")
  (insert "use warnings;\n")
  )


;;;
;;;Ruby�⡼��
;;;
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
;;��Ƭ�Ԥ�#!/usr/local/bin/ruby������
(defun ruby-insert-header ()
  (interactive)
  (goto-char 1)
  (insert "#!/usr/local/bin/ruby \n"))
;;���Ԥ�Ʊ���˿��Ĥ�
(defun my-ruby-return ()
  (interactive)
  (cond
   (window-system
    (progn
      (font-lock-fontify-buffer))))
  (ruby-reindent-then-newline-and-indent))
;;ruby�⡼�ɸ�ͭ������
(add-hook 'ruby-mode-hook
		  '(lambda () 
			 (define-key ruby-mode-map "\C-ci" 'ruby-insert-header)
			 (define-key ruby-mode-map "\C-cu" 'changecase-word)
			 (define-key ruby-mode-map "\C-j" 'newline)
			 (define-key ruby-mode-map "\C-m" 'my-ruby-return)
			 (define-key ruby-mode-map "\C-l" 'my-font-lock-recenter)))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(setq interpreter-mode-alist 
      (append '(("^#!.*ruby" . ruby-mode))
			  interpreter-mode-alist))


;;;
;;;emacs-lisp-mode��
;;;lisp-interaction-mode�Ѥ�����
;;;
;;��Ƭ�Ԥ�;;; -*- mode: lisp-interaction; syntax: elisp -*-������
(defun lisp-insert-header ()
  (interactive)
  (goto-char 1)
  (insert ";;; -*- mode: lisp-interaction; syntax: elisp -*-\n"))
;;��Ƭ�Ԥ�;;; -*- Emacs-Lisp -*-������
(defun elisp-insert-header ()
  (interactive)
  (goto-char 1)
  (insert ";;; -*- Emacs-Lisp -*-\n"))
;;.emacs�����ɤ���ؿ�
(defun my-load-dot-emacs ()
  (interactive)
  (load "~/.emacs"))
;;lisp-interaction-mode��ͭ������
(add-hook 'lisp-interaction-mode-hook
		  '(lambda ()
			 (define-key lisp-interaction-mode-map "\C-ci" 'lisp-insert-header)
			 (define-key lisp-interaction-mode-map "\C-cu" 'changecase-word)
			 (define-key lisp-interaction-mode-map "\M-\C-m" 'newline)
			 (define-key lisp-interaction-mode-map "\C-cg" 'goto-line)
			 (define-key lisp-interaction-mode-map "\C-cl" 'my-load-dot-emacs)
			 (define-key lisp-interaction-mode-map "\C-l" 'my-font-lock-recenter)
			 (define-key lisp-interaction-mode-map "\C-m" 'my-font-lock-return)
			 (define-key lisp-interaction-mode-map "\C-cc" 'comment-region)))
;;emacs-lisp-mode�Ǥ�Ʊ��ʪ��Ȥ�
(add-hook 'emacs-lisp-mode-hook
		  '(lambda ()
			 (define-key emacs-lisp-mode-map "\C-ci" 'elisp-insert-header)
			 (define-key emacs-lisp-mode-map "\C-cu" 'changecase-word)
			 (define-key emacs-lisp-mode-map "\M-\C-m" 'newline)
			 (define-key emacs-lisp-mode-map "\C-cg" 'goto-line)
			 (define-key emacs-lisp-mode-map "\C-l" 'my-font-lock-recenter)
			 ;;(define-key emacs-lisp-mode-map "\C-m" 'my-hilit-return)
			 (define-key emacs-lisp-mode-map "\C-cl" 'my-load-dot-emacs)
			 (define-key emacs-lisp-mode-map "\C-cc" 'comment-region)))
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))

;;
;; SQL mode
;;
(require 'sql-indent nil t)
(if (featurep 'sql-indent)
    (progn
      ;;(setq sql-product 'oracle)
      (setq sql-product 'mysql)
      (setq indent-tabs-mode nil)
      (setq sql-indent-offset 4)
      (setq default-tab-width 4);;�ʤ������������ʤ����ǰ�...
      ;;(setq sql-indent-maybe-tab t)
	  ))


(add-hook 'sql-mode-hook
		  '(lambda ()
			 (define-key sql-mode-map "\C-cc" 'comment-region)
			 (define-key sql-mode-map "\C-cu" 'changecase-word)
			 (define-key sql-mode-map "\C-l" 'my-font-lock-recenter)
			 ))
(add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . sql-mode))




;;;
;;; �ޥ�������å��ˤ��֥饦��������
;;;
(autoload 'browse-url-at-point "browse-url" nil t)
(autoload 'browse-url-at-mouse "browse-url" nil t)
(autoload 'browse-url-of-buffer "browse-url" nil t)
(autoload 'browse-url-of-file "browse-url" nil t)
(autoload 'browse-url-of-dired-file "browse-url" nil t)
(setq browse-url-netscape-program "/usr/local/bin/firefox")

;;;
;;;navi-2ch: 2ch���ѥ֥饦��
;;;
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(setq navi2ch-list-bbstable-url "http://menu.2ch.net/bbsmenu.html")

;;
;;seimei.el: ��̾����
;;
;;http://kakugawa.aial.hiroshima-u.ac.jp/~kakugawa/Hacks/
(autoload 'seimei "seimei" "seimei" t)


;;
;; ChangeLog (��������)
;;
(add-hook 'change-log-mode-hook
		  '(lambda ()
			 (font-lock-mode nil)
			 (font-lock-mode t)
			 (font-lock-fontify-buffer)))

;; C-x M �� ChangeLog ����ư���ޤ���
(defun memo ()
  (interactive)
  (let ((add-log-current-defun-function 'ignore)
		(memo-file "~/documents/ChangeLog"))
    (set-buffer (find-file-noselect memo-file))
    (add-change-log-entry
     nil
     (expand-file-name memo-file))))
(define-key ctl-x-map "M" 'memo)
;; M-x expand-image �� ChangeLog ������ URL��������ɽ��
;; M-x insert-image-file �ǥե�����̾���䴰���ĤĲ���������
(defun image-file-name-completion (file predicate flag)
  "Completion function for image files."
  (let ((regexp "\\(jpg\\|png\\|gif\\)$"))
    (if (eq flag 'lambda)
		(and (string-match regexp file)
			 (file-exists-p file)
			 (not (file-directory-p file)))
      (let* ((dir (file-name-as-directory
				   (or (file-name-directory file)
					   default-directory)))
			 (collection
			  (delq nil
					(mapcar
					 (lambda (f)
					   (unless (string-match "^\\.\\.?$" f)
						 (cond
						  ((file-directory-p (setq f (concat dir f)))
						   (list (file-name-as-directory f)))
						  ((string-match regexp f)
						   (list f)))))
					 (directory-files dir)))))
		(cond
		 ((not flag)
		  (try-completion file collection predicate))
		 ((eq flag t)
		  (all-completions file collection predicate)))))))

(defun insert-image-file (filename)
  (interactive 
   (list (completing-read "Image file: " 'image-file-name-completion
						  nil t (file-name-as-directory default-directory))))
  (let* ((filename (expand-file-name filename))
		 (image (create-image filename))
		 (url (concat "<" filename ">")))
    (insert-image image url)))

(defun expand-images ()
  (interactive)
  (let* ((pos (point))
		 (home (getenv "HOME"))
		 (regexp (format "<\\(%s/.*\\.\\(jpg\\|png\\|gif\\)\\)>" home)))
    (while (re-search-forward regexp nil t)
      (let* ((start (match-beginning 0))
			 (end (match-end 0))
			 (filename (match-string 1))
			 (image (cons 'image (cdr (create-image filename)))))
		(add-text-properties start end
							 (list 'display image
								   'intangible image
								   'rear-nonsticky (list 'display)))))
    (goto-char pos)))

;;
;; jaspace.el : ���Ѷ����ɽ��
;;
(require 'jaspace nil t)
;;;; ���֤�ɽ��������
										;(setq jaspace-highlight-tabs t)
;; ����ʸ����ɽ��
;;(setq jaspace-alternate-eol-string "��\n")
;;;; Ⱦ�ѥ��ڡ�����ɽ��
;;;;<http://homepage1.nifty.com/blankspace/emacs/color.html>
;; (defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;; (defvar my-face-u-1 'my-face-u-1)
;; (defadvice font-lock-mode (before my-font-lock-mode ())
;;   (font-lock-add-keywords
;;    major-mode
;;     '((" " 0 my-face-u-1 append)
;;     )))
;; (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;; (ad-activate 'font-lock-mode)
(if (featurep 'jaspace)
    (progn
      ;; ����ʸ����ɽ������ؿ�
      (defun my-show-spaces ()
		(interactive)
		(font-lock-mode t)
		(setq jaspace-highlight-tabs t)
		(setq jaspace-alternate-eol-string "��\n")
		(jaspace-mode-off)
		(jaspace-mode-on)
		(font-lock-fontify-buffer))
      ;; ����ʸ����ɽ�������ؿ�
      (defun my-hide-spaces ()
		(interactive)
		(font-lock-mode t)
		(jaspace-mode-off)
		(font-lock-fontify-buffer))))

;;
;; izonmoji-mode : �����¸ʸ����ɽ��
;;
(require 'izonmoji-mode nil t)

;;
;; grep-edit
;;
(require 'grep-edit nil t) 

;;
;; anything.el
;;
(require 'anything nil t)
(require 'anything-config nil t)

(setq anything-sources '( anything-c-source-buffers
						  anything-c-source-imenu
                          anything-c-source-bookmarks
                          anything-c-source-recentf
                          anything-c-source-file-name-history
						  ;;anything-c-source-locate-r
                          anything-c-source-complex-command-history))
(setq anything-type-actions '( anything-actions-buffer
                               anything-actions-file
                               anything-actions-sexp))

(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(global-set-key (kbd "C-x C-b") 'anything) 

;; PerlySense : �䴰��ǽ(�¸��� -> ���ޤ������ޤ�ư���ʤ� orz)
;;(global-unset-key "\C-\\")
;;(setq perly-sense-key-prefix "\C-\\")
;;(setq perly-sense-load-flymake nil)
;;(require 'perly-sense nil t)

;;
;; Haskell mode
;;
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)

;;
;; speedbar(�Ƕ�Ǥ�ɸ������äƤ�ߤ����Ǥ�)
(setq speedbar-supported-extension-expressions
	  (append '(".t" ".c" ".h")))

;;
;; twitterling-mode
(require 'twittering-mode nil t)
(setq twittering-username "tsucchi")
(setq twittering-status-format "%i %s/%S,  (%C{%Y/%m/%d %H:%M:%S}):%L\n%FILL{  %T //[%f%r%R]}\n ")
(setq twittering-convert-fix-size 24)
(setq twittering-auth-method 'xauth)
(setq twittering-allow-insecure-server-cert t)
(add-hook 'twittering-mode-hook 
		  (lambda ()
			(set-face-bold-p 'twittering-username-face t)
			(set-face-foreground 'twittering-username-face "DeepSkyBlue3")
			(set-face-foreground 'twittering-uri-face "LightSalmon")
			(twittering-icon-mode t)
			(twittering-scroll-mode t)
			(setq twittering-reverse-mode t); #�ս�
			(define-key  twittering-mode-map "\C-m" 'twittering-scroll-up)
			(define-key   twittering-mode-map "A" 'twittering-enter)
			(setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)
			))

;;
;; color-moccur/moccur-edit(install from emacswiki)
(when (require 'color-moccur nil t)
  (setq moccur-split-word t))
(require 'moccur-edit nil t)

;;
;; undohist(install from http://cx4a.org/pub/undohist.el)
;; NTEmacs �Ǥ��ޤ�ư���ʤ��Τǥ����ȥ�����
;;(when (require 'undohist nil t)
;;  (undohist-initialize))

;;
;;
;; undo-tree(install from http://www.dr-qubit.org/undo-tree/undo-tree.el)
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;
;; auto-complete
;;(http://cx4a.org/software/auto-complete/ ���DL, �ե������Ÿ������M-x load-file �ǥ��󥹥ȡ���)
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;
;; auto-async-byte-compile.el (install from emacswiki)
;;(when (require 'auto-async-byte-compile nil t)
;;  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))

;; emacs23.2 (�ʹ�?)�Ǥ� color-theme �Ȥ��ȥե졼�ॵ������������ѹ������ΤǤ����Ǽ»�
(add-hook 'window-setup-hook
          (lambda ()
            (modify-frame-parameters (selected-frame) initial-frame-alist)))

;;
;; sticky
;;(install-elisp-from-emacswiki "sticky.el")
;; ��Τ� SKK ���Ƥ���Τۤ����褵��
;;(when (require 'sticky nil t)
;;  (use-sticky-key ";" stick-alist:ja))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
	(load
	 (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
