local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 18.0
config.color_scheme = 'Catppuccin Mocha'
config.tab_bar_at_bottom = true
config.background = {
    {
        source = {
            File = "/home/dreadster/Documents/projects/github/dotfiles/wallpapers/cat_bunnies.png"
        },
        opacity = 1.0,
        hsb = {brightness = 0.0, saturation = 1.0, hue = 1.0},
        attachment = "Fixed"
    }, {
        source = {
            File = "/home/dreadster/Documents/projects/github/dotfiles/wallpapers/cat_bunnies.png"
        },
        opacity = 0.2,
        hsb = {brightness = 1.8, saturation = 1.0, hue = 1.0},
        attachment = "Fixed"
    }
}
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane {confirm = true}
    }, {
        key = 'Enter',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(require('utils').split_pane)
    }

}

return config
