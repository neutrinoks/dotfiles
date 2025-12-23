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
        -- Auto-select colorscheme based on system preference
        if vim.o.background == "dark" then
            vim.cmd.colorscheme "catppuccin-frappe"
        else
            vim.cmd.colorscheme "catppuccin-latte"
        end
    end
}
