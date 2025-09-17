return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    modes = {
      diagnostics = {
        mode = "diagnostics",
        win = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Diagnostics",
          title_pos = "center",
          position = { 0.5, 0.5 },
          size = { width = 0.8, height = 0.4 },
          zindex = 200,
        },
      },
      lsp_references = {
        mode = "lsp_references",
        win = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "LSP References",
          title_pos = "center",
          position = { 0.5, 0.5 },
          size = { width = 0.8, height = 0.4 },
          zindex = 200,
        },
      },
      quickfix = {
        mode = "quickfix",
        win = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Quickfix List",
          title_pos = "center",
          position = { 0.5, 0.5 },
          size = { width = 0.8, height = 0.4 },
          zindex = 200,
        },
      },
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0.5, 0.5 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
      cascade = {
        mode = "diagnostics", -- inherit from diagnostics mode
        filter = function(items)
          local severity = vim.diagnostic.severity.HINT
          for _, item in ipairs(items) do
            severity = math.min(severity, item.severity)
          end
          return vim.tbl_filter(function(item)
            return item.severity == severity
          end, items)
        end,
      },
    },
  },
  keys = {
    {
      "<leader>xr",
      "<cmd>Trouble lsp_references<cr>",
      desc = "LSP References",
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    -- {
    --   "<leader>xX",
    --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    --   desc = "Buffer Diagnostics (Trouble)",
    -- },
    -- {
    --   "<leader>cs",
    --   "<cmd>Trouble symbols toggle focus=false<cr>",
    --   desc = "Symbols (Trouble)",
    -- },
    -- {
    --   "<leader>cl",
    --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --   desc = "LSP Definitions / references / ... (Trouble)",
    -- },
    -- {
    --   "<leader>xL",
    --   "<cmd>Trouble loclist toggle<cr>",
    --   desc = "Location List (Trouble)",
    -- },
    -- {
    --   "<leader>xq",
    --   "<cmd>Trouble quickfix toggle<cr>",
    --   desc = "Quickfix List (Trouble)",
    -- },
  },
}
