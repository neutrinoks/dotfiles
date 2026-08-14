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

        local function set_claude_theme(theme)
            local path = vim.fn.expand("~/.claude/settings.json")
            local f = io.open(path, "r")
            if not f then return end
            local ok, settings = pcall(vim.json.decode, f:read("*a"))
            f:close()
            if not ok or settings.theme == theme then return end
            settings.theme = theme
            local out = io.open(path, "w")
            if not out then return end
            out:write(vim.json.encode(settings))
            out:close()
        end

        -- Must be registered BEFORE vim.cmd.colorscheme so it fires on the initial load too.
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                if vim.o.background == "dark" then
                    set_claude_theme("dark")
                    -- Signal to Claude Code (and other CLI tools) that the terminal background
                    -- is dark. Without this, Claude Code may detect a "light" terminal and
                    -- render dark 24-bit text (#000…) that is invisible on Frappe's base.
                    -- COLORFGBG format: "<fg-index>;<bg-index>" — 15;0 = white on black.
                    vim.env.COLORFGBG    = "15;0"
                    vim.env.TERM_BACKGROUND = "dark"

                    -- Full Catppuccin Frappé ANSI palette — ensures palette-indexed colors
                    -- are readable. 24-bit explicit colors (Claude Code diffs) are addressed
                    -- via COLORFGBG above and the ClaudeTermNormal background lift below.
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

                    -- Fallback background lift for any residual dark 24-bit colors that
                    -- survive even after COLORFGBG hints the dark theme correctly.
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { bg = "#3d4157", fg = "#c6d0f5" })
                else
                    set_claude_theme("light")
                    vim.env.COLORFGBG    = "0;15"
                    vim.env.TERM_BACKGROUND = "light"
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", {})
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
