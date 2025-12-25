return {
    {
        "williamboman/mason.nvim",
        config = function()
            vim.lsp.config("mason", {})
            vim.lsp.enable("mason")
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            vim.lsp.config("mason-lspconfig", {
                ensure_installed = {
                    "ast_grep",
                    "bashls",
                    "html",
                    "lua_ls",
                    "phpactor",
                    "pyright",
                    "rust_analyzer",
                    "vtsls"
                }
            })
            vim.lsp.enable("mason-lspconfig")
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config("ast_grep", { capabilities = capabilities })
            vim.lsp.config("bashls", { capabilities = capabilities })
            vim.lsp.config("html", { capabilities = capabilities })
            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.config("phpactor", { capabilities = capabilities })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("rust_analyzer", { capabilities = capabilities })

            vim.lsp.enable("ast_grep")
            vim.lsp.enable("bashls")
            vim.lsp.enable("html")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("phpactor")
            vim.lsp.enable("pyright")
            vim.lsp.enable("rust_analyzer")
        end
    }
}
