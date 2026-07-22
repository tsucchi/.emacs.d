;;
;; 手動配置の elisp を load-path に追加
;;
(add-to-list 'load-path "~/.emacs.d/elisp")

;;
;; package.el (GNU ELPA / nongnu ELPA / MELPA)
;;
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)
