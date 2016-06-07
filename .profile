# set default starting place
cd ~/Desktop

# shortcut to go to several frequently used directory
alias cdd='cd ~/Desktop'
alias cdc='cd ~/Config'

# shortcut to nevigate up directory using ..n
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# shortcut for git
alias g='git'

# shortcut for emacs
alias e='emacs -nw'
alias ge='emacs'

# shortcut for source
alias s='source'

# shortcut to logout GUI
alias lo='sudo pkill -u ${USER}'

# shortcut to shutdown and reboot
alias sdn='shutdown now'
alias rb='reboot'

# shortcut for running studying video
alias cds='cd /home/alex/Downloads/RH/RHCSALiveLessons/'
function srun() {
	nohup mplayer /home/alex/Downloads/RH/RHCSALiveLessons/part$1.mp4 > /tmp/nohup.out 2> /tmp/nohup_error.out &
}

# short cut for simple git routines
function ag() {
	git a .
	git commit -m "$1"
	git push
}

