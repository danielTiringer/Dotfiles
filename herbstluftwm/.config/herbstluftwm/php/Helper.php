<?php

class Helper
{
    public function hc(string $arguments): void
    {
        exec('herbstclient ' . $arguments);
    }

    public function setTagsWithName(array $tags): void
    {
        $this->hc('rename default ' . $tags[1] . ' 2>/dev/null || true');

        foreach ($tags as $index => $value) {
            $this->hc("add  {$value}");
            $this->hc("keybind Mod4-{$index} use_index {$index}");
            $this->hc("keybind Mod4-Shift-{$index} move_index {$index}");
        }
    }

    public function configure(array $settings): void
    {
        foreach ($settings as $type => $setting) {
            foreach ($setting as $key => $command) {
                if (is_array($command)) {
                    foreach ($command as $item) {
                        $this->hc($type . ' ' . $key . ' ' . $item);

                    }
                } else {
                    $this->hc($type . ' ' . $key . ' ' . $command);
                }
            }
        }
    }
}