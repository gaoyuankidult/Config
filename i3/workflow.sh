#!/usr/bin/env sh

WS_LAYOUT_FILE=/home/alex/Config/i3/workflow_layout.json

i3-msg append_layout "$WS_LAYOUT_FILE"
terminator -T "Task" -e "~/Config/i3/task.sh" &
terminator -T "IPython" &
terminator -T "Ranger" -x emacs25 -nw -f ranger-mode &
terminator -T "Clock" -x tty-clock &
terminator -T "Monitor" -x top &

