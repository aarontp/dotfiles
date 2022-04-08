#!/bin/bash
xrandr --output HDMI-1 --auto
xrandr --output HDMI-1 --right-of eDP-1
sleep 3
~/bin/move-right.sh
