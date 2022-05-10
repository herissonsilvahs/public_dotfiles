#!/bin/sh

xrandr --output HDMI-1 --brightness 0.7

xrandr --output eDP-1 --brightness 0.4

xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rate 60.00 --output HDMI-1 --mode 1920x1080 --rate 75.00 --pos 0x0


