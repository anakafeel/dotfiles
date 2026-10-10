# cachy-niri

GNU Stow packages for the current CachyOS + Niri + DankMaterialShell (DMS) setup.
Each subfolder is a Stow package whose internal path mirrors `$HOME`, and every
file is symlinked individually (`--no-folding`), so app-generated files
(DMS/matugen colors, backups, caches, third-party plugin clones) stay as real
files in `~/.config` and out of the repo.

Older folders at the repo root are from previous setups and are unrelated to this folder.

## Packages

| Package | Symlinks to |
|---|---|
| `niri` | `~/.config/niri/config.kdl`, `haku-binds.kdl`, `island-binds.kdl`, `dms/{binds,outputs,layout,alttab}.kdl` |
| `dms` | `~/.config/DankMaterialShell/` settings, plugin lockfile/settings, `island-mint` theme, `islandClock` plugin |
| `danksearch` | `~/.config/danksearch/config.toml` |
| `systemd` | `~/.config/systemd/user/` enablement links for `dms.service` and `dsearch.service` |
| `environment` | `~/.config/environment.d/` (DMS env, NVIDIA shader cache) |
| `portal` | `~/.config/xdg-desktop-portal/niri-portals.conf` |
| `hypr` | `~/.config/hypr/hyprlock.conf`, `hypridle.conf` |
| `fish` | `~/.config/fish/config.fish`, `auto-Niri.fish` |
| `fastfetch` | `~/.config/fastfetch/` + `~/.local/bin/random_fastfetch.sh` |
| `ghostty` | `~/.config/ghostty/config` |
| `kitty` | `~/.config/kitty/kitty.conf` |
| `alacritty` | `~/.config/alacritty/alacritty.toml` |
| `foot` | `~/.config/foot/foot.ini` |
| `tmux` | `~/.config/tmux/tmux.conf` (plugins installed by tpm: prefix + I) |
| `nvim` | `~/.config/nvim/` (LazyVim) |
| `cheatsheet` | `~/.local/bin/terminal-cheatsheet.sh`, `~/.local/share/cheatsheets/terminal.txt` |
| `theming` | GTK 3/4 `settings.ini`, Kvantum |
| `fuzzel` | `~/.config/fuzzel/` |
| `apps` | `chrome-flags.conf`, `code-flags.conf`, `mimeapps.list` |
| `mpv` | `~/.config/mpv/mpv.conf` |
| `autostart` | `~/.config/autostart/` Remembrance service |

Third-party DMS plugins aren't vendored; `dms/.../plugins.lock.json` pins their repos and commits.

## Applying on a fresh machine

```bash
sudo pacman -S stow
git clone git@github.com:anakafeel/dotfiles.git ~/linuxworkspace/dotfiles
cd ~/linuxworkspace/dotfiles
stow --no-folding -d cachy-niri -t ~ $(ls -d cachy-niri/*/ | xargs -n1 basename)
```

`-t ~` is required since `cachy-niri` isn't a direct child of `$HOME`.

## Removing (unstow)

```bash
cd ~/linuxworkspace/dotfiles
stow -D -d cachy-niri -t ~ $(ls -d cachy-niri/*/ | xargs -n1 basename)
```

## Notes

- Some apps save with an atomic rename (write temp file, then replace), which
  swaps the symlink for a regular file. If `git status` stops showing changes after
  editing settings in the DMS GUI, move the file back into the repo and re-link it.
- Not managed here: `/etc/nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json`
  (system file, sets `GLVidHeapReuseRatio = 0` for `niri`).
