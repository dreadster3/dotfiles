return {
	{
		"romus204/tree-sitter-manager.nvim",
		event = { "BufReadPre" },
		cmd = { "TSManager" },
		config = function()
			require("tree-sitter-manager").setup({
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
				auto_install = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		version = "*",
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
