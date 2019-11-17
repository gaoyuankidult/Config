#!/usr/bin/env bash

WS_LAYOUT_FILE=/home/$USER/Config/i3/workflow_layout.json




# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)



i3-msg append_layout terminator -T "Task" -e ~/Config/i3/task.sh
"$WS_LAYOUT_FILE" &
terminator -T "IPython" -e "/home/$USER/anaconda3/bin/ipython" &

session="screen"
tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]; then
	tmux new -d -s screen
fi
terminator -T "Any" -e "tmux attach -t screen" &

session="default"
tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]; then
	tmux new -d -s default
fi
terminator -T "Ranger" -e "tmux attach -t default" &

session="runner"
tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]; then
	tmux new -d -s runner
fi
terminator -T "Runner" -e "tmux attach -t runner" &
terminator -T "Clock" -x tty-clock &
terminator -T "Monitor" -x htop &

