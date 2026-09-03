#!/usr/bin/env bash

# Pick a random logo for fastfetch from three sources - your own
# ascii/ collection, pokemon-colorscripts, and shell-color-scripts -
# positioned side-by-side (art left, info panel right) and sized to
# fit the current terminal.
#
# config.jsonc sets logo.position to "top", which always stacks art
# above the info panel regardless of padding - override it here.
#
# fastfetch has no width/height scaling for text/raw logos, so we
# can't shrink oversized art. Instead:
#   - measure the info panel's own rendered width each run (dynamic -
#     username, package counts, etc. shift it slightly)
#   - reserve that width plus a small gap on the right
#   - center the art in whatever's left; if it doesn't fit, left-align
#     it (padding 0) instead of centering something that doesn't fit
#   - cap vertical overflow with --logo-print-remaining false

ASCII_DIR="$HOME/.config/fastfetch/ascii"
SHELL_COLORSCRIPTS_DIR="$HOME/.local/share/shell-color-scripts/colorscripts"
GAP=2

strip_ansi() { sed -r 's/\x1b\[[0-9;]*[a-zA-Z]//g'; }

TMP_LOGO=""
cleanup() { [[ -n "$TMP_LOGO" ]] && rm -f "$TMP_LOGO"; }
trap cleanup EXIT

mapfile -t LOCAL_LOGOS < <(find "$ASCII_DIR" -maxdepth 1 -name '*.txt' -type f -size +0c 2>/dev/null)
mapfile -t COLORSCRIPTS < <(find "$SHELL_COLORSCRIPTS_DIR" -maxdepth 1 -type f -executable 2>/dev/null)

# Pick a source *category* first, not a flat pool of every file -
# otherwise shell-color-scripts' 50+ files and pokemon's 1000+ species
# would drown out your own hand-picked art.
SOURCES=()
[[ ${#LOCAL_LOGOS[@]} -gt 0 ]] && SOURCES+=("local")
command -v pokemon-colorscripts >/dev/null 2>&1 && SOURCES+=("pokemon")
[[ ${#COLORSCRIPTS[@]} -gt 0 ]] && SOURCES+=("shellcolor")

if [[ ${#SOURCES[@]} -eq 0 ]]; then
    exec fastfetch "$@"
fi

SOURCE="${SOURCES[RANDOM % ${#SOURCES[@]}]}"

case "$SOURCE" in
    local)
        LOGO="${LOCAL_LOGOS[RANDOM % ${#LOCAL_LOGOS[@]}]}"
        ;;
    pokemon)
        TMP_LOGO=$(mktemp)
        pokemon-colorscripts --no-title -r > "$TMP_LOGO"
        LOGO="$TMP_LOGO"
        ;;
    shellcolor)
        TMP_LOGO=$(mktemp)
        "${COLORSCRIPTS[RANDOM % ${#COLORSCRIPTS[@]}]}" > "$TMP_LOGO"
        LOGO="$TMP_LOGO"
        ;;
esac

COLS=$(tput cols 2>/dev/null)
[[ "$COLS" =~ ^[0-9]+$ ]] || COLS=80

LOGO_WIDTH=$(strip_ansi < "$LOGO" | wc -L)
INFO_WIDTH=$(fastfetch --logo none 2>/dev/null | strip_ansi | wc -L)
AVAILABLE=$(( COLS - INFO_WIDTH - GAP ))

if (( AVAILABLE <= LOGO_WIDTH )); then
    PADDING_LEFT=0
else
    PADDING_LEFT=$(( (AVAILABLE - LOGO_WIDTH) / 2 ))
fi

exec fastfetch \
    --logo-type file-raw --logo "$LOGO" \
    --logo-position left \
    --logo-padding-left "$PADDING_LEFT" \
    --logo-padding-right "$GAP" \
    --logo-print-remaining false \
    "$@"
