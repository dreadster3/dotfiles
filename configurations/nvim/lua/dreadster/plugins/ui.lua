return {
	{
		"nvim-tree/nvim-tree.lua",
		name = "nvimtree",
		lazy = false,
		dependencies = { "devicons" },
		keys = { { "<leader>e", ":NvimTreeFocus<CR>", desc = "Focus nvim tree" } },
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			sync_root_with_cwd = true,
			actions = {
				change_dir = { enable = true, global = true },
				open_file = { quit_on_open = true }
			},
			live_filter = { always_show_folders = false }
		}
	}, {
	"rcarriga/nvim-notify",
	name = "notify",
	lazy = false,
	init = function() vim.notify = require("notify") end,
	opts = {
		background_colour = "#000000",
		render = "compact",
		max_width = 50,
		top_down = false,
		max_height = 3
	}
}, {
	"petertriho/nvim-scrollbar",
	name = "scrollbar",
	config = function(_, opts)
		require("scrollbar").setup(opts)
		require("scrollbar.handlers.gitsigns").setup()
	end,
	opts = { handlers = { cursor = false } }
}, {
	"lewis6991/gitsigns.nvim",
	name = "gitsigns",
	opts = { current_line_blame = true }
}, {
	"folke/trouble.nvim",
	cmd = "TroubleToggle",
	keys = { { "<leader>gl", ":TroubleToggle<CR>", desc = "Toggle trouble" } }
}, {
	"j-hui/fidget.nvim",
	cond = false,
	name = "fidget",
	event = "LspAttach",
	tag = "legacy",
	opts = { text = { spinner = "arc" } }
}, {
	"akinsho/bufferline.nvim",
	name = "bufferline",
	dependencies = { "devicons" },
	event = "BufReadPost",
	keys = {
		{
			"˙",
			":BufferLineCyclePrev<CR>",
			desc = "Cycle to previous buffer in buffer line"
		}, {
		"¬",
		":BufferLineCycleNext<CR>",
		desc = "Cycle to next buffer in buffer line"
	}, {
		"<A-l>",
		":BufferLineCycleNext<CR>",
		desc = "Cycle to next buffer in buffer line"
	}, {
		"<A-h>",
		":BufferLineCyclePrev<CR>",
		desc = "Cycle to previous buffer in buffer line"
	}
	},
	opts = {
		options = {
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center"
				}
			}
		}
	}
}, {
	"nvim-lualine/lualine.nvim",
	name = "lualine",
	event = "BufReadPost",
	dependencies = { "devicons" },
	opts = {}
}, { "levouh/tint.nvim", name = "tint", opts = {} }, {
	"kevinhwang91/rnvimr",
	name = "rnvimr",
	cmd = "RnvimrToggle",
	keys = {
		{ "<C-e>", ":RnvimrToggle<CR>", desc = "Toggle ranger file explorer" },
		{
			"<C-r>",
			"<C-\\><C-n>:RnvimrResize<CR>",
			desc = "Resize ranger file explorer",
			mode = "t"
		}, {
		"<C-e>",
		"<C-\\><C-n>:RnvimrToggle<CR>",
		desc = "Resize ranger file explorer",
		mode = "t"
	}
	}
}, {
	"goolord/alpha-nvim",
	event = "VimEnter",
	name = "alpha",
	opts = function(_, opts)
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]]
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file",
				":Telescope find_files <CR>"),
			dashboard.button("e", "  New file",
				":ene <BAR> startinsert <CR>"),
			dashboard.button("p", "  Find project",
				":lua vim.cmd([[Telescope projects]])<CR>"),
			dashboard.button("r", "  Recently used files",
				":Telescope oldfiles <CR>"),
			dashboard.button("t", "󱎸  Find text",
				":Telescope live_grep <CR>"),
			dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
			dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>")
		}

		-- dashboard.opts.opts.noautocmd = true

		return dashboard
	end,
	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end
			})
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val =
					"⚡ Neovim loaded " .. stats.count .. " plugins in " ..
					ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end
		})
	end
}, {
	"folke/noice.nvim",
	name = "noice",
	event = "VeryLazy",
	version = "*",
	dependencies = { "notify", "MunifTanjim/nui.nvim" },
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true
			}
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true,             -- use a classic bottom cmdline for search
			command_palette = true,           -- position the cmdline and popupmenu together
			long_message_to_split = true,     -- long messages will be sent to a split
			inc_rename = false,               -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false            -- add a border to hover docs and signature help
		},
		messages = { enabled = false }
	}
}, {
	"folke/zen-mode.nvim",
	name = "zenmode",
	cmd = "ZenMode",
	keys = { { "<leader>z", ":ZenMode<CR>", desc = "Toggle zen mode" } },
	opts = {}
}, {
	"folke/twilight.nvim",
	-- enabled = false,
	name = "twilight",
	cmd = "Twilight",
	opts = { treesitter = true, context = 10 }
}, {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	opts = {}
}, {
	"nvim-tree/nvim-web-devicons",
	name = "devicons",
	lazy = true,
	config = function(_, opts)
		require("nvim-web-devicons").setup(opts)
	end,
	opts = {
		color_icons = true,
		default = true,
		override = {
			js = { icon = "󰌞", color = "#F7DF1E", name = "Javascript" },
			cjs = { icon = "󰌞", color = "#F7DF1E", name = "Javascript" },
			ts = { icon = "󰛦", color = "#007ACC", name = "Typescript" },
			astro = { icon = "", color = "#FA7A0A", name = "Astro" }
		},
		override_by_filename = {
			["tailwind.config.cjs"] = {
				icon = "󱏿",
				color = "#06B6D4",
				name = "Tailwind"
			},
			[".prettierrc"] = {
				icon = "󰬗",
				color = "#7242ED",
				name = "Prettier"
			}
		}
	}
}
}
