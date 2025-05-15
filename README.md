# Hyprland Dotfiles 🎨
## 🚨 Shifting over to riced up [Hyprluna](https://hyprluna.org/)  🚨
This repository contains my configuration files (**dotfiles**) for customizing my **Hyprland** setup. I use **GNU Stow** for efficient management of dotfiles by leveraging symlinks, enabling a clean, modular, and centralized system.

----

## 🌟 Technologies Used

Here are the core tools and technologies powering this setup:

- **[Hyprland](https://github.com/hyprwm/Hyprland):** A dynamic Wayland compositor for efficient window management with tiling support.
- **[Waybar](https://github.com/Alexays/Waybar):** A highly customizable status bar for Wayland environments, providing real-time system stats and notification integration.
- **[Waypaper](https://github.com/DeKugelschieber/waypaper):** For setting wallpapers on Wayland.
- **[SDDM](https://github.com/sddm/sddm):** The display manager used to manage user logins/lock screens.
- **[Swanc](https://github.com/Alexander-Scott/swanc/):** A notification daemon for displaying clean and elegant system notifications.

----

## 🌟 Why Use GNU Stow?

[GNU Stow](https://www.gnu.org/software/stow/) helps manage dotfiles efficiently by using symlinks. Here’s why it’s essential for this setup:

- **Centralized Management:** Keep all dotfiles in one repository while maintaining the actual files in their expected system locations.
- **Portability:** Easily share your dotfiles or set them up on a new system.
- **Organized Home Directory:** Avoid clutter from scattered configuration files in `~/.config`.

[Check out this video](https://www.youtube.com/watch?v=y6XCebnB9gs&t=50s) for a quick introduction to GNU Stow!

----

## 🛠️ Initial Setup

To prepare the system for managing these dotfiles, a one-time **installation script** was executed, which helped:

- Install required dependencies, such as `Hyprland`, `Waybar`, `Waypaper`, and others.
- Setup relevant directories for wallpapers and configs.
- Download AUR packages with tools like `paru`.

You can find the installation script [here](https://github.com/GeodeArc/GeoDots/blob/main/install.sh).

----

## Screenshots 
![image](https://github.com/user-attachments/assets/04c014d9-7204-49b3-bd35-74b3f4683313)
![image](https://github.com/user-attachments/assets/20d41a1a-c778-41d7-9772-7678424fe0e5)


