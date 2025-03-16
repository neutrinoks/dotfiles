return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        -- Available flavours: latte, frappe, macciato, mocha
        local time = tonumber(os.date("%H"))
        if time < 9 or time > 16 then
            vim.cmd.colorscheme "catppuccin-frappe"
        else 
            vim.cmd.colorscheme "catppuccin-latte"
        end
    end
}
