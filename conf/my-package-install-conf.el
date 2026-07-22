;;
;; 手動配置の elisp を load-path の末尾(fallback)に追加
;; ※ 先頭に足すと elpa/本体の同名パッケージ(popup, yaml-mode 等)を
;;   古い elisp/*.el が上書きしてしまうため、必ず append(第3引数 t)する
;;
(add-to-list 'load-path "~/.emacs.d/elisp" t)

;;
;; package.el (GNU ELPA / nongnu ELPA / MELPA)
;;
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)
