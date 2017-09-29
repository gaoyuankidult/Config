(defun ranger-go (path)
  "Go subroutine"
  (interactive
   (list
    (read-char-choice
     "e   : /etc
u   : /usr
d   : /dev
l   : follow directory link
L   : follow selected file
o   : /opt
v   : /var
h   : ~/
r   : ~/Desktop/red-coast/
c   : ~/Config
m   : /media
M   : /mnt
s   : /srv
/ : /
R   : ranger . el location
> "
     '(?q ?e ?u ?d ?l ?L ?o ?v ?m ?M ?s ?r ?R ?/ ?h ?g ?D ?j ?k ?T ?t ?n ?c))))
  (message nil)
  (let* ((c (char-to-string path))
         (new-path
          (cl-case (intern c)
            ('e "/etc")
            ('u "/usr")
            ('d "/dev")
            ('l (file-truename default-directory))
            ('L (file-truename (dired-get-filename)))
            ('o "/opt")
            ('v "/var")
            ('c "~/Config")
			('r "~/Desktop/red-coast/")
            ('m "/media")
            ('M "/mnt")
            ('s "/srv")
            ;; ('r "/")
            ('R (file-truename (file-name-directory (find-library-name "ranger.el"))))
            ('h  "~/")
            ('/ "/")))
         (alt-option
          (cl-case (intern c)
            ;; Subdir Handlng
            ('j 'ranger-next-subdir)
            ('k 'ranger-prev-subdir)
            ;; Tab Handling
            ('n 'ranger-new-tab)
            ('T 'ranger-prev-tab)
            ('t 'ranger-next-tab)
            ;;('c 'ranger-close-tab)
            ('g 'ranger-goto-top))))
    (when (string-equal c "q")
      (keyboard-quit))
    (when (and new-path (file-directory-p new-path))
      (ranger-find-file new-path))
    (when (eq system-type 'windows-nt)
      (when (string-equal c "D")
        (ranger-show-drives)))
    (when alt-option
      (call-interactively alt-option))))
