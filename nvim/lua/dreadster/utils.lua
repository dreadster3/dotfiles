local M = {}

M.log_module_failed_load = function (module_name)
	vim.notify("Failed to load module", "WARN", {
		title = module_name
	})
end

return M
