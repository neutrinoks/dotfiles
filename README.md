# dotfiles

Personal Linux configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

**Built on:** Arch Linux (Hyprland / Wayland) — currently on Manjaro (nvim + zsh only)

---

## Configurations

### Active

| Package | Description |
|---------|-------------|
| `nvim` | NeoVim — lazy.nvim, full LSP setup, Telescope, Claude Code AI — [details](nvim/.config/nvim/README.md) |
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

NeoVim follows the system's dark/light setting and passes it on to
[Claude Code](https://claude.com/claude-code): on every color scheme change it writes a matching
Catppuccin theme to `~/.claude/themes/catppuccin.json` and selects it (`custom:catppuccin`) in
`~/.claude/settings.json` — see the [NeoVim README](nvim/.config/nvim/README.md#theme--claude-code-integration).

## Installation

**Requirements:**

- [GNU Stow](https://www.gnu.org/software/stow/), [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- `nvim`: NeoVim 0.12+, ripgrep — see the [NeoVim README](nvim/.config/nvim/README.md#requirements)
- `zsh`: `manjaro-zsh-config`, [nvm](https://github.com/nvm-sh/nvm) (optional), 1Password with SSH agent enabled

```sh
git clone https://github.com/neutrinoks/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Active setup
stow nvim zsh
```

The archived packages additionally need Hyprland + UWSM and can be stowed individually,
e.g. `stow hypr waybar`.

> Remove or back up any existing config files first to avoid stow conflicts.
