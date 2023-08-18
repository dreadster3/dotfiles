return {
    {
        "nvim-telescope/telescope.nvim",
		name = "telescope",
        dependencies = {"nvim-lua/plenary.nvim"},
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find Files"
			}
		},
		config = function (_, opts)
			opts = vim.tbl_deep_extend("force", {
                mappings = {n = {["q"] = require("telescope.actions").close}}
			}, opts or {})
		end,
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "obj", "bin", "node_modules", "build", "target"
                },
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8
                    },
                    vertical = {mirror = false},
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120
                },
                borderchars = {
                    "─", "│", "─", "│", "╭", "╮", "╯", "╰"
                },
            },
            extensions = {}
        }
    },
	{
		"kdheepak/lazygit.nvim",
		name = "lazygit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>g",
				"<CMD>LazyGit<CR>",
				desc = "Lanch lazygit"
			}
		}
	}
}
