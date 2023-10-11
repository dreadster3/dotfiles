-- Mac specific configurations
local config = {}

config.background = {
	{
		source = {
			File = "/Users/n8266378/Documents/projects/github/dotfiles/wallpapers/cat_bunnies.png"
		},
		opacity = 1.0,
		hsb = { brightness = 0.0, saturation = 1.0, hue = 1.0 },
		attachment = "Fixed"
	}, {
	source = {
		File = "/Users/n8266378/Documents/projects/github/dotfiles/wallpapers/gradient-synth-cat.png"
	},
	opacity = 0.2,
	hsb = { brightness = 1.8, saturation = 1.0, hue = 1.0 },
	attachment = "Fixed"
}
}

config.font_size = 20

return config
