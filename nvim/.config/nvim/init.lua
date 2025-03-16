-- NEOVIM CONFIGURATION

-- Notes -------------------------------------------------------------------------------------------

-- Note: vim.cmd("set bla") == opt.bla =

-- for longer embedded vim-code:
-- vim.cmd [[
--      vim code goes here
-- ]]

-- inoremap: maps the key in insert mode / i in vim.keymap.set()
-- nnoremap: maps the key in normal mode / i in vim.keymap.set()
-- vnoremap: maps the key in visual mode / i in vim.keymap.set()
-- <C> : represents Control key
-- <A> : Alt key
-- <ESC> : Escape key


-- General Editor Settings -------------------------------------------------------------------------

require("global")
require("config.lazy")
require("lazy").setup("plugins")

local methods = require("methods")
local opts = { noremap = true, silent = true }

-- Global Shortcuts --------------------------------------------------------------------------------

-- Instant quit by Ctrl-q
vim.keymap.set("n", "<C-q>", vim.cmd.q, opts)
vim.keymap.set("i", "<C-q>", "<ESC>", opts)
-- Save file by: Ctrl-s
vim.keymap.set("n", "<C-s>", vim.cmd.w, opts)
-- Changing the color scheme
vim.keymap.set("n", "<leader>dd", methods.darkscheme, opts)
vim.keymap.set("n", "<leader>ll", methods.brightscheme, opts)


-- Telescope ---------------------------------------------------------------------------------------

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

-- Neo-tree ----------------------------------------------------------------------------------------

vim.keymap.set("n", "<C-m>", ":Neotree filesystem reveal left<CR>", opts)

-- LSP Interactions --------------------------------------------------------------------------------

vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)


-- Barbar ------------------------------------------------------------------------------------------

vim.keymap.set({'n','i'}, '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set({'n','i'}, '<A-.>', '<Cmd>BufferNext<CR>', opts)
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
vim.keymap.set('n', '<C-w>', '<Cmd>BufferClose<CR>', opts)

-- Gitsigns ----------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>gd", ":Gitsigns preview_hunk<CR>", opts)
