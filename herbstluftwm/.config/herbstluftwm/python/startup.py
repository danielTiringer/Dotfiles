import os


def start_panel():
    os.system('$XDG_CONFIG_HOME/polybar/launch.sh mainbar-herbst &')


def start_applications():
    command = 'silent new_attr bool my_not_first_autostart'
    exitcode = os.system('herbstclient ' + command)

    if exitcode == 0:
        os.system('picom &')
        os.system('feh --no-fehbg --bg-scale "$HOME/Pictures/dark-leaves.jpg" &')
        os.system('sxhkd -c $XDG_CONFIG_HOME/sxhkd/common_sxhkdrc &')
