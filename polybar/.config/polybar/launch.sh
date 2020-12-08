#!/bin/bash

# get env vars
[ -f "$HOME/.config/polybar/.env" ] && . "$HOME/.config/polybar/.env"

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# logfile
logfolder="$HOME/.cache/polybar/logs"
mkdir -p $logfolder

date=$(date "+%Y-%m-%d_%H:%M:%S")
logfile="$logfolder/log-$date.log"

# config file
configfile="$HOME/.config/polybar/config.ini"

if [ "$1" == "--no-detatch" ]; then
  polybar -c "$configfile" main
else
  polybar -c "$configfile" main >"$logfile" 2>&1 &
fi
