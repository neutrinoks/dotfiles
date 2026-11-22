return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
    flavour = "auto",
      background = {
        light = "latte",
        dark = "frappe",
      },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)

        -- Must be registered BEFORE vim.cmd.colorscheme so it fires on the initial load too.
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                if vim.o.background == "dark" then
                    -- Claude's float uses ClaudeTermNormal (claude.lua); lifted above Frappé base.
                    -- catppuccin-sync (dotfiles package `catppuccin`) writes the matching Claude
                    -- theme for this background; keep its NVIM_FLOAT_BG_DARK in step.
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { bg = "#3d4157", fg = "#c6d0f5" })
                    -- Background hint for other CLI tools in :terminal (read at their launch).
                    -- COLORFGBG format: "<fg-index>;<bg-index>" — 15;0 = white on black.
                    vim.env.COLORFGBG    = "15;0"
                    vim.env.TERM_BACKGROUND = "dark"

                    -- Full Catppuccin Frappé ANSI palette for terminals opened from now on.
                    vim.g.terminal_color_0  = "#51576d"   -- black   → Surface1
                    vim.g.terminal_color_1  = "#e78284"   -- red
                    vim.g.terminal_color_2  = "#a6d189"   -- green
                    vim.g.terminal_color_3  = "#e5c890"   -- yellow
                    vim.g.terminal_color_4  = "#8caaee"   -- blue
                    vim.g.terminal_color_5  = "#f4b8e4"   -- magenta
                    vim.g.terminal_color_6  = "#81c8be"   -- cyan
                    vim.g.terminal_color_7  = "#b5bfe2"   -- white
                    vim.g.terminal_color_8  = "#626880"   -- bright black → Surface2
                    vim.g.terminal_color_9  = "#e78284"   -- bright red
                    vim.g.terminal_color_10 = "#a6d189"   -- bright green
                    vim.g.terminal_color_11 = "#e5c890"   -- bright yellow
                    vim.g.terminal_color_12 = "#8caaee"   -- bright blue
                    vim.g.terminal_color_13 = "#f4b8e4"   -- bright magenta
                    vim.g.terminal_color_14 = "#81c8be"   -- bright cyan
                    vim.g.terminal_color_15 = "#c6d0f5"   -- bright white → Text
                else
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { link = "NormalFloat" })
                    vim.env.COLORFGBG    = "0;15"
                    vim.env.TERM_BACKGROUND = "light"
                end
            end,
        })

        if vim.o.background == "dark" then
            vim.cmd.colorscheme "catppuccin-frappe"
        else
            vim.cmd.colorscheme "catppuccin-latte"
        end
    end
}
