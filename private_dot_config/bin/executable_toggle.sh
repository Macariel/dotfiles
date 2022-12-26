#!/bin/bash - 
app_name="$1"
app="$2"

id=$(wmctrl -l | grep -i "$app_name" | head -n 1 | awk '{print $1}')
if [[ -z "$id" ]]; then
	$app &
	# need to exit here because using wmctlr on a not yet started window seems to break plasma
	exit 0
fi

# Convert hex to decimal
id=$(echo $id | xargs printf %d)

if [[ $(xdotool getactivewindow) -eq $id ]]; then
	xdotool windowminimize "$id"
else
	wmctrl -i -R "$id"

	# un-maximize window and move it to the location of the curser and maximize it again
	wmctrl -i -r "$id" -b add,shaded 
	wmctrl -i -r "$id" -b remove,maximized_vert,maximized_horz
	xdotool windowsize "$id" 5 5
	eval $(xdotool getmouselocation --shell)
	xdotool windowmove "$id" $X $Y
	wmctrl -i -r "$id" -b toggle,maximized_vert,maximized_horz
	wmctrl -i -r "$id" -b remove,shaded 
fi
