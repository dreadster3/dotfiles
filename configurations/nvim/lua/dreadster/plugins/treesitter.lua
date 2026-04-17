return {
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	enabled = false,
	-- 	main = "nvim-treesitter.configs",
	-- 	dependencies = {
	-- 		"nvim-treesitter/playground",
	-- 		"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	},
	-- 	build = ":TSUpdate",
	-- 	version = false,
	-- 	event = { "BufReadPre", "BufWritePre", "BufNewFile", "VeryLazy" },
	-- 	lazy = vim.fn.argc(-1) == 0,
	-- 	init = function(plugin)
	-- 		require("lazy.core.loader").add_to_rtp(plugin)
	-- 		require("nvim-treesitter.query_predicates")
	-- 	end,
	-- 	---@type TSConfig
	-- 	---@diagnostic disable-next-line: missing-fields
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"bash",
	-- 			"diff",
	-- 			"json",
	-- 			"lua",
	-- 			"markdown",
	-- 			"markdown_inline",
	-- 			"printf",
	-- 			"python",
	-- 			"query",
	-- 			"regex",
	-- 			"vim",
	-- 			"vimdoc",
	-- 			"yaml",
	-- 		},
	-- 		auto_install = true,
	-- 		sync_install = false,
	-- 		highlight = { enable = true },
	-- 		indent = { enable = true },
	-- 		incremental_selection = {
	-- 			enable = true,
	-- 			keymaps = {
	-- 				init_selection = "<C-space>",
	-- 				node_incremental = "<C-space>",
	-- 				scope_incremental = false,
	-- 				node_decremental = "<bs>",
	-- 			},
	-- 		},
	-- 		context_commentstring = { enable = true },
	-- 		playground = {
	-- 			enable = true,
	-- 		},
	-- 		textobjects = {
	-- 			move = {
	-- 				enable = true,
	-- 				set_jumps = true,
	-- 				goto_next_start = {
	-- 					["]f"] = "@function.outer",
	-- 					["]c"] = "@class.outer",
	-- 					["]a"] = "@parameter.inner",
	-- 				},
	-- 				goto_next_end = {
	-- 					["]F"] = "@function.outer",
	-- 					["]C"] = "@class.outer",
	-- 					["]A"] = "@parameter.inner",
	-- 				},
	-- 				goto_previous_start = {
	-- 					["[f"] = "@function.outer",
	-- 					["[c"] = "@class.outer",
	-- 					["[a"] = "@parameter.inner",
	-- 				},
	-- 				goto_previous_end = {
	-- 					["[F"] = "@function.outer",
	-- 					["[C"] = "@class.outer",
	-- 					["[A"] = "@parameter.inner",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"nvim-treesitter/nvim-treesitter-context",
		name = "treesitter-context",
		cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			mode = "cursor",
			max_lines = 3,
		},
	},
}
