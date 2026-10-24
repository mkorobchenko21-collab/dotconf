#!/usr/bin/env bash
set -eu

player="firefox.instance_1_31"

playerctl -l | grep -q $player || player="$(playerctl -l | head -n 1)"

status=$(playerctl -p $player status 2>/dev/null) || exit 0

if [[ ! "$status" = "Playing" ]] || [[ ! `playerctl metadata --format '{{xesam:url}}'` =~ "https://music.youtube.com" ]]; then
    sleep 5 && exit 0
fi


artist=$(playerctl -p $player metadata --format '{{xesam:artist}}')
title=$(playerctl -p $player metadata --format '{{xesam:title}}')
album=$(playerctl -p $player metadata --format '{{xesam:album}}')
[ -n "$artist" ] && [ -n "$title" ] || exit 0


tooltip="\
<span alpha='72%'>󰠃 Artist</span> <span alpha='96%'>${artist}</span>\n\
<span alpha='72%'>󰀥 Album</span> <span alpha='96%'>${album}</span>\n\
<span alpha='72%'> Song</span> <span alpha='96%'>${title}</span>\
"

if (( ${#title} + ${#artist} < 30 )); then
    printf '{"text":"  %s","tooltip":"%s"}\n' "$title - $artist" "$tooltip"
else
    printf '{"text":"  %s","tooltip":"%s"}\n' "$title" "$tooltip"
fi
