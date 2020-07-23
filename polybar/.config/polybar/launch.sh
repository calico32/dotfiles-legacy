#!/bin/bash

# get env vars
source "$HOME/.config/polybar/env.sh"

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# logfile
date=$(date "+%Y-%m-%d_%H:%M:%S")
logfile="$HOME/.config/polybar/logs/log-$date.log"

polybar main -c "$HOME/.config/polybar/main.ini" > "$logfile" 2>&1 &
