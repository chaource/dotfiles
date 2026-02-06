#!/usr/bin/env sh

# kill all polybar instances
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# exec polybar -c ~/.config/i3/polybar_config --reload main

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/i3/polybar_config --reload main &
  done
else
  polybar -c ~/.config/i3/polybar_config --reload main &
fi
