#!/usr/bin/env bash

# Pick a random ASCII art logo for fastfetch, positioned side-by-side
# (art left, info panel right) and sized to fit the current terminal.
#
# config.jsonc sets logo.position to "top", which always stacks art
# above the info panel regardless of padding - that's what was causing
# the stacked layout, not the padding math. Override it here.
#
# file-type ASCII logos have no width/height scaling in fastfetch
# (--logo-width/--logo-height only affect image logos), so we can't
# shrink oversized art. Instead:
#   - measure the info panel's own rendered width each run (it's
#     dynamic - username, package counts, etc. shift it slightly)
#   - reserve that width plus a small gap on the right
#   - center the art in whatever space is left; if it doesn't fit,
#     left-align it (padding 0) instead of centering something that
#     doesn't fit
#   - cap vertical overflow with --logo-print-remaining false, which
#     truncates the logo to the info panel's own line count instead of
#     spilling extra logo-only rows past the terminal

ASCII_DIR="$HOME/.config/fastfetch/ascii"
GAP=2

mapfile -t LOGOS < <(find "$ASCII_DIR" -maxdepth 1 -name '*.txt' -type f -size +0c)

if [[ ${#LOGOS[@]} -eq 0 ]]; then
    exec fastfetch "$@"
fi

LOGO="${LOGOS[RANDOM % ${#LOGOS[@]}]}"

COLS=$(tput cols 2>/dev/null)
[[ "$COLS" =~ ^[0-9]+$ ]] || COLS=80

LOGO_WIDTH=$(wc -L < "$LOGO")

INFO_WIDTH=$(fastfetch --logo none 2>/dev/null | sed -r 's/\x1b\[[0-9;]*[a-zA-Z]//g' | wc -L)

AVAILABLE=$(( COLS - INFO_WIDTH - GAP ))

if (( AVAILABLE <= LOGO_WIDTH )); then
    PADDING_LEFT=0
else
    PADDING_LEFT=$(( (AVAILABLE - LOGO_WIDTH) / 2 ))
fi

exec fastfetch \
    --logo-type file --logo "$LOGO" \
    --logo-position left \
    --logo-padding-left "$PADDING_LEFT" \
    --logo-padding-right "$GAP" \
    --logo-print-remaining false \
    "$@"
