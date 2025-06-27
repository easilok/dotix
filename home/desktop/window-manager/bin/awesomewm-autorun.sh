#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

sleep 5
numlockx &
wmname compiz

xss-lock -- i3lock-clock-image &

# Commented out as something in the config is locking the WM
run nm-applet
# run xsettingsd
run sxhkd
# If there's a personal Xmodmap setup, use it
[[ -f "$HOME/.Xmodmap" ]] && xmodmap ~/.Xmodmap

# XDG
# run blueman-applet
# run system-config-printer-applet

run picom

run nextcloud
run set-wallpaper
