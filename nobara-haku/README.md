# nobara-haku

GNU Stow packages for the current Nobara Linux + Niri + hakuspace desktop setup.
Each subfolder is a Stow package whose internal path mirrors `$HOME`, so
stowing it symlinks the real config location back into this repo.

Older folders at the repo root (`FEDORA-WORKSTATION`, `caelestia`, `hypr`,
`hyprluna-configs`, `kitty`, `niri`, `noctalia-shell`, `waypaper`, `zsh`,
`.config`) are from previous setups and are unrelated to this folder.

## Packages

| Package | Symlinks to |
|---|---|
| `niri` | `~/.config/niri/` |
| `hakuspace-control` | `~/hakuspace-control/` |
| `waybar` | `~/.config/waybar/` |
| `rofi` | `~/.config/rofi/` |
| `swaync` | `~/.config/swaync/` |
| `kitty` | `~/.config/kitty/` |
| `zsh` | `~/.zshrc` |
| `fastfetch` | `~/.config/fastfetch/` |
| `local-bin` | hakuspace scripts in `~/.local/bin/` |

## Applying on a fresh machine

```bash
sudo dnf install stow
git clone git@github.com:anakafeel/dotfiles.git ~/linuxworkspace/dotfiles
cd ~/linuxworkspace/dotfiles
stow -d nobara-haku -t ~ niri hakuspace-control waybar rofi swaync kitty zsh fastfetch local-bin
```

`-t ~` is required since `nobara-haku` isn't a direct child of `$HOME`.

## Removing (unstow)

```bash
cd ~/linuxworkspace/dotfiles
stow -D -d nobara-haku -t ~ niri hakuspace-control waybar rofi swaync kitty zsh fastfetch local-bin
```
