;;
;; install-elisp
;;(install-elisp-from-emacswiki "auto-install.el")
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'melpa nil t)
(fset 'package-desc-vers 'package--ac-desc-version)
(when (require 'package nil t)
  (package-initialize)
  (setq package-archives
		'(("gnu" . "http://elpa.gnu.org/packages/")
		  ("melpa" . "http://melpa.org/packages/")
		  ("org" . "http://orgmode.org/elpa/")
		  ("marmalade" . "http://marmalade-repo.org/packages/"))))

(require 'auto-install nil t)
(when (featurep 'auto-install)
  (setq auto-install-use-wget t)
  ;;(setq auto-install-wget-command "/usr/local/bin/wget --no-check-certificate")
  (setq auto-install-wget-command "/usr/local/bin/wget")
  (setq install-elisp-repository-directory "~/.emacs.d/elisp")
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;;(auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
