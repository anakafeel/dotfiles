#!/usr/bin/env bash

# Pick a random logo for fastfetch from three sources - your own
# ascii/ collection, pokemon-colorscripts, and shell-color-scripts -
# and paste it beside the info panel ourselves (art left, info right).
#
# fastfetch's own side-by-side join (logo-position left + file/file-raw)
# doesn't correctly measure visible width for lines with heavy/variable
# ANSI truecolor escape codes (pokemon-colorscripts, several
# shell-color-scripts pieces): the module column lands at a different
# column on every row instead of lining up, because fastfetch's width
# count for raw logo lines gets thrown off by the escape bytes. So we
# don't use fastfetch's join at all - we capture the module panel text
# via `fastfetch --logo none`, measure each logo line's true visible
# width ourselves (ANSI stripped), and paste the two columns together
# by hand, padding every row out to the same fixed column.
#
# Centering logic is unchanged: reserve the info panel's own width plus
# a small gap, center the art in whatever's left, or left-align it
# (padding 0) if it doesn't fit. Art taller than the info panel is
# capped to the info panel's height instead of overflowing the terminal.

ASCII_DIR="$HOME/.config/fastfetch/ascii"
SHELL_COLORSCRIPTS_DIR="$HOME/.local/share/shell-color-scripts/colorscripts"
GAP=2
RESET=$'\033[0m'

strip_ansi() { sed -r 's/\x1b\[[0-9;]*[a-zA-Z]//g'; }
vis_width() { printf '%s' "$1" | strip_ansi | wc -m; }

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
        LOGO_CONTENT="$(cat "${LOCAL_LOGOS[RANDOM % ${#LOCAL_LOGOS[@]}]}")"
        ;;
    pokemon)
        LOGO_CONTENT="$(pokemon-colorscripts --no-title -r)"
        ;;
    shellcolor)
        LOGO_CONTENT="$("${COLORSCRIPTS[RANDOM % ${#COLORSCRIPTS[@]}]}")"
        ;;
esac

mapfile -t LOGO_LINES <<< "$LOGO_CONTENT"
mapfile -t INFO_LINES < <(fastfetch --logo none "$@")

LOGO_WIDTH=0
for line in "${LOGO_LINES[@]}"; do
    w=$(vis_width "$line")
    (( w > LOGO_WIDTH )) && LOGO_WIDTH=$w
done

INFO_WIDTH=0
for line in "${INFO_LINES[@]}"; do
    w=$(vis_width "$line")
    (( w > INFO_WIDTH )) && INFO_WIDTH=$w
done

COLS=$(tput cols 2>/dev/null)
[[ "$COLS" =~ ^[0-9]+$ ]] || COLS=80

AVAILABLE=$(( COLS - INFO_WIDTH - GAP ))
if (( AVAILABLE <= LOGO_WIDTH )); then
    PADDING_LEFT=0
else
    PADDING_LEFT=$(( (AVAILABLE - LOGO_WIDTH) / 2 ))
fi

TARGET_COL=$(( PADDING_LEFT + LOGO_WIDTH + GAP ))

ROWS=${#INFO_LINES[@]}
for (( i = 0; i < ROWS; i++ )); do
    logo_line="${LOGO_LINES[i]:-}"
    info_line="${INFO_LINES[i]:-}"
    logo_vis_width=$(vis_width "$logo_line")
    fill=$(( TARGET_COL - PADDING_LEFT - logo_vis_width ))
    (( fill < 0 )) && fill=0
    printf '%*s%s%s%*s%s\n' "$PADDING_LEFT" "" "$logo_line" "$RESET" "$fill" "" "$info_line"
done
