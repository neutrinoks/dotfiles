# dotfiles

Personal Linux configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

**Built on:** Arch Linux (Hyprland / Wayland) — currently on Manjaro (nvim + zsh only)

---

## Configurations

### Active

| Package | Description |
|---------|-------------|
| `nvim` | NeoVim — lazy.nvim, full LSP setup, Telescope, Claude Code AI — [details](nvim/.config/nvim/README.md) |
| `zsh` | Zsh shell — aliases, NVM, SSH agent auto-start |

### Archived

Configs created during the Arch Linux / Hyprland setup — kept as reference.

| Package | Description |
|---------|-------------|
| `alacritty` | Terminal emulator — Hack Nerd Font |
| `hypr` | Hyprland compositor — dwindle layout, blur, animations, idle/lock/wallpaper |
| `kitty` | Terminal emulator (primary) |
| `starship` | Shell prompt — Catppuccin Frappé palette, powerline style |
| `uwsm` | UWSM environment variables for Hyprland |
| `walker` | Application launcher — with AI (Claude) integration |
| `wallpapers` | Wallpapers used by hyprpaper |
| `waybar` | Status bar — workspaces, system stats, network, battery, power menu |

## Theme

All components are styled with [Catppuccin](https://github.com/catppuccin/catppuccin):

- **Dark** — Frappé
- **Light** — Latte (NeoVim switches automatically based on the system setting)

## Installation

**Requirements:** [GNU Stow](https://www.gnu.org/software/stow/), [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts), Hyprland + UWSM

```sh
git clone https://github.com/neutrinoks/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow a single package
stow nvim

# Or stow everything at once
stow alacritty hypr kitty nvim starship uwsm walker wallpapers waybar zsh
```

> Remove or back up any existing config files first to avoid stow conflicts.
