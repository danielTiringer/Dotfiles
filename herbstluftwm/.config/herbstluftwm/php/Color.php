<?php

class Color
{
    const COLORS = [
        'lightGrey' => '#abb2bf',
        'mediumGrey' => '#565656',
        'darkGrey' => '#282c34',

        // solarized-dark colors
        'yellow' => '#b58900',
        'orange' => '#cb4b16',
        'red' => '#dc322f',
        'magenta' => '#d33682',
        'violet' => '#6c71c4',
        'blue' => '#268bd2',
        'cyan' => '#2aa198',
        'green' => '#859900',
        'black' => '#000000',
        'white' => '#ffffff',
    ];

    public function getColor(string $color): string
    {
        return self::COLORS[$color];
    }
}