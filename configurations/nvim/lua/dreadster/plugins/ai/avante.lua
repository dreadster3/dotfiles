return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		version = false, -- set this if you want to always pull the latest change
		---@class avante.Config
		opts = {
			provider = "gemini",
			auto_suggestions_provider = "gemini",
			providers = {
				openai = {
					model = "o4-mini",
				},
				claude = {
					model = "claude-sonnet-4-20250514",
				},
				gemini = {
					model = "gemini-2.5-flash-preview-05-20",
				},
				["claude-opus-4"] = {
					__inherited_from = "claude",
					model = "claude-opus-4-20250514",
				},
			},
			behaviour = {
				auto_suggestions = false,
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter",
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
				ft = { "Avante" },
				--- @module 'render-markdown'
				--- @param opts render.md.UserConfig
				opts = function(_, opts)
					table.insert(opts.file_types, "Avante")
					return opts
				end,
			},
		},
	},
}
