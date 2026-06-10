return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>f",  group = "find" },
            { "<leader>ff", desc = "Find Files" },
            { "<leader>fg", desc = "Live Grep" },
            { "<leader>fb", desc = "Buffers" },
            { "<leader>g",  group = "git / format" },
            { "<leader>gf", desc = "Format" },
            { "<leader>gd", desc = "Preview Hunk" },
            { "<leader>x",  group = "trouble" },
            { "<leader>c",  group = "claude / code action" },
            { "<leader>ca", desc = "Code Action" },
            { "<leader>d",  group = "dark scheme" },
            { "<leader>dd", desc = "Dark Scheme" },
            { "<leader>l",  group = "light scheme" },
            { "<leader>ll", desc = "Light Scheme" },
            { "<leader>e",  desc = "Show Diagnostics" },
        }
    }
}
