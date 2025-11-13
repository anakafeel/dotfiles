# Hyprland Dotfiles 🎨
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
## 📸 Caelestia Dots 

| ![Screenshot 1](https://github.com/user-attachments/assets/9ef5ddd1-352b-4fc3-aea1-637be9721b6c) | ![Screenshot 2](https://github.com/user-attachments/assets/cd537fbb-a508-4466-a71d-2585c867fe31) | ![Screenshot 3](https://github.com/user-attachments/assets/1146fa79-6837-4f10-9d0e-a60d05530417) |
|:----------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------:|
| ![Screenshot 4](https://github.com/user-attachments/assets/b5f267ff-5358-43be-9727-601b222c6c9f) | ![Screenshot 5](https://github.com/user-attachments/assets/67f6bcc2-9e92-42ad-b46a-844e60229cb4) | ![Screenshot 6](https://github.com/user-attachments/assets/9e03f3e0-4c04-4768-84e5-4843f9be47c4) 

## 📸 Hyprluna  

| ![Screenshot 1](https://github.com/user-attachments/assets/e7f2d20f-686a-4c43-a579-b4993cefe405) | ![Screenshot 2](https://github.com/user-attachments/assets/0bf42d35-b212-4265-bf13-fd876456a633) | ![Screenshot 3](https://github.com/user-attachments/assets/e739a823-e53b-4f93-b0d0-d12ccfaf708a) |
|:----------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------:|
| ![Screenshot 4](https://github.com/user-attachments/assets/6d5e9244-3797-40aa-901c-2e4409ac5a2c) | ![Screenshot 5](https://github.com/user-attachments/assets/47c306e7-2647-48c7-839f-24839f3527b0) | ![Screenshot 6](https://github.com/user-attachments/assets/b33d15b7-2fac-429c-9eb6-6734a85a85af) 


----
## Vanilla Arch

| ![Screenshot 1](https://github.com/user-attachments/assets/04c014d9-7204-49b3-bd35-74b3f4683313) | ![Screenshot 2](https://github.com/user-attachments/assets/20d41a1a-c778-41d7-9772-7678424fe0e5) |
|---|---|

----
## 🔑 AstroNvim — Essential Keybindings

A quick reference for the most important **AstroNvim** keybindings used in my Neovim setup.  
These cover navigation, LSP, Git, terminals, debugging, testing, and fuzzy finding.
<img width="1910" height="1035" alt="image" src="https://github.com/user-attachments/assets/b5c434d3-9210-45df-ae00-f372f6900735" />


---

### 🚀 General

| Action | Keybinding |
|-------|------------|
| Open keymap helper | `<Space>fk` |
| Save file | `<Ctrl-s>` |
| Quit window | `<Space>q` |
| Close all buffers except current | `<Space>bo` |
| Toggle line diagnostics | `gl` |

---

### 📁 File Explorer (Neo-tree)

| Action | Keybinding |
|-------|------------|
| Toggle file tree | `<Space>e` |
| Focus file tree | `<Space>o` |
| Refresh tree | `R` (inside Neo-tree) |

---

### 🔍 Fuzzy Finding (Snacks Picker)

| Action | Keybinding |
|-------|------------|
| Find files | `<Space>ff` |
| Find all (including hidden) | `<Space>fF` |
| Live grep | `<Space>fw` |
| Open buffers | `<Space>fb` |
| Recent files | `<Space>fo` |

---

### 🧭 Navigation

| Action | Keybinding |
|-------|------------|
| Move between splits | `Ctrl + h/j/k/l` |
| Resize splits | `Ctrl + Arrow Keys` |
| Jump to definition | `gd` |
| Go to declaration | `gD` |
| List references | `grr` or `<Space>lR` |
| Rename symbol | `<Space>lr` |
| Hover documentation | `K` |

---

### 🧩 LSP Tools

| Action | Keybinding |
|-------|------------|
| Show symbols outline | `<Space>lS` |
| Format buffer | `<Space>lf` |
| Code actions | `<Space>la` |

---

### 💻 Terminal (ToggleTerm)

| Action | Keybinding |
|-------|------------|
| Floating terminal | `<Space>tf` |
| Horizontal terminal | `<Space>th` |
| Vertical terminal | `<Space>tv` |
| Lazygit terminal | `<Space>tl` |
| Toggle terminal | `Ctrl + '` or `F7` |

---

### 🐞 Debugging (nvim-dap)

| Action | Keybinding |
|-------|------------|
| Start / Continue | `<Space>dc` or `F5` |
| Toggle breakpoint | `<Space>db` or `F9` |
| Step over | `<Space>do` |
| Step into | `<Space>di` |
| Step out | `<Space>dO` |
| Open debug UI | `<Space>du` |
| Evaluate expression | `<Space>dE` |

---

### 🧪 Testing (Neotest)

| Action | Keybinding |
|-------|------------|
| Run nearest test | `<leader>tn` |
| Run test file | `<leader>tf` |
| Toggle test summary | `<leader>ts` |
| Open test output | `<leader>to` |

---

### 🌿 Git

| Action | Keybinding |
|-------|------------|
| Open Lazygit | `<Space>tl` or `<Space>gg` |
| Git commits | `<Space>gc` |
| Git status | `<Space>gt` |
| Git branches | `<Space>gb` |

---


