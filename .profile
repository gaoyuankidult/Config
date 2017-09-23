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
alias sdn='sudo shutdown now' # shutdown now
alias rb='sudo reboot' # reboot

# shortcut for creating README template in a git folder
function crt() { # copy read template
	cp ~/Config/templates/readme_tmp.md README.md
	cp ~/Config/templates/header.png header.png
}

# shortcut for creating latex template in a git folder
function clt() { # copy read templat
	cp -r ~/Config/templates/icml $1
	mv ./$1/example_paper.tex ./$1/$1.tex
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

# automatically start a terminator at pc-alega837 (this command is used only on my private computer)
alias pct="ssh -X alega837 ssh -X alex terminator"
alias ppct="sshpass -pim3Mb[jbiZ ssh -X alega837 ssh -X alex terminator"

# connect to our groups website cloud (this command is used only on alega837 pc)
alias cw="ssh -i /home/alex/.ssh/alex_yuan_gao.pem -l ubuntu 130.238.10.22"

# connect to alex in inner network
alias calex="ssh -X 130.238.17.189 terminator"

# change the default backgroud to be relatively dark
xsetroot -solid "#111111"

# set default xclip to be output using ctrl+shift+c 
alias xclip='xclip -selection c'

# set the shortcut for pycharm
alias pycharm='~/Downloads/pycharm-community-2017.1.3/bin/pycharm.sh'

# set shortcut to edit .profile file
alias epf='emacs -nw ~/Config/.profile'

# set shortcut to source custom configeration
alias spf='source ~/Config/.profile'

# set shortcut to edit installation file
alias el='emacs -nw ~/Config/lubuntu_setup.sh'

# set shortcut to edit i3 config file
alias ei3='emacs -nw ~/Config/i3/config'

# copy to clipboad
function x() { # conda activate
	echo "$1" | xclip -sel clip 
}

# copy current directory
alias xd='x $(pwd)'

# set shortcut to go to different projects
alias gps='cd ~/Desktop/SocialRoboics/motor-blog/web-static'
alias gpp='cd /media/alex/22E67196E6716AC5/Materials/Research/Proximity/tsv_files'
alias gpr='cd ~/Desktop/red-coast'
alias spr='source ~/Desktop/red-coast/start_dev.sh'

# to accelerate installation
alias i="sudo apt-get install"

# go to folder media
alias gm='cd /media/'

# debug i3
alias di3="i3-msg 'debuglog on; shmlog on; reload'"
