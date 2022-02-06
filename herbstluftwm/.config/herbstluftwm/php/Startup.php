<?php

class Startup
{
    private Color $color;

    public function __construct(Color $color)
    {
        $this->color = $color;
    }

    public function setBackground()
    {
        exec("xsetroot -solid {$this->color->getColor('blue')}");

    }

    public function startPanel()
    {
        exec(getenv('XDG_CONFIG_HOME') . '/polybar/launch.sh mainbar-herbst > /dev/null &');
    }

    public function startApplications()
    {
        exec('picom > /dev/null &');
        exec('feh --no-fehbg --bg-center ' . getenv('HOME') . '/Pictures/dark-leaves.jpg > /dev/null &');
        exec('sxhkd -c ' . getenv('XDG_CONFIG_HOME') . '/sxhkd/common_sxhkdrc > /dev/null &');
    }
}