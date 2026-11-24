# dotfiles

Personal Linux configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

**Built on:** Arch Linux (Hyprland / Wayland) — currently on Manjaro (nvim + zsh only)

---

## Configurations

### Active

| Package | Description |
|---------|-------------|
| `nvim` | NeoVim — lazy.nvim, full LSP setup, Telescope, Claude Code AI — [details](nvim/.config/nvim/README.md) |
| `catppuccin` | Catppuccin Latte/Frappé for Claude Code (and GNOME Console), following the system's light/dark setting — [details](catppuccin/README.md) |
| `macos` | macOS-only bits — `us(altgr-intl)` keyboard layout, modifier-key mapping — [details](macos/README.md) |
| `wezterm` | WezTerm — macOS terminal with Linux/kitty-style keybindings (CTRL+SHIFT), left Option = Alt, right Option = AltGr |
| `zsh` | Zsh shell — Manjaro zsh config with powerline prompt, aliases, lazy-loaded NVM with `.nvmrc` auto-switch, 1Password SSH agent, Android SDK in `PATH`, sources an untracked `~/.zshrc.local` for machine-specific settings |

### Archived

Configs created during the Arch Linux / Hyprland setup — kept as reference.

| Package | Description |
|---------|-------------|
| `alacritty` | Terminal emulator — Hack Nerd Font |
| `hypr` | Hyprland compositor — dwindle layout, blur, animations, idle/lock/wallpaper |
| `kitty` | Terminal emulator — main terminal of the Hyprland setup |
| `starship` | Shell prompt — Catppuccin Frappé palette, powerline style |
| `uwsm` | UWSM environment variables for Hyprland |
| `walker` | Application launcher — with AI (Claude) integration |
| `wallpapers` | Wallpapers used by hyprpaper |
| `waybar` | Status bar — workspaces, system stats, network, battery, power menu |

## Theme

NeoVim and the archived Hyprland components are styled with [Catppuccin](https://github.com/catppuccin/catppuccin)
(the zsh prompt uses Manjaro's powerline prompt):

- **Dark** — Frappé
- **Light** — Latte

NeoVim and Claude Code both follow the system's dark/light setting. `catppuccin-sync` writes the
matching Catppuccin theme for [Claude Code](https://claude.com/claude-code) on every switch, with a
variant for the Claude Code float inside NeoVim — see the [catppuccin README](catppuccin/README.md).

## Installation

**Requirements:**

- [GNU Stow](https://www.gnu.org/software/stow/), [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- `nvim`: NeoVim 0.12+, ripgrep — see the [NeoVim README](nvim/.config/nvim/README.md#requirements)
- `catppuccin`: Python 3; on Linux a desktop with the XDG desktop portal (e.g. GNOME)
- `zsh`: `manjaro-zsh-config`, [nvm](https://github.com/nvm-sh/nvm) (optional), 1Password with SSH agent enabled

```sh
git clone https://github.com/neutrinoks/dotfiles.git
cd dotfiles

# Active setup
mkdir -p ~/.local/bin
stow nvim zsh catppuccin
~/.local/bin/catppuccin-sync install   # theme service, see catppuccin/README.md

# macOS only
stow wezterm
```

The archived packages additionally need Hyprland + UWSM and can be stowed individually,
e.g. `stow hypr waybar`.

The checkout can live anywhere: the repo's `.stowrc` sets the target to `~`, so run `stow` from
the repo root.

> Remove or back up any existing config files first to avoid stow conflicts.
