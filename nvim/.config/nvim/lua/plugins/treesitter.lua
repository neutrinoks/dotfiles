return {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "bash", "c", "cpp", "css", "dart", "html", "json", "lua", "markdown", "markdown_inline",
                "php", "python", "rust", "solidity", "svelte", "typescript"
            },
            auto_install = true,
        })
    end
}
