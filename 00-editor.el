;;; editor related settings

;; load editor related libraries
(load-directory-mu "~/.emacs.d/00-editor")

;; base functions for copying
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
)
     
(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
	(let ((beg (get-point begin-of-thing 1))
		  (end (get-point end-of-thing arg)))
	  (copy-region-as-kill beg end)))
)
     
(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
			   (progn (comint-next-prompt 25535) (yank))
			 (progn (goto-char (mark)) (yank) )))))
	(if arg
		(if (= arg 1)
     		nil
		  (funcall pasteMe))
	  (funcall pasteMe))
	)
)

;; copy word
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  )
(global-set-key (kbd "C-c w") (quote copy-word))


;; copy string
(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
  (if (looking-at "[\t ]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
  (if (looking-back "[\t ]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
  (paste-to-mark arg)
  )

(global-set-key (kbd "C-c s") (quote thing-copy-string-to-mark))

;; duplicate a line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-c C-d") 'duplicate-line)

;; copy paragraph
(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
  (paste-to-mark arg)
  )
(global-set-key (kbd "C-c p") (quote copy-paragraph))

;; package list for auto completion
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; set default indentation
(setq default-tab-width 4)

;; save cursor position
(require 'saveplace)
(setq-default save-place t)

;; set keybindings for auto-complete
(define-key ac-completing-map (kbd "RET") nil)

;; set keybindings for ranger-mode
(global-set-key (kbd "C-c C-f") 'ranger-mode)


