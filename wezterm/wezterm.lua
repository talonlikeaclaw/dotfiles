local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Settings
config.color_scheme = 'Catppuccin Mocha'
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.94
config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font', scale = 1.4 },
}
config.window_close_confirmation = 'NeverPrompt'
config.scrollback_lines = 3000
config.use_fancy_tab_bar = false
config.audible_bell = 'Disabled'
config.window_padding = {
  left = 25,
  right = 25,
  top = 25,
  bottom = 25,
}

-- Keys
config.leader = { key = 'w', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 't', mods = 'LEADER', action = act.SpawnTab 'DefaultDomain' },
  { key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentTab { confirm = true } },
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
}

-- and finally, return the configuration to wezterm
return config
