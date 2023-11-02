#!/bin/bash
nmconns=$(hyprctl clients -j | jq -r '.[] | select(.class == "nm-connection-editor") | .address')
if [ -z "$nmconns" ]; then
	# Not running, open
	nm-connection-editor >/dev/null &
else
	# Running, close
	for nmconn in $nmconns; do
		hyprctl dispatch closewindow "address:$nmconn" >/dev/null
	done
fi
