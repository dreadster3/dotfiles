return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		version = "*",
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
		opts = {
			transparent_background = true,
			integrations = {
				treesitter = true,
				blink_cmp = false,
				cmp = true,
				gitsigns = true,
				lsp_saga = true,
				mason = true,
				notify = true,
				telescope = { enabled = true },
				dap = true,
				alpha = true,
				markdown = true,
				which_key = true,
				nvimtree = true,
				neotree = true,
				illuminate = true,
				lsp_trouble = true,
			},

			--- @module 'catppuccin'
			--- @param colors CtpColors<string>
			custom_highlights = function(colors)
				local accent_name = require("dreadster.utils.ui").get_accent_name()
				local generate_color = require("dreadster.utils.colors").mix

				local cmp_hl = {
					CmpItemKindSnippet = { fg = colors.mauve },
					CmpItemKindKeyword = { fg = colors.red },
					CmpItemKindText = { fg = colors.teal },
					CmpItemKindMethod = { fg = colors.blue },
					CmpItemKindConstructor = { fg = colors.blue },
					CmpItemKindFunction = { fg = colors.blue },
					CmpItemKindFolder = { fg = colors.blue },
					CmpItemKindModule = { fg = colors.blue },
					CmpItemKindConstant = { fg = colors.peach },
					CmpItemKindField = { fg = colors.green },
					CmpItemKindProperty = { fg = colors.green },
					CmpItemKindEnum = { fg = colors.green },
					CmpItemKindUnit = { fg = colors.green },
					CmpItemKindClass = { fg = colors.yellow },
					CmpItemKindVariable = { fg = colors.flamingo },
					CmpItemKindFile = { fg = colors.blue },
					CmpItemKindInterface = { fg = colors.yellow },
					CmpItemKindColor = { fg = colors.red },
					CmpItemKindReference = { fg = colors.red },
					CmpItemKindEnumMember = { fg = colors.red },
					CmpItemKindStruct = { fg = colors.blue },
					CmpItemKindValue = { fg = colors.peach },
					CmpItemKindEvent = { fg = colors.blue },
					CmpItemKindOperator = { fg = colors.blue },
					CmpItemKindTypeParameter = { fg = colors.blue },
					CmpItemKindCopilot = { fg = colors.green },
					CmpItemKindCodeium = { fg = colors.green },
				}

				for key, value in pairs(cmp_hl) do
					cmp_hl[key] = {
						fg = value.fg,
						bg = generate_color(value.fg, colors.base, 70),
					}
				end

				return vim.tbl_deep_extend("force", {
					FloatBorder = { fg = colors[accent_name] },
					FloatTitle = { fg = colors.text },

					-- LSP saga
					SagaBorder = { fg = colors[accent_name] },

					-- Neotree
					NeoTreeDirectoryName = { fg = colors[accent_name] },
					NeoTreeDirectoryIcon = { fg = colors[accent_name] },
					NeoTreeRootName = { fg = colors[accent_name], bold = true },
					NeoTreeTitleBar = { fg = colors.mantle, bg = colors[accent_name] },

					-- Noice
					NoiceCmdlinePopupBorder = { fg = colors[accent_name] },
					NoiceCmdlineIcon = { fg = colors[accent_name] },

					-- Cmp
					CmpGhostText = { link = "Comment", default = true },

					CmpItemMenu = { fg = colors.overlay0 },
					CmpPmenu = { bg = colors.base },
					CmpItemAbbr = { fg = colors.subtext0, italic = true, bold = false },
					CmpItemAbbrMatch = { fg = colors.text, italic = false, bold = true },
					CmpSel = { bg = colors[accent_name], fg = colors.base },
				}, cmp_hl)
			end,
		},
	},
}
