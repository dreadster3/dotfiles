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
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		event = { "BufReadPre" },
		cmd = { "TSManager" },
		config = function()
			require("tree-sitter-manager").setup({
				-- Default Options
				ensure_installed = {
					"bash",
					"diff",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"printf",
					"python",
					"query",
					"regex",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = true, -- if enabled, install missing parsers when editing a new file
				-- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
				-- highlight = true, -- treesitter highlighting is enabled by default
				-- languages = {}, -- override or add new parser sources
				-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
				-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
			})
		end,
	},
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

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		-- INFO: taken from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				-- LazyVim extention to create buffer-local keymaps
				keys = {
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			local function attach(buf)
				if not vim.tbl_get(opts, "move", "enable") then
					return
				end
				---@type table<string, table<string, string>>
				local moves = vim.tbl_get(opts, "move", "keys") or {}
				for method, keymaps in pairs(moves) do
					for key, query in pairs(keymaps) do
						local queries = type(query) == "table" and query or { query }
						local parts = {}
						for _, q in ipairs(queries) do
							local part = q:gsub("@", ""):gsub("%..*", "")
							part = part:sub(1, 1):upper() .. part:sub(2)
							table.insert(parts, part)
						end
						local desc = table.concat(parts, " or ")
						desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
						desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
						vim.keymap.set({ "n", "x", "o" }, key, function()
							if vim.wo.diff and key:find("[cC]") then
								return vim.cmd("normal! " .. key)
							end
							require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
						end, {
							buffer = buf,
							desc = desc,
							silent = true,
						})
					end
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			vim.tbl_map(attach, vim.api.nvim_list_bufs())
		end,
	},
}
