local M = {}

--- Check if a module is installed and log a warning if it is not
---@param module_name name of the module to check
M.log_module_failed_load = function(module_name)
	vim.notify("Failed to load module", vim.log.levels.WARN, { title = module_name })
end

--- Check if a module is installed
---@param  module_name string of the module to check
---@return boolean true if the module is installed, false otherwise
M.check_module_installed = function(module_name)
	local ok, _ = pcall(require, module_name)

	if not ok then
		M.log_module_failed_load(module_name)
		return false
	end

	return true
end

M.is_mac = function()
	return vim.fn.has("macunix") == 1
end

M.is_linux = function()
	local uname = vim.loop.os_uname()

	return uname.sysname == "Linux"
end

M.is_wsl = function()
	local uname = vim.loop.os_uname()

	local is_microsoft = uname.release:find("microsoft") ~= nil

	return M.is_linux() and is_microsoft
end

M.is_in_table = function(table, element)
	for _, value in ipairs(table) do
		if value == element then
			return true
		end
	end

	return false
end

M.filter_sources = function(sources)
	local filtered_sources = {}
	for _, value in pairs(sources) do
		local command = value._opts.command

		if command and vim.fn.executable(command) == 1 then
			table.insert(filtered_sources, value)
		end
	end

	return filtered_sources
end

return M
