#!/usr/bin/env bash
# Floating tmux/nvim cheat sheet (companion to DMS's niri cheat sheet on Mod+/).
exec ghostty --gtk-single-instance=false --class=dev.cheatsheet.terminal \
    --title="Terminal Cheat Sheet" -e less -R -~ "$HOME/.local/share/cheatsheets/terminal.txt"
