local wezterm = require('wezterm')
local utils = require("utils")
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
	font = wezterm.font { family = 'VictorMono Nerd Font', style = 'Italic' }
}
}

config.color_scheme = 'Catppuccin Mocha'
config.tab_bar_at_bottom = true
config.background = {
	{
		source = {
			File = os.getenv("HOME") ..
				"/Documents/projects/github/dotfiles/wallpapers/cat_bunnies.png"
		},
		opacity = 1.0,
		hsb = { brightness = 0.0, saturation = 1.0, hue = 1.0 },
		attachment = "Fixed"
	}, {
	source = {
		File = os.getenv("HOME") ..
			"/Documents/projects/github/dotfiles/wallpapers/cat_bunnies.png"
	},
	opacity = 0.2,
	hsb = { brightness = 1.8, saturation = 1.0, hue = 1.0 },
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
        action = wezterm.action.CloseCurrentPane {confirm = false}
    }, {
        key = 'Enter',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(utils.split_pane)
    }, {
        key = "LeftArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTabRelative(-1)
    }, {
        key = "RightArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTabRelative(1)
    }
}

if utils.is_mac() then
	local macos = require("macos")
	config = utils.merge({ config, macos })
end

if utils.is_linux() then
	local windows = require("linux")
	config = utils.merge({ config, windows })
end

if utils.is_windows() then
	local windows = require("windows")
	config = utils.merge({ config, windows })
end

return config
