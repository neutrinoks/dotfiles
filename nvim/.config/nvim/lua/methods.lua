local function darkscheme()
    vim.cmd.colorscheme "catppuccin-frappe"
end

local function brightscheme()
    vim.cmd.colorscheme "catppuccin-latte"
end

return {
    darkscheme = darkscheme,
    brightscheme = brightscheme,
}
