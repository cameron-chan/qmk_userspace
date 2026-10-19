# Cameron’s Sofle keymap

![Cameron’s Sofle keymap](keymap.svg)

Features:

-   Symmetric modifiers (CMD/Super, Alt/Opt, Ctrl, Shift)
-   Various modes, can be switched (using Adjust layer and the selected one is stored in EEPROM.
-   Modes for Qwerty and Colemak support
-   Modes for Mac vs Linux/Win support -> different order of modifiers and different action shortcuts on the "UPPER" layer (the red one in the image). Designed to simplify transtions when switching between operating systems often.
-   The OLED on master half shows selected mode and caps lock state and is rotated.
-   Left encoder controls volume up/down/mute. Right encoder PGUP/PGDOWN.

# MY NOTES

https://config.qmk.fm/#/sofle/rev1/LAYOUT
https://docs.qmk.fm/#/newbs_building_firmware

-   folder name is km name inside this folder

qmk json2c map.json -o map.c

qmk compile -kb sofle/rev1 -km cameronchan
qmk flash -kb sofle/rev1 -km cameronchan

## Keymap diagram

Regenerate the diagram from the userspace root with:

```sh
./draw-keymap.sh keyboards/sofle/keymaps/cameronchan/map.json
```

You can also pass the directory containing `map.json` instead of the file path. The script requires `keymap-drawer` (`keymap` on `PATH`) and writes `keymap.svg` beside the source map without changing firmware files.
