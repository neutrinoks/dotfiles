return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        autopairs.setup({})

        -- Automatically insert closing pair when accepting a cmp suggestion
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
}
