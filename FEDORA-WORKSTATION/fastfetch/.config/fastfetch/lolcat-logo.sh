#!/bin/bash

# Get random ASCII art and display with lolcat
find ~/.config/fastfetch/ascii -name "*.txt" | shuf -n 1 | xargs cat | lolcat

echo ""

# Run fastfetch without logo
fastfetch --logo none