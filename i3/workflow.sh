#!/bin/bash
WS_LAYOUT_FILE=/home/alex/Config/i3/workflow_layout.json

i3-msg append_layout "$WS_LAYOUT_FILE"

terminator -T "IPython" &
terminator -T "Any" &
terminator -T "Ranger" -x emacs25 -nw -f ranger-mode &
terminator -T "Monitor" -x top &

