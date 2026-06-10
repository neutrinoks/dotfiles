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
        -- Frappe maps terminal_color_0/8 to very dark surface colors (#51576d, #626880).
        -- Raises them to overlay shades that are readable on the base background (#303446).
        -- Also defines ClaudeTermNormal (surface1 bg) used by claude.lua's TermOpen autocmd
        -- for 24-bit/256-color text that terminal_color_N cannot reach.
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                if vim.o.background == "dark" then
                    vim.g.terminal_color_0 = "#838ba7"
                    vim.g.terminal_color_8 = "#949cbb"
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { bg = "#414559", fg = "#c6d0f5" })
                else
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
