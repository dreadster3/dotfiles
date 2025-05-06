local M = {}

--- @param name string
--- @return boolean
function M.is_loaded(name)
	local config = require("lazy.core.config")
	return (config.plugins[name] and config.plugins[name]._.loaded)
end

--- @param name string
--- @param fn fun(name: string)
function M.on_load(name, fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

---@param name string Name of the telescope extension to load
function M.lazy_load_telescope_extension(name)
	M.on_load("telescope.nvim", function()
		require("telescope").load_extension(name)
	end)
end

return M
