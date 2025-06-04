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
				local transparent_background = require("catppuccin").options.transparent_background
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

				local huefyns = vim.api.nvim_create_namespace("Huefy")
				local huefyinputns = vim.api.nvim_create_namespace("HuefyInput")
				local huefytoolsns = vim.api.nvim_create_namespace("HuefyTools")
				local shadesns = vim.api.nvim_create_namespace("NvShades")
				local set_hl = vim.api.nvim_set_hl

				set_hl(huefyns, "ExDarkBg", { bg = transparent_background and colors.none or colors.base })
				set_hl(huefyns, "ExDarkBorder", { link = "FloatBorder" })
				set_hl(
					huefyns,
					"ExBlack3bg",
					{ bg = transparent_background and colors.none or colors.base, link = "FloatTitle" }
				)

				set_hl(huefyinputns, "ExBlack2border", { link = "FloatBorder" })
				set_hl(huefyinputns, "ExBlack2Bg", { bg = transparent_background and colors.none or colors.base })

				set_hl(huefytoolsns, "ExBlack2border", { link = "FloatBorder" })
				set_hl(huefytoolsns, "ExBlack2Bg", { bg = transparent_background and colors.none or colors.base })

				set_hl(shadesns, "ExBlack2border", { link = "FloatBorder" })
				set_hl(shadesns, "ExBlack2Bg", { bg = transparent_background and colors.none or colors.base })
				set_hl(
					shadesns,
					"pmenusel",
					{ bg = transparent_background and colors.none or colors.base, link = "FloatTitle" }
				)
				set_hl(shadesns, "ExRed", { fg = colors.red })
				set_hl(shadesns, "ExGreen", { fg = colors.green })
				set_hl(shadesns, "Function", { fg = colors.text })

				return vim.tbl_deep_extend("force", {
					FloatTitle = { fg = colors.text },
					FloatBorder = { fg = colors[accent_name] },
					LineNr = { fg = (transparent_background and colors.overlay0) or colors.surface1 },

					-- LSP saga
					SagaBorder = { link = "FloatBorder" },

					-- Neotree
					NeoTreeDirectoryName = { fg = colors[accent_name] },
					NeoTreeDirectoryIcon = { fg = colors[accent_name] },
					NeoTreeRootName = { fg = colors[accent_name], bold = true },
					NeoTreeTitleBar = { fg = colors.mantle, bg = colors[accent_name] },

					-- Noice
					NoiceCmdlinePopupBorder = { link = "FloatBorder" },
					NoiceCmdlineIcon = { fg = colors[accent_name] },

					-- Cmp
					CmpGhostText = { link = "Comment", default = true },

					CmpItemMenu = { fg = colors.overlay0 },
					CmpPmenu = { bg = (transparent_background and colors.none) or colors.base },
					CmpItemAbbr = { fg = colors.subtext0, italic = true, bold = false },
					CmpItemAbbrMatch = { fg = colors.text, italic = false, bold = true },
					CmpSel = { bg = colors[accent_name], fg = colors.base },
				}, cmp_hl)
			end,
		},
	},
}
