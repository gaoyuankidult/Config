(defun copy-word (&optional arg)
      "Copy words at point into kill-ring"
       (interactive "P")
       (copy-thing 'backward-word 'forward-word arg)
       ;;(paste-to-mark arg)
     )
(global-set-key (kbd "C-c w") (quote copyt-word))

(require 'package)

;; package list for auto completion
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; set auto-completion mode to be globaly true
(global-auto-complte-mode t)
