//!/usr/bin/env node
'use strict';

const colors = require('./color');

const tags = {
    1: 'DEV',
    2: 'DOCKER',
    3: 'SYS',
    4: 'DOC',
    5: 'WWW',
    6: 'TEST',
    7: 'MEDIA',
    8: 'VMAN',
    9: 'HOMELAB',
};

const terminal = 'alacritty';
const dmenuPrompt = 'Run: ';

const s = 'Shift';
const c = 'Control';
const m = 'Mod4';
const a = 'Mod1';

const resizestep = 0.05;
// change volume
const volumestep = '5%';
// room for bar
const barHeight = '25';

const config = {
    keybind: {
        // session
        [m + '-' + s + '-q']: 'quit',
        [m + '-' + s + '-r']: 'reload',
        [m + '-' + s + '-c']: 'close',
        // terminal
        // [m + '-Return']: 'spawn ' + terminal,
        // dmenu
        // [m + '-' + s + '-' + 'Return']: `spawn dmenu_run -p ${dmenuPrompt}`,
        // volume
        // 'XF86AudioRaiseVolume': `spawn amixer -M set Master ${volumestep}+`,
        // 'XF86AudioLowerVolume': `spawn amixer -M set Master ${volumestep}-`,
        // 'XF86AudioMute': 'spawn amixer -c 0 set Master toggle',
        // basic movement
        // focusing clients
        [m + '-Left']: 'focus left',
        [m + '-Down']: 'focus down',
        [m + '-Up']: 'focus up',
        [m + '-Right']: 'focus right',
        [m + '-h']: 'focus left',
        [m + '-j']: 'focus down',
        [m + '-k']: 'focus up',
        [m + '-l']: 'focus right',
        // moving clients
        [m + '-' + s + '-Left']: 'shift left',
        [m + '-' + s + '-Down']: 'shift down',
        [m + '-' + s + '-Up']: 'shift up',
        [m + '-' + s + '-Right']: 'shift right',
        [m + '-' + s + '-h']: 'shift left',
        [m + '-' + s + '-j']: 'shift down',
        [m + '-' + s + '-k']: 'shift up',
        [m + '-' + s + '-l']: 'shift right',
        // splitting frames
        // create an empty frame at the specified direction
        [m + '-u']: 'split   bottom  0.5',
        [m + '-o']: 'split   right   0.5',
        // let the current frame explode into subframes
        [m + '-' + c + '-space']: 'split explode',
        // resizing frames
        [m + '-' + c + '-h']: `resize left  +${resizestep}`,
        [m + '-' + c + '-j']: `resize down  +${resizestep}`,
        [m + '-' + c + '-k']: `resize up    +${resizestep}`,
        [m + '-' + c + '-l']: `resize right +${resizestep}`,
        [m + '-' + c + '-Left']: `resize left  +${resizestep}`,
        [m + '-' + c + '-Down']: `resize down  +${resizestep}`,
        [m + '-' + c + '-Up']: `resize up    +${resizestep}`,
        [m + '-' + c + '-Right']: `resize right +${resizestep}`,
        // cycle through tags
        [m + '-period']: 'use_index +1 --skip-visible',
        [m + '-comma']: 'use_index -1 --skip-visible',
        // layouting
        [m + '-r']: 'remove',
        [m + '-s']: 'floating toggle',
        [m + '-f']: 'fullscreen toggle',
        [m + '-p']: 'pseudotile toggle',
        [m + '-space']: 'or , and . compare tags.focus.curframe_wcount = 2 \
                   . cycle_layout +1 vertical horizontal max vertical grid \
                   , cycle_layout +1',
        // focus
        [m + '-BackSpace']: 'cycle_monitor',
        [m + '-Tab']: 'cycle_all +1',
        [m + '-' + s + '-Tab']: 'cycle_all -1',
        [m + '-c']: 'cycle',
        [m + '-i']: 'jumpto urgent',
    },
    mousebind: {
        [m + '-Button1']: 'move',
        [m + '-Button2']: 'zoom',
        [m + '-Button3']: 'resize',
    },
    attr: {
        // 'theme.tiling.reset': '1',
        // 'theme.floating.reset': '1',
        'theme.active.color': `"${colors.cyan}"`,
        'theme.normal.color': `"${colors.mediumGrey}"`,
        'theme.urgent.color': `"${colors.orange}"`,
        'theme.inner_width': '1',
        'theme.inner_color': `"${colors.black}"`,
        'theme.border_width': '3',
        'theme.floating.border_width': '4',
        'theme.floating.outer_width': '1',
        'theme.active.inner_color': `"${colors.cyan}"`,
        'theme.active.outer_color': `"${colors.cyan}"`,
        'theme.background_color': `"${colors.black}"`,
    },
    set: {
        'frame_border_active_color': `"${colors.darkGrey}"`,
        'frame_bg_active_color': `"${colors.cyan}"`,
        'frame_border_normal_color': `"${colors.darkGrey}"`,
        'frame_bg_normal_color': `"${colors.mediumGrey}"`,
        'frame_border_width': '1',
        'always_show_frame': '1',
        'frame_bg_transparent': '1',
        'frame_transparent_width': '5',
        'frame_gap': '4',
        'window_gap': '0',
        'frame_padding': '0',
        'smart_window_surroundings': '0',
        'smart_frame_surroundings': '1',
        'mouse_recenter_gap': '0',
    },
    rule: {
        // normally focus new clients
        'focus=on': '',
        // "class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)'": 'focus=on',
        "windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)'": 'pseudotile=on',
        "windowtype='_NET_WM_WINDOW_TYPE_DIALOG'": 'focus=on',
        "windowtype='_NET_WM_WINDOW_TYPE_DIALOG'": 'fullscreen=on',
        // "windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)'": 'manage=off',
    },
    pad: {
        0: `${barHeight}`,
        1: `${barHeight}`,
    }
};

module.exports = { tags, config };
