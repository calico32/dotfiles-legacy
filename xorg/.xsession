#!/bin/sh

mkdir -p "$HOME/.mpd"
export MPD_HOST+="$HOME/.mpd/socket"
