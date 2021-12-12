#!/usr/bin/env bash

# tags

tag_names=( DEV DOCKER SYS DOC WWW TEST MEDIA VMAN HOMELAB )
tag_keys=( {1..9} 0 )

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# declarations

Terminal=alacritty
Editor=vim
dmenu_prompt='Run: '

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# keybindings

# Modifier variables
s=Shift
c=Control
m=Mod4
a=Mod1

# resizing frames
resizestep=0.05

# change volume
volumestep="5%"

# room for bar
bar_height="25"

declare -A keybinds=(
  # session
    ["$m-$s-q"]='quit'
    ["$m-$s-r"]='reload'
    ["$m-$s-c"]='close'

  # use your $TERMINAL
    # ["$m-Return"]="spawn ${Terminal}"

  # dmenu
    # ["$m-$s-Return"]="spawn dmenu_run -p ${dmenu_prompt}"

  # volume
    # ["XF86AudioRaiseVolume"]="spawn amixer -M set Master ${volumestep}+"
    # ["XF86AudioLowerVolume"]="spawn amixer -M set Master ${volumestep}-"
    # ["XF86AudioMute"]='spawn amixer -c 0 set Master toggle'

  # screen brightness
    # XF86MonBrightnessUp on MPB is keybind 233
    # XF86MonBrightnessDown is keybind 232
    # ["XF86MonBrightnessUp"]="spawn xbacklight -inc 1000"
    # ["XF86MonBrightnessDown"]="spawn xbacklight -dec 1000"

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
    ["$m-u"]='split   bottom  0.5'
    ["$m-o"]='split   right   0.5'
  # let the current frame explode into subframes
    ["$m-$c-space"]='split explode'

  # resizing frames
    ["$m-$c-h"]="resize left  +$resizestep"
    ["$m-$c-j"]="resize down  +$resizestep"
    ["$m-$c-k"]="resize up    +$resizestep"
    ["$m-$c-l"]="resize right +$resizestep"
    ["$m-$c-Left"]="resize left  +$resizestep"
    ["$m-$c-Down"]="resize down  +$resizestep"
    ["$m-$c-Up"]="resize up    +$resizestep"
    ["$m-$c-Right"]="resize right +$resizestep"
)

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# tags


declare -A tagskeybinds=(
  # cycle through tags
    ["$m-period"]='use_index +1 --skip-visible'
    ["$m-comma"]='use_index -1 --skip-visible'

  # layouting
    ["$m-r"]='remove'
    ["$m-s"]='floating toggle'
    ["$m-f"]='fullscreen toggle'
    ["$m-p"]='pseudotile toggle'
    ["$m-space"]='or , and . compare tags.focus.curframe_wcount = 2 \
               . cycle_layout +1 vertical horizontal max vertical grid \
               , cycle_layout +1'

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

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# theme

declare -A attributes=(
    # ["theme.tiling.reset"]=1
    # ["theme.floating.reset"]=1

    ["theme.active.color"]="${color['cyan']}"
    ["theme.normal.color"]="${color['medium_grey']}"
    ["theme.urgent.color"]="${color['orange']}"

    ["theme.inner_width"]='1'
    ["theme.inner_color"]="${color['black']}"

    ["theme.border_width"]='3'
    ["theme.floating.border_width"]='4'
    ["theme.floating.outer_width"]='1'
    ["theme.floating.outer_color"]="${color['black']}"

    ["theme.active.inner_color"]="$color['cyan']"
    ["theme.active.outer_color"]="$color['cyan']"
    ["theme.background_color"]="$color['black']"
)

declare -A sets=(
    ["frame_border_active_color"]="$color['dark_grey']"
    ["frame_bg_active_color"]="${color['cyan']}"

    ["frame_border_normal_color"]="${color['dark_grey']}"
    ["frame_bg_normal_color"]="${color['medium_grey']}"

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

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# rules

declare -A rules=(
  # normally focus new clients
    ["focus=on"]=''

    # ["class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)'"]='focus=on'

    # ["windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)'"]='pseudotile=on'
    ["windowtype='_NET_WM_WINDOW_TYPE_DIALOG'"]='focus=on'
    # ["windowtype='_NET_WM_WINDOW_TYPE_DIALOG'"]='fullscreen=on'
    # ["windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)'"]='manage=off'
)

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# pads

# room for polybar on both monitors
# hlwm padding is in the order of top, right, bottom, left, with the first number being the screen number
declare -A pads=(
    [0]="${bar_height}"
    [1]="${bar_height}"
)
