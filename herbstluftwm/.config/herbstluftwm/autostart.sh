#!/usr/bin/env bash

# this is a modularized config for herbstluftwm

DIR=$(dirname "$0")

. ${DIR}/gmc.sh
. ${DIR}/config.sh
. ${DIR}/helper.sh
. ${DIR}/startup.sh

# background before wallpaper
xsetroot -solid $colBlue500

hc emit_hook reload

hc keyunbind --all
hc mouseunbind --all
hc unrule -F

set_tags_with_name

# hack associative array function argument passing using declare -p

do_config 'keybind'      "$(declare -p keybinds)"
do_config 'keybind'      "$(declare -p tagskeybinds)"
do_config 'mousebind'    "$(declare -p mousebinds)"
do_config 'attr'   "$(declare -p attributes)"
do_config 'set'          "$(declare -p sets)"
do_config 'rule'         "$(declare -p rules)"

# tags
tag_names=( {1..9} )
tag_keys=( {1..9} 0 )

# The following cycles through the available layouts within a frame, but skips
# layouts, if the layout change wouldn't affect the actual window positions.
# I.e. if there are two windows within a frame, the grid layout is skipped.
Mod=$Mod4
hc keybind $Mod-space                                                           \
            or , and . compare tags.focus.curframe_wcount = 2                   \
                     . cycle_layout +1 vertical horizontal max vertical grid    \
               , cycle_layout +1

hc rename default "${tag_names[0]}" || true
for i in ${!tag_names[@]} ; do
    hc add "${tag_names[$i]}"
    key="${tag_keys[$i]}"
    if ! [ -z "$key" ] ; then
        hc keybind "$Mod-$key" use_index "$i"
        hc keybind "$Mod-Shift-$key" move_index "$i"
    fi
done


hc set tree_style '╾│ ├└╼─┐'
# hc set tree_style '⊙│ ├╰»─╮'

# unlock, just to be sure
hc unlock

# detect multiple monitors
hc detect_monitors

#	load statusbar panel
do_panel

# load on startup
startup_run
