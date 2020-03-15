#!/usr/bin/env bash

# tags
tag_names=( {1..9} )
tag_keys=( {1..9} 0 )

function hc() {
    herbstclient "$@"
}


# if you have a super key you will be much happier with Mod set to Mod4
# Mod=Mod1    # Use alt as the main modifier
# Mod=Mod4   # Use the super key as the main modifier

# Modifier variables
s=Shift
c=Control
m=Mod4
a=Mod1
TERMINAL=urxvt

# resizing frames
resizestep=0.05

declare -A keybinds=(
  # session
	["$m-$s-q"]='quit'
	["$m-$s-r"]='reload'
	["$m-$s-c"]='close'

  # use your $TERMINAL
	["$m-Return"]="spawn $TERMINAL"

  # basic movement

  # focusing clients
	["$m-Left"]='focus left'
	["$m-Down"]='focus down'
	["$m-Up"]='focus up'
	["$m-Right"]='focus right'
	["$m-h"]='focus left'
	["$m-j"]='focus down'
	["$m-k"]='focus up'
	["$m-l"]='focus right'

  # moving clients
	["$m-$s-Left"]='shift left'
	["$m-$s-Down"]='shift down'
	["$m-$s-Up"]='shift up'
	["$m-$s-Right"]='shift right'
	["$m-$s-h"]='shift left'
	["$m-$s-j"]='shift down'
	["$m-$s-k"]='shift up'
	["$m-$s-l"]='shift right'

# splitting frames
# create an empty frame at the specified direction
	["$m-u"]='split bottom 0.5'
	["$m-o"]='split right 0.5'
# let the current frame explode into subframes
	["$m-$c-space"]='split explode'

# resizing frames
	["$m-$c-h"]="resize left +$resizestep"
	["$m-$c-j"]="resize down +$resizestep"
	["$m-$c-k"]="resize up +$resizestep"
	["$m-$c-l"]="resize right +$resizestep"
	["$m-$c-Left"]="resize left +$resizestep"
	["$m-$c-Down"]="resize down +$resizestep"
	["$m-$c-Up"]="resize up +$resizestep"
	["$m-$c-Right"]="resize right +$resizestep"

	# Lock screen
	["$c-$a-l"]='spawn xtrlock -b'
)

declare -A tagskeybinds=(
  # cycle through tags
	["$m-period"]='use_index +1 --skip-visible'
	["$m-comma"]='use_index -1 --skip-visible'

  # layouting
	["$m-r"]='remove'
	["$m-s"]='floating toggle'
	["$m-f"]='fullscreen toggle'
	["$m-p"]='pseudotile toggle'

  # focus
	["$m-BackSpace"]='cycle_monitor'
	["$m-Tab"]='cycle_all +1'
	["$m-$s-Tab"]='cycle_all -1'
	["$m-c"]='cycle'
	["$m-i"]='jumpto urgent'
)

declare -A mousebinds=(
  # mouse
	["$m-Button1"]='move'
	["$m-Button2"]='zoom'
	["$m-Button3"]='resize'
)
declare -A sets=(
	["frame_border_active_color"]="$colGrey200"
	["frame_bg_active_color"]="$colYellow900"

	["frame_border_normal_color"]="$coGrey50"
	["frame_bg_normal_color"]="$colRed500"


	["frame_border_width"]='1'
	["always_show_frame"]='1'
	["frame_bg_transparent"]='1'
	["frame_transparent_width"]='5'
	["frame_gap"]='4'

	["window_gap"]='0'
	["frame_padding"]='0'
	["smart_window_surroundings"]='0'
	["smart_frame_surroundings"]='1'
	["mouse_recenter_gap"]='0'
)

declare -A attributes=(
	["theme.tiling.reset"]='1'
	["theme.floating.reset"]='1'

	["theme.active.color"]="$colRed500"
	["theme.normal.color"]="$colGrey200"
	["theme.urgent.color"]="$colPink500"

	["theme.inner_width"]='1'
	["theme.inner_color"]='black'

	["theme.border_width"]='3'
	["theme.floating.border_width"]='4'
	["theme.floating.outer_width"]='1'
	["theme.floating.outer_color"]='black'

	["theme.active.inner_color"]='#3E4A00'
	["theme.active.outer_color"]='#3E4A00'
	["theme.background_color"]='#141414'
)

declare -A rules=(
  # normally focus new clients
	["focus=on"]=''

  # zero based array
	# ["class=Firefox"]="tag=${tag_names[1]}"
	# ["class=Chromium"]="tag=${tag_names[1]}"
	# ["class=Geany"]="tag=${tag_names[2]}"
	# ["class=Thunar"]="tag=${tag_names[3]}"
	# ["class=gimp"]="tag=${tag_names[4]} pseudotile=on"


	# ["class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)'"]='focus=on'

  ["windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)'"]='pseudotile=on'
  ["windowtype='_NET_WM_WINDOW_TYPE_DIALOG'"]='focus=on'
	# ["windowtype='_NET_WM_WINDOW_TYPE_DIALOG'"]='fullscreen=on'
  ["windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)'"]='manage=off'
)

# GIMP
# ensure there is a GIMP tag
hc add gimp
hc load gimp '
(split horizontal:0.850000:0
(split horizontal:0.200000:1
(clients vertical:0)
(clients grid:0))
(clients vertical:0))'
# load predefined layout
# center all other gimp windows on gimp tag
hc rule class=Gimp tag=gimp index=01 pseudotile=on
hc rule class=Gimp windowrole~'gimp-(image-window|toolbox|dock)' pseudotile=off
hc rule class=Gimp windowrole=gimp-toolbox focus=off index=00
hc rule class=Gimp windowrole=gimp-dock focus=off index=1


# rules
# hc unrule -F
# hc rule class=VirtualBox tag=8 # move all VMs to tag 8
# hc rule title='Oracle VM VirtualBox Manager' tag=8
# hc rule class=VirtualBox pseudotile=on
# hc rule class=VirtualBox fullscreen=on
