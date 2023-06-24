local utils = require("dreadster.utils")
local module_name = "lualine"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

-- Add word count to lua line when editing tex files
local function wordcount()
	if vim.bo.filetype ~= "tex" then
		return ""
	end

	if vim.fn.executable("texcount") == 0 then
		vim.notify("texcount not found", vim.log.levels.WARN)
		return ""
	end

	local out = vim.fn.system("texcount -inc -1 -sum " .. vim.fn.expand("%"))
	out = string.gsub(out, "%s+", "")

	return out .. " words"
end

local lualine_z = {
	'location',
	wordcount
}

require('lualine').setup({
	sections = {
		lualine_z = lualine_z,
	}
})
