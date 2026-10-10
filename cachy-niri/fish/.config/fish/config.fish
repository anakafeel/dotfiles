source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting: fastfetch with random art every terminal
function fish_greeting
    ~/.local/bin/random_fastfetch.sh
end
