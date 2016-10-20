# set default starting place
cd ~/Desktop

# shortcut to go to several frequently used directory
alias cdd='cd ~/Desktop'
alias cdc='cd ~/Config'
alias cdr='cd ~/Desktop/PhD/Research'

# shortcut for moving to current project
alias cdp='cd ~/Desktop/RedCoast'

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
alias ge='emacs' # graphic emacs

# shortcut for source
alias s='source'

# shortcut to logout GUI
alias lo='sudo pkill -u ${USER}'

# shortcut to shutdown and reboot
alias sdn='shutdown now' # shutdown now
alias rb='reboot' # reboot

# shortcut for creating README template in a git folder
function crt() { # copy read template
	cp ~/Config/readme_tmp.md README.md
	cp ~/Config/header.png header.png
}

# shortcut for running studying video
alias cds='cd /home/alex/Downloads/RH/RHCELiveLessons/'
function srun() {
	nohup mplayer /home/alex/Downloads/RH/RHCSALiveLessons/part$1.mp4 > /tmp/nohup.out 2> /tmp/nohup_error.out &
}

function serun() {
	nohup mplayer /home/alex/Downloads/RH/RHCELiveLessons/part$1.mp4 > /tmp/nohup.out 2> /tmp/nohup_error.out &
}

# shortcut for simple git routines
function ag() { # auto git
	git a .
	git commit -m "$1"
	git push
}

# shortcut for compile latex
function cl() {
	pdflatex "$1"
	filename=$(basename "$1")
	extension="${filename##*.}"
	filename="${filename%.*}"	
	$(evince "$filename.pdf" > /dev/null 2> /dev/null &)
	fg
}

# add anaconda path to system
export PATH="/home/alex/anaconda2/bin:$PATH"

# create anaconda package
function ic() { # init conda
	conda update conda
	conda create -n "$1" python=2.7 anaconda
}

# switch to conda environment
function coa() { # conda activate
	source activate "$1"
}

# deactivate conda environment
alias cod="source deactivate"

# automatically start to do RedCoast project (this command is used only on my private computer)
alias rc="ssh -X alega837 ssh -X alex ~/Desktop/pycharm-2016.2.3/bin/pycharm.sh"
