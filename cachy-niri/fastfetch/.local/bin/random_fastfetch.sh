#!/usr/bin/env bash

# Random art beside the fastfetch info panel, a different one every terminal.
#
# Sources (picked by category first so neither drowns out the other):
#   art    - curated pieces from DT's shell-color-scripts (space invaders,
#            pac-man, doom, tie fighters, ...). Pasted beside the panel by
#            hand, because fastfetch mis-measures the width of logo lines
#            full of ANSI escapes and the info column ends up ragged.
#   distro - one of fastfetch's ~500 built-in distro logos (it lays those
#            out fine on its own).
#
# Art wider than the space left over is stacked above the panel instead.

COLORSCRIPTS_DIR="$HOME/.local/share/shell-color-scripts/colorscripts"
GAP=2
RESET=$'\033[0m'

# The actual pictures - the rest of the repo is mostly palette/color tests.
ART=(
    arch bloks blocks2 crowns crunch crunchbang crunchbang-mini darthvader
    dna doom-original doom-outlined elfman faces ghosts guns illumina
    jangofett kaisen manjaro monster mouseface pacman pinguco rails rally-x
    space-invaders suckless tanks thebat thebat2 tiefighter1
    tiefighter1-no-invo tiefighter1row tiefighter2 tux xmonad
)

strip_ansi() { sed -r 's/\x1b(\[[0-9;?]*[a-zA-Z]|\([AB0])//g'; }
vis_width() { printf '%s' "$1" | strip_ansi | wc -m; }

AVAILABLE_ART=()
for name in "${ART[@]}"; do
    [[ -f "$COLORSCRIPTS_DIR/$name" ]] && AVAILABLE_ART+=("$name")
done

SOURCES=(distro)
(( ${#AVAILABLE_ART[@]} > 0 )) && SOURCES+=(art art)   # art 2/3 of the time

case "${SOURCES[RANDOM % ${#SOURCES[@]}]}" in
    distro)
        mapfile -t LOGOS < <(fastfetch --list-logos 2>/dev/null | grep -oP '^\d+\)\s+"\K[^"]+')
        if (( ${#LOGOS[@]} == 0 )); then
            exec fastfetch "$@"
        fi
        exec fastfetch --logo "${LOGOS[RANDOM % ${#LOGOS[@]}]}" --logo-position left "$@"
        ;;
esac

LOGO_CONTENT="$(bash "$COLORSCRIPTS_DIR/${AVAILABLE_ART[RANDOM % ${#AVAILABLE_ART[@]}]}")"

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

# Too wide to sit side by side: art on top (centered if it fits), panel below.
if (( LOGO_WIDTH + GAP + INFO_WIDTH > COLS )); then
    LOGO_PAD=0
    (( COLS > LOGO_WIDTH )) && LOGO_PAD=$(( (COLS - LOGO_WIDTH) / 2 ))
    for line in "${LOGO_LINES[@]}"; do
        printf '%*s%s%s\n' "$LOGO_PAD" "" "$line" "$RESET"
    done
    printf '%s\n' "${INFO_LINES[@]}"
    exit 0
fi

PADDING_LEFT=$(( (COLS - INFO_WIDTH - GAP - LOGO_WIDTH) / 2 ))
TARGET_COL=$(( PADDING_LEFT + LOGO_WIDTH + GAP ))

ROWS=${#INFO_LINES[@]}
(( ${#LOGO_LINES[@]} > ROWS )) && ROWS=${#LOGO_LINES[@]}
for (( i = 0; i < ROWS; i++ )); do
    logo_line="${LOGO_LINES[i]:-}"
    info_line="${INFO_LINES[i]:-}"
    fill=$(( TARGET_COL - PADDING_LEFT - $(vis_width "$logo_line") ))
    (( fill < 0 )) && fill=0
    printf '%*s%s%s%*s%s\n' "$PADDING_LEFT" "" "$logo_line" "$RESET" "$fill" "" "$info_line"
done
