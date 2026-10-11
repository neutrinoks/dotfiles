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

        local CLAUDE_THEME = "custom:catppuccin"

        -- Keeps Claude Code pinned to the custom theme; dark/light now lives inside the theme file.
        local function select_claude_theme()
            local path = vim.fn.expand("~/.claude/settings.json")
            local f = io.open(path, "r")
            if not f then return end
            local ok, settings = pcall(vim.json.decode, f:read("*a"))
            f:close()
            if not ok or settings.theme == CLAUDE_THEME then return end
            settings.theme = CLAUDE_THEME
            local out = io.open(path, "w")
            if not out then return end
            out:write(vim.json.encode(settings))
            out:close()
        end

        -- Writes ~/.claude/themes/catppuccin.json: Claude's own preset as base, Catppuccin on top.
        -- Claude Code watches that folder and re-renders a running session on change.
        -- `bg` is the Claude window background (nil = p.base); `lifted` moves message surfaces one step up
        -- so they stay visible on a background lighter than p.base.
        local function write_claude_theme(flavour, base, bg, lifted)
            local p = require("catppuccin.palettes").get_palette(flavour)
            local blend = require("catppuccin.utils.colors").blend
            bg = bg or p.base
            local s0, s1, s2 = p.surface0, p.surface1, p.surface2
            if lifted then s0, s1, s2 = p.surface1, p.surface2, p.surface2 end
            local theme = {
                name = "Catppuccin",
                base = base,
                overrides = {
                    claude = p.peach,
                    claudeShimmer = p.rosewater,
                    text = p.text,
                    inverseText = p.base,
                    inactive = p.overlay1,
                    inactiveShimmer = p.overlay2,
                    subtle = p.surface2,
                    suggestion = p.blue,
                    permission = p.lavender,
                    permissionShimmer = p.blue,
                    remember = p.sapphire,
                    success = p.green,
                    error = p.red,
                    warning = p.yellow,
                    warningShimmer = p.peach,
                    merged = p.mauve,
                    promptBorder = p.overlay0,
                    promptBorderShimmer = p.overlay1,
                    planMode = p.teal,
                    autoAccept = p.mauve,
                    bashBorder = p.pink,
                    ide = p.blue,
                    -- Blend strengths keep p.text at ~4:1 or better on every diff background.
                    diffAdded = blend(p.green, bg, 0.18),
                    diffRemoved = blend(p.red, bg, 0.18),
                    diffAddedDimmed = blend(p.green, bg, 0.10),
                    diffRemovedDimmed = blend(p.red, bg, 0.10),
                    diffAddedWord = blend(p.green, bg, 0.28),
                    diffRemovedWord = blend(p.red, bg, 0.28),
                    userMessageBackground = s0,
                    userMessageBackgroundHover = s1,
                    bashMessageBackgroundColor = s0,
                    memoryBackgroundColor = s0,
                    selectionBg = s2,
                    rate_limit_fill = p.blue,
                    rate_limit_empty = p.surface1,
                    briefLabelYou = p.blue,
                    briefLabelClaude = p.peach,
                    red_FOR_SUBAGENTS_ONLY = p.red,
                    blue_FOR_SUBAGENTS_ONLY = p.blue,
                    green_FOR_SUBAGENTS_ONLY = p.green,
                    yellow_FOR_SUBAGENTS_ONLY = p.yellow,
                    purple_FOR_SUBAGENTS_ONLY = p.mauve,
                    orange_FOR_SUBAGENTS_ONLY = p.peach,
                    pink_FOR_SUBAGENTS_ONLY = p.pink,
                    cyan_FOR_SUBAGENTS_ONLY = p.teal,
                },
            }
            local dir = vim.fn.expand("~/.claude/themes")
            vim.fn.mkdir(dir, "p")
            -- Write-then-rename so the watcher never reads a half-written file.
            local path = dir .. "/catppuccin.json"
            local out = io.open(path .. ".tmp", "w")
            if not out then return end
            out:write(vim.json.encode(theme))
            out:close()
            os.rename(path .. ".tmp", path)
        end

        -- Must be registered BEFORE vim.cmd.colorscheme so it fires on the initial load too.
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                select_claude_theme()
                if vim.o.background == "dark" then
                    -- Claude's float uses ClaudeTermNormal (claude.lua); lifted above Frappé base.
                    local claude_bg = "#3d4157"
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { bg = claude_bg, fg = "#c6d0f5" })
                    write_claude_theme("frappe", "dark", claude_bg, true)
                    -- Background hint for other CLI tools in :terminal (read at their launch).
                    -- COLORFGBG format: "<fg-index>;<bg-index>" — 15;0 = white on black.
                    vim.env.COLORFGBG    = "15;0"
                    vim.env.TERM_BACKGROUND = "dark"

                    -- Full Catppuccin Frappé ANSI palette for terminals opened from now on.
                    vim.g.terminal_color_0  = "#51576d"   -- black   → Surface1
                    vim.g.terminal_color_1  = "#e78284"   -- red
                    vim.g.terminal_color_2  = "#a6d189"   -- green
                    vim.g.terminal_color_3  = "#e5c890"   -- yellow
                    vim.g.terminal_color_4  = "#8caaee"   -- blue
                    vim.g.terminal_color_5  = "#f4b8e4"   -- magenta
                    vim.g.terminal_color_6  = "#81c8be"   -- cyan
                    vim.g.terminal_color_7  = "#b5bfe2"   -- white
                    vim.g.terminal_color_8  = "#626880"   -- bright black → Surface2
                    vim.g.terminal_color_9  = "#e78284"   -- bright red
                    vim.g.terminal_color_10 = "#a6d189"   -- bright green
                    vim.g.terminal_color_11 = "#e5c890"   -- bright yellow
                    vim.g.terminal_color_12 = "#8caaee"   -- bright blue
                    vim.g.terminal_color_13 = "#f4b8e4"   -- bright magenta
                    vim.g.terminal_color_14 = "#81c8be"   -- bright cyan
                    vim.g.terminal_color_15 = "#c6d0f5"   -- bright white → Text
                else
                    vim.api.nvim_set_hl(0, "ClaudeTermNormal", { link = "NormalFloat" })
                    write_claude_theme("latte", "light", nil, false)
                    vim.env.COLORFGBG    = "0;15"
                    vim.env.TERM_BACKGROUND = "light"
                end
            end,
        })

        if vim.o.background == "dark" then
            vim.cmd.colorscheme "catppuccin-frappe"
        else
            vim.cmd.colorscheme "catppuccin-latte"
        end
    end
}
