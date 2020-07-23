#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Logfile
logfile="$HOME/.config/polybar/logs/log-$(date \"+%Y-%m-%d_%H:%M:%S\").log"

# Launch bar1 and bar2
polybar main -c ~/.config/polybar/main.ini -l info > "$logfile" 2>&1 &
