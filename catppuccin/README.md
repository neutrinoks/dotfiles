# catppuccin

`catppuccin-sync` keeps [Claude Code](https://claude.com/claude-code) on Catppuccin and follows the
system's light/dark setting: **Latte** for light, **Frappé** for dark. It runs as a user service
(systemd on Linux, launchd on macOS), so the switch reaches every Claude Code session, also
those outside NeoVim.

## What it does

On start and on every light/dark switch it writes two themes into each Claude Code config dir
(`~/.claude` always, any other `~/.claude*` dir once it holds a `settings.json`, e.g. a second
account's):

| File | Used by | Background it is tuned for |
|------|---------|----------------------------|
| `themes/catppuccin.json` | Claude Code in a terminal (`"theme": "custom:catppuccin"` in `settings.json`) | Catppuccin base |
| `themes/catppuccin-nvim.json` | Claude Code in NeoVim's float, started with `--settings '{"theme":"custom:catppuccin-nvim"}'` | dark: `#3d4157`, light: Latte base (the float itself is on mantle) |

Claude Code watches its `themes/` folder and recolors running sessions immediately. A custom
Claude Code theme carries one fixed set of colors, so the light/dark switch has to happen by
rewriting the file. The service also keeps `settings.json` on `custom:catppuccin`. New config
dirs are picked up on the next switch or service restart.

Diff backgrounds are blended against the background each variant is tuned for. The dark NeoVim
variant moves message surfaces one step up, so they stay visible on the lighter float.

How the switch is detected:

- **Linux**: the XDG desktop portal's `org.freedesktop.appearance` `color-scheme` (an event, no
  polling). "No preference" counts as light, as in GNOME.
- **macOS**: `defaults read -g AppleInterfaceStyle`, checked every 2 seconds.

### GNOME Console

A Claude Code theme can't set the terminal's background. On GNOME, `install` therefore also adds
a Catppuccin livery to GNOME Console (Latte by day, Frappé by night, switched by Console itself)
and selects it, replacing the previous choice (`uninstall` returns Console to its default
livery). By night its ANSI colors match NeoVim's `:terminal` palette; by day they follow
Catppuccin's Latte terminal ports.

GNOME Console reads custom liveries from version 51.0 on. Version 50.0 fails to parse them
(`'(&sv)' has a type of '(sv)'` in the journal) and keeps its default colors until the update.

## Install

```sh
mkdir -p ~/.local/bin   # an existing dir keeps stow from linking all of ~/.local into the repo
cd ~/dotfiles
stow catppuccin
~/.local/bin/catppuccin-sync install
```

`install` writes and starts the user service (`~/.config/systemd/user/catppuccin-sync.service` or
`~/Library/LaunchAgents/local.catppuccin-sync.plist`) pointing at `~/.local/bin/catppuccin-sync`.
`catppuccin-sync uninstall` removes the service and the Console livery. `catppuccin-sync apply`
writes the themes once for the current setting.

Requirements: Python 3; on macOS the system's `/usr/bin/python3` (Command Line Tools), as
launchd's `PATH` doesn't include Homebrew. On Linux, `gdbus` and a desktop with the XDG desktop
portal; the Console livery uses PyGObject.

Logs: `journalctl --user -u catppuccin-sync` (Linux), `~/Library/Logs/catppuccin-sync.log` (macOS).
