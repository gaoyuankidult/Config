;;; install packages for on a fresh emacs

;; load library for directory loading
(load-file "~/.emacs.d/load-directory-mu.el")
(require 'load-directory-mu)

;;; install el-get  package
;; (see also: https://github.com/dimitri/el-get#basic-setup)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq
 my:el-get-packages
 '(jedi)         ; you also need to install jedi server and it can only be installed outside of virutal environment.
)                ; autocompletion for python

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
	  (url-retrieve-synchronously
	   "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
	(goto-char (point-max))
	(eval-print-last-sexp)))
(el-get 'sync my:el-get-packages)

;;; set hook between different packages and modes
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; list the needed packages

(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
						 ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; list the packages you want
 (setq package-list
    '(auctex auto-complete ranger)
    )


;; activate all the packages
(package-initialize)

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; activate different packages
; invoke the AUCTeX package (LaTeX support)
(require 'tex-site)

;; configure latex mode
(defun LaTeX-mode()
  (add-to-list 'TeX-view-program-list '("Zathura" "zathura %o"))
  (setq TeX-view-program-selection '((output-pdf "Zathura")))
  ; Other mode specific config
  )
(add-hook 'LaTeX-mode-hook 'LaTeX-mode)


;;; load functional modules
(load "~/.emacs.d/00-editor")
(load "~/.emacs.d/01-system")

;;; tell emacs to not warn me about anything except problems
(setq warning-minimum-level :emergency)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (jedi auto-complete markdown-preview-mode auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

