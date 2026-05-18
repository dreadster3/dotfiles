local M = {}

--- Title case a string, replacing underscores with spaces and capitalizing the first letter of each word
---@param str string
---@return string title_cased_str
function M.title(str)
	str = str:gsub("_", " ")
	str = str:gsub("%f[%w](%w)", string.upper)
	return str
end

return M
