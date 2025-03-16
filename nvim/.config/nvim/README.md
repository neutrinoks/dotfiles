# NeoVim Configuration

This is my personal NeoVim configuration. It was completely refactored on March the 14th, 2025,
after getting totally inspired by typecraft and its [video series](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn).

### Current Plugin Setup

- Upper tab bar:
  `romgrk/barbar`
- Lower status bar:
  `nvim-lualine/lualine`
- File navigator:
  `nvim-neo-tree/neo-tree`
- Color schemes:
  `catppuccin/nvim`
- Tree sitter:
  `nvim-treesitter/nvim-treesitter`
- Auto completion and snippets: 
  `hrsh7th/cmp-nvim-lsp`, `L3MON4D3/LuaSnip`, `rafamadriz/friendly-snippets`, and `hrsh7th/nvim-cmp`
- LSP installtion & configuration:
  `williamboman/mason`, `williamboman/mason-lspconfig`, and `neovim/nvim-lspconfig`
- Formatting, linting:
  `nvimtools/none-ls`
- Fuzzy finding:
  `nvim-telescope/telescope`
- Git assistance:
  `lewis6991/gitsigns.nvim`

### Requirements

**Requirements need to be verified again, after refactoring it completely**

- NeoVim in version `0.9.0` is required!
- **Nerd Fonts** are required for nice display of icons (currently Cousine Nerd Font is configured,
  which is packed into this directory)
- Because **telescope** is included in this configuration, `ripgrep` package is required.

### Installation

- Step 1: Install requirements mentioned above
    - Install `ripgrep`, e.g.
      ```sh
      sudo apt install ripgrep
      ```
      ```sh
      sudo pamac install ripgrep
      ```
- Step 2: Install some Nerd Font of your choice (this config uses Cousine Nerd Font)
    - Cousine Nerd Font is available here: [Cousine Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Cousine.zip)
    - Extract and copy to your local TTF folder, e.g.
      ```sh
      unzip Cousine.zip
      sudo mv *.ttf /usr/share/fonts/TTF
      ```
      For using another Nerd Font, see [this section](#using-another-nerd-font).
- Step 3: Remove existing configurations completely, to avoid conflicts:
  ```sh
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  ```
- Step 4: Clone this repository and install VimPlug:
  ```sh
  git clone https://github.com/neutrinoks/nvim.git ~/.config/nvim
  ```
- Step 5: Restart to make all changes applied properly and wait until finished, restart again.

### Using another Nerd Font

If you want to use another Nerd Font, you have to specifiy it in `lua/global.lua` line 4, e.g.
```lua
opt.guifont = "Cousine Nerd Font"
```
or
```lua
opt.guifont = "Hack Nerd Font"
```
