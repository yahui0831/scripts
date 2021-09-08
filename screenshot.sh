#!/usr/bin/env bash

while true; do
	
	[[ -d screenshot ]] || mkdir screenshot
	gnome-screenshot -f /home/yahuichx/screenshot/screenshot_$(date +%Y%m%d%H%M%S).jpg
	sleep 1200

done
