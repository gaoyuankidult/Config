;;; install packages for on a fresh emacs

;; load library for directory loading
(load-file "~/.emacs.d/load-directory-mu.el")
(require 'load-directory-mu)

;;list the needed packages
(setq package-list '()) 

(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; load functional modules
(load "~/.emacs.d/00-editor")
(load "~/.emacs.d/01-system")
