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

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
function M.get_pkg_path(pkg, path, opts)
	pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
	opts = opts or {}
	opts.warn = opts.warn == nil and true or opts.warn
	path = path or ""
	local ret = root .. "/packages/" .. pkg .. "/" .. path
	if opts.warn and not vim.loop.fs_stat(ret) and not require("lazy.core.config").headless() then
		M.warn(
			("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(
				pkg,
				path
			)
		)
	end
	return ret
end

return M
