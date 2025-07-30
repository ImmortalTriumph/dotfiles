#!/bin/bash

pkill mpvpaper
mpvpaper -o "--loop --no-audio --hwdec=vaapi" '*' ~/.config/hypr/wallpaper/lock.webm
