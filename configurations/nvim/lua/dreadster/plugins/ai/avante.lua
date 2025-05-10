return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = function()
			local utils = require("dreadster.utils")
			return not utils.is_mac()
		end,
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "openai",
			openai = {
				model = "gpt-4o",
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick",
			"icons",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				"render-markdown",
				optional = true,
				opts = {
					file_types = { "Avante" },
				},
				ft = { "Avante" },
			},
		},
	},
}
