local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 18.0
config.font_rules = {
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font {
            family = 'VictorMono Nerd Font',
            weight = 'Bold',
            style = 'Italic'
        }
    }, {
        italic = true,
        intensity = 'Half',
        font = wezterm.font {
            family = 'VictorMono Nerd Font',
            weight = 'DemiBold',
            style = 'Italic'
        }
    }, {
        italic = true,
        intensity = 'Normal',
        font = wezterm.font {family = 'VictorMono Nerd Font', style = 'Italic'}
    }
}

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
