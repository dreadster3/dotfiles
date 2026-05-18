local M = {}

--- Gets the catppuccin accent name
---@return string accent_name
function M.get_accent_name()
	local accent = vim.fn.getenv("CATPPUCCIN_ACCENT")

	if accent == "" or accent == vim.NIL then
		accent = "blue"
	end

	return accent
end

--- Gets the catppuccin accent color
---@return string accent_color
function M.get_accent_color()
	local accent_name = M.get_accent_name()

	local pallet = require("catppuccin.palettes").get_palette()

	return pallet[accent_name]
end

M.lsp_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "󰀫",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
	Misc = "",
	Copilot = "",
	Codeium = "󰘦",
	Supermaven = "",

	-- source icons
	Git = "",
	Emoji = "",
}

return M
