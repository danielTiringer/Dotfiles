import os
import os.path

from config import tag_names, tag_keys


def hc(arguments):
    os.system("herbstclient "+arguments)


def configure(config):
    for command, details in config.items():
        for key, value in details.items():
            hc(command + ' ' + key + ' ' + value)


def set_tags_with_name():
    hc("rename default '" + str(tag_names[0]) + "' 2>/dev/null || true")

    for index, tag_name in enumerate(tag_names):
        hc("add '" + str(tag_names[index]) + "'")

        # uncomment to debug in terminal
        # print(index)

        key = tag_keys[index];
        if key:
            hc("keybind Mod4-" + str(key)
                + " use_index '" + str(index) + "'")
            hc("keybind Mod4-Shift-" + str(key)
                + " move_index '" + str(index) + "'")

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# miscellanous

# I don't understand what this is
def bind_cycle_layout():
    # The following cycles through the available layouts
    # within a frame, but skips layouts, if the layout change
    # wouldn't affect the actual window positions.
    # I.e. if there are two windows within a frame,
    # the grid layout is skipped.

    hc( "keybind Mod4-space " \
        "or , and . compare tags.focus.curframe_wcount = 2 " \
        ". cycle_layout +1 vertical horizontal max vertical grid " \
        ", cycle_layout +1 ")
