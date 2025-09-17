return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        -- Auto-select colorscheme based on system preference
        if vim.o.background == "dark" then
            vim.cmd.colorscheme "catppuccin-frappe"
        else
            vim.cmd.colorscheme "catppuccin-latte"
        end
    end
}
