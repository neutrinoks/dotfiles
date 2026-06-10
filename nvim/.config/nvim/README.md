# NeoVim Configuration

My personal NeoVim configuration, built on [lazy.nvim](https://github.com/folke/lazy.nvim) and
inspired by typecraft's [video series](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn).

## Plugins

| Category | Plugin(s) |
|----------|-----------|
| Tab bar | `romgrk/barbar.nvim` |
| Status bar | `nvim-lualine/lualine.nvim` |
| File explorer | `nvim-neo-tree/neo-tree.nvim` |
| Color scheme | `catppuccin/nvim` |
| Syntax / AST | `nvim-treesitter/nvim-treesitter` |
| Completion & snippets | `hrsh7th/nvim-cmp`, `L3MON4D3/LuaSnip`, `rafamadriz/friendly-snippets` |
| LSP | `neovim/nvim-lspconfig`, `williamboman/mason.nvim`, `williamboman/mason-lspconfig.nvim` |
| Formatting & linting | `nvimtools/none-ls.nvim` |
| Fuzzy finding | `nvim-telescope/telescope.nvim` |
| Diagnostics | `folke/trouble.nvim` |
| Git signs | `lewis6991/gitsigns.nvim` |
| Git conflicts | `akinsho/git-conflict.nvim` |
| Dark/light mode | `f-person/auto-dark-mode.nvim` |
| Auto pairs | `windwp/nvim-autopairs` |
| Keymap hints | `folke/which-key.nvim` |
| AI assistant | `greggh/claude-code.nvim` |

### LSP Servers

Installed and managed via Mason: `ast_grep`, `bashls`, `html`, `lua_ls`, `phpactor`, `pyright`,
`rust_analyzer`, `svelte`, `vtsls` (TypeScript / JavaScript).

## Shortcuts & Keybindings

> `<leader>` = `Space`

### Global

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Ctrl+s` | Normal | Save file |
| `Ctrl+q` | Normal | Quit |
| `Ctrl+q` | Insert | Exit insert mode |
| `Space dd` | Normal | Switch to dark scheme (Catppuccin Frappé) |
| `Space ll` | Normal | Switch to light scheme (Catppuccin Latte) |

### Barbar – Tab Bar

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Alt+,` | Normal / Insert | Previous buffer |
| `Alt+.` | Normal / Insert | Next buffer |
| `Alt+<` | Normal | Move buffer left |
| `Alt+>` | Normal | Move buffer right |
| `Ctrl+w` | Normal | Close buffer |

### Neo-tree – File Explorer

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Ctrl+m` | Normal | Open / reveal current file in explorer |
| `Enter` / `o` | Normal (tree) | Open file or toggle folder |
| `a` | Normal (tree) | Add file or directory |
| `d` | Normal (tree) | Delete file or directory |
| `r` | Normal (tree) | Rename |
| `y` | Normal (tree) | Copy to clipboard |
| `x` | Normal (tree) | Cut to clipboard |
| `p` | Normal (tree) | Paste from clipboard |
| `H` | Normal (tree) | Toggle hidden files |
| `/` | Normal (tree) | Fuzzy search |
| `q` | Normal (tree) | Close explorer |
| `?` | Normal (tree) | Show help |

### Telescope – Fuzzy Finder

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Space ff` | Normal | Find files |
| `Space fg` | Normal | Live grep |
| `Space fb` | Normal | List open buffers |
| `Ctrl+n` / `Ctrl+j` | Picker | Next item |
| `Ctrl+p` / `Ctrl+k` | Picker | Previous item |
| `Enter` | Picker | Open selection |
| `Ctrl+v` | Picker | Open in vertical split |
| `Ctrl+x` | Picker | Open in horizontal split |
| `Ctrl+t` | Picker | Open in new tab |
| `Ctrl+q` | Picker | Send to quickfix list |
| `Esc` | Picker | Close picker |

### LSP

| Shortcut | Mode | Description |
|----------|------|-------------|
| `K` | Normal | Hover documentation |
| `gd` | Normal | Go to definition |
| `gi` | Normal | Go to implementation |
| `Space ca` | Normal / Visual | Code actions |
| `Space gf` | Normal | Format buffer |
| `Space e` | Normal | Show line diagnostics |

### Trouble – Diagnostics

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Space xx` | Normal | Toggle diagnostics panel |
| `Space xr` | Normal | Show LSP references |

### nvim-cmp – Completion

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Ctrl+Space` | Insert | Trigger completion |
| `Enter` | Insert | Confirm selection |
| `Ctrl+e` | Insert | Abort completion |
| `Ctrl+n` / `Ctrl+p` | Insert | Navigate suggestions |
| `Ctrl+b` / `Ctrl+f` | Insert | Scroll documentation |

### Treesitter – Incremental Selection

| Shortcut | Mode | Description |
|----------|------|-------------|
| `gnn` | Normal | Start node selection |
| `grn` | Visual | Expand to next node |
| `grc` | Visual | Expand to scope |
| `grm` | Visual | Shrink selection |

### Gitsigns

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Space gd` | Normal | Preview hunk |

### Git Conflict

| Shortcut | Mode | Description |
|----------|------|-------------|
| `co` | Normal | Choose ours |
| `ct` | Normal | Choose theirs |
| `cb` | Normal | Choose both |
| `c0` | Normal | Choose none |
| `]x` | Normal | Next conflict |
| `[x` | Normal | Previous conflict |

### Claude Code – AI Assistant

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Ctrl+,` | Normal / Terminal | Toggle Claude Code panel |
| `Space cC` | Normal | Open with `--continue` (resume last conversation) |
| `Space cV` | Normal | Open with `--verbose` |
| `Ctrl+h/j/k/l` | Normal | Navigate between windows |
| `Ctrl+f` / `Ctrl+b` | Terminal | Scroll in Claude panel |

## Requirements

- **NeoVim 0.11+** — required for the native LSP API (`vim.lsp.config` / `vim.lsp.enable`)
- **Nerd Font** — required for icons (configured: Hack Nerd Font; see [below](#using-another-nerd-font))
- **ripgrep** — required by Telescope for live grep

## Installation

This configuration is part of a [dotfiles](https://github.com/neutrinoks/dotfiles) repository
managed with [GNU Stow](https://www.gnu.org/software/stow/).

**1. Install requirements**

```sh
# Arch / Manjaro
sudo pamac install neovim ripgrep
```

**2. Install a Nerd Font**

Download [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip)
and place the `.ttf` files in `~/.local/share/fonts/`, then run `fc-cache -fv`.

**3. Clone the dotfiles repo and stow**

```sh
git clone https://github.com/neutrinoks/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Remove any existing NeoVim config to avoid stow conflicts
rm -rf ~/.config/nvim

stow nvim
```

**4. First launch**

Open NeoVim — lazy.nvim will bootstrap itself and install all plugins automatically. Once
finished, restart NeoVim. Mason will prompt to install the LSP servers on first use.

## Using Another Nerd Font

Change the font name in `lua/global.lua`:

```lua
vim.opt.guifont = "Hack Nerd Font"
```
