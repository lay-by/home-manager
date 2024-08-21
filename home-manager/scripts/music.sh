#! /usr/bin/env nix-shell
# shellcheck shell=bash
#! nix-shell -i bash -p playerctl spotify

players="spotify|rhythmbox"
#pctl=$(playerctl -a metadata)
#m=$(echo "$pctl" | grep -E "$players")
if [ -z "$u" ]; then
    artist=$(playerctl -a metadata | grep -E $players | grep xesam:artist | cut -d " " -f 3-)
    song=$(playerctl -a metadata | grep -E $players | grep xesam:title | cut -d " " -f 3-)
    out="$artist - $song"
    out="${out## }"

    #this might seem redundant, but it actually removes extra whitespace from strings.
    echo $out
else
    echo "No Player Found"
fi
