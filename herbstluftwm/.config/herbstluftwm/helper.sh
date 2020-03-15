#!/bin/bash

function hc() {
    herbstclient "$@"
}

function do_config()
{
    local command="${1}"
    shift

    # associative array hack
    eval "declare -A hash="${1#*=}

    # loop over hash
    for key in "${!hash[@]}"; do
        local value=${hash[$key]}
        hc $command $key $value

        # uncomment to debug in terminal
        # echo $command $key $value
    done
}

function set_tags_with_name() {
    hc rename default "${tag_names[0]}" 2>/dev/null || true

    for index in ${!tag_names[@]} ; do
        hc add "${tag_names[$index]}"

        # uncomment to debug in terminal
        # echo $index

        local key="${tag_keys[$index]}"
        if ! [ -z "$key" ] ; then
            hc keybind "$m-$key" use_index "$index"
            hc keybind "$m-Shift-$key" move_index "$index"
        fi
    done
}

function bind_cycle_layout() {
    # The following cycles through the available layouts
    # within a frame, but skips layouts, if the layout change
    # wouldn't affect the actual window positions.
    # I.e. if there are two windows within a frame,
    # the grid layout is skipped.

    hc keybind $m-space                                       \
      or , and . compare tags.focus.curframe_wcount = 2       \
      . cycle_layout +1 vertical horizontal max vertical grid \
      , cycle_layout +1
}

function do_panel() {
    local panel=$(dirname "$0")/main.sh
    [ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
    for monitor in $(herbstclient list_monitors | cut -d: -f1) ; do
        # start it on each monitor
        "$panel" $monitor &
    done
}


# function do_panel() {
# 	local panel=$(dirname "$0")/main.sh
# 	for monitor in $(hc list_monitors | cut -d: -f1) ; do
# 	[ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
# 	echo $panel
# 		# room for polybar on both monitors
# 		# hlwm padding is in the order of top, right, bottom, left, with the first number being the screen number
# 		hc pad $monitor 25
# 		# start it on each monitor
# 		"$panel" $monitor &
# 	done
# }
