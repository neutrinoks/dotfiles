-- WezTerm on macOS, tuned to feel like kitty/alacritty under Linux.
--
-- Two rules this config follows:
--   1) No binding uses CTRL alone -- every CTRL+<key> (C-d, C-u, C-w, C-r, ...)
--      goes straight to the shell / NeoVim, exactly like under Linux.
--      All terminal actions live on CTRL+SHIFT (kitty semantics) or CMD.
--   2) Left Option = Alt/Meta, right Option = AltGr (umlauts, ß).

local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ---------------------------------------------------------------- appearance
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 12.0
config.color_scheme = 'Catppuccin Frappe'
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.scrollback_lines = 10000

-- ----------------------------------------------------------------- keyboard
-- Let macOS compose dead keys, but only with the *right* Option key, so the
-- left Option stays a real Alt/Meta for readline and NeoVim.
config.use_ime = true
config.use_dead_keys = true
config.send_composed_key_when_left_alt_is_pressed = false  -- left  Option -> Alt/Meta (ESC prefix)
config.send_composed_key_when_right_alt_is_pressed = true  -- right Option -> AltGr   (ä ö ü ß)
config.macos_forward_to_ime_modifier_mask = 'SHIFT|ALT'    -- IME must see Option, else dead keys die

-- Optional: kitty keyboard protocol -- lets NeoVim 0.12 distinguish e.g.
-- CTRL+I from Tab or CTRL+SHIFT+<key>. Enable if you use such mappings.
-- config.enable_kitty_keyboard = true

-- Nothing is inherited: no surprise binding can ever swallow a CTRL key again.
config.disable_default_key_bindings = true

config.keys = {
  -- clipboard (Linux style + macOS style, both work)
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'c', mods = 'CMD',        action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD',        action = act.PasteFrom 'Clipboard' },

  -- tabs
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  { key = 't', mods = 'CMD',        action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD',        action = act.CloseCurrentTab { confirm = true } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- windows
  { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
  { key = 'n', mods = 'CMD',        action = act.SpawnWindow },
  { key = 'q', mods = 'CMD',        action = act.QuitApplication },
  { key = 'm', mods = 'CMD',        action = act.Hide },
  { key = 'Enter', mods = 'CMD',    action = act.ToggleFullScreen },
  { key = 'F11',   mods = 'NONE',   action = act.ToggleFullScreen },

  -- panes (kitty: CTRL+SHIFT+Enter opens a new one)
  { key = 'Enter',      mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'o',          mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = ']',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Next' },
  { key = '[',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Prev' },
  { key = 'x',          mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'z',          mods = 'CTRL|SHIFT', action = act.TogglePaneZoomState },

  -- scrolling: Shift+PageUp/Down as on every Linux terminal
  { key = 'PageUp',   mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  { key = 'UpArrow',   mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
  { key = 'Home', mods = 'CTRL|SHIFT', action = act.ScrollToTop },
  { key = 'End',  mods = 'CTRL|SHIFT', action = act.ScrollToBottom },

  -- search / scrollback
  { key = 'f', mods = 'CTRL|SHIFT', action = act.Search { CaseInSensitiveString = '' } },
  { key = 'f', mods = 'CMD',        action = act.Search { CaseInSensitiveString = '' } },
  { key = 'k', mods = 'CMD',        action = act.ClearScrollback 'ScrollbackOnly' },

  -- font size
  { key = '+',         mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
  { key = '-',         mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
  { key = 'Backspace', mods = 'CTRL|SHIFT', action = act.ResetFontSize },
  { key = '+',         mods = 'CMD',        action = act.IncreaseFontSize },
  { key = '-',         mods = 'CMD',        action = act.DecreaseFontSize },
  { key = '0',         mods = 'CMD',        action = act.ResetFontSize },

  -- copy mode (vi keys in the scrollback) + quick select
  { key = 'Space', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
  { key = 'u',     mods = 'CTRL|SHIFT', action = act.QuickSelect },
  { key = 'p',     mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'l',     mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
}

-- Middle-click pastes the selection, as under X11/Wayland.
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Middle' } },
    mods = 'NONE',
    action = act.PasteFrom 'PrimarySelection',
  },
}

return config
