return {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    tag = "0.1.8",
    requires = {
        "nvim-lua/plenary.nvim"
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
