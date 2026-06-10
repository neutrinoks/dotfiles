return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git / format" },
            { "<leader>x", group = "trouble" },
            { "<leader>c", group = "claude" },
            { "<leader>d", group = "dark scheme" },
            { "<leader>l", group = "light scheme" },
        }
    }
}
