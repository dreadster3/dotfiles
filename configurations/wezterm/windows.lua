local config = {}
local wezterm = require('wezterm')

config.background = {
    {
        source = {Color = "#1e1e2e"},
        width = "100%",
        height = "100%",
        opacity = 1.0,
        attachment = "Fixed"
    }, {
        source = {
            File = os.getenv("HOME") .. "\\.config\\wallpapers\\cat_bunnies.png"
        },
        opacity = 0.2,
        hsb = {brightness = 1.8, saturation = 1.0, hue = 1.0},
        attachment = "Fixed"
    }
}

config.keys = {
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane {confirm = true}
    }, {
        key = 'Enter',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(require('utils').split_pane)
    },
    {
        key = "/",
        mods = "CTRL",
        action = wezterm.action {SendString = "\x1b[47;5u"}
    }

}

config.default_prog = {"wsl", "~"}

return config
