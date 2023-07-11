local M = {}

M.log_module_failed_load = function(module_name)
	vim.notify("Failed to load module", vim.log.levels.WARN,
		{ title = module_name })
end

M.check_module_installed = function(module_name)
	local ok, _ = pcall(require, module_name)

	if not ok then
		M.log_module_failed_load(module_name)
		return false
	end

	return true
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

return M
