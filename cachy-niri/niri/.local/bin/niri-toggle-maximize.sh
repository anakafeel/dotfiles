#!/bin/sh
# Mod+F: maximize-column only restores the width a column had before it was
# maximized, so a window that opened full width can't be shrunk with it.
# If the focused column already (nearly) fills the output, halve it instead.
win_w=$(niri msg -j focused-window | jq '.layout.tile_size[0] // 0')
out_w=$(niri msg -j focused-output | jq '.logical.width // 0')

if [ "$(echo "$win_w $out_w" | awk '{print ($2 > 0 && $1 >= $2 * 0.9)}')" = 1 ]; then
    niri msg action set-column-width "50%"
else
    niri msg action maximize-column
fi
