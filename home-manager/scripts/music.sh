#!/usr/bin/env bash

players="spotify|rhythmbox"
#pctl=$(playerctl -a metadata)
#m=$(echo "$pctl" | grep -E "$players")
if [ -z "$u" ]; then
    artist=$(playerctl -a metadata | grep -E $players | grep xesam:artist | cut -d " " -f 3-)
    song=$(playerctl -a metadata | grep -E $players | grep xesam:title | cut -d " " -f 3-)
    #this might seem redundant, but it actually removes extra whitespace from strings.
    echo "$artist - $song"
else
    echo "No Player Found"
fi
